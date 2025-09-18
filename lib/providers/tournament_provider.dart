import 'package:flutter/material.dart';
import 'package:sport_tournament_manager/models/models.dart';
import 'package:sport_tournament_manager/providers/providers.dart';
import 'package:sport_tournament_manager/services/services.dart';
import 'package:sport_tournament_manager/utils/formats.dart';

class TournamentProvider extends ChangeNotifier {
  final MatchesService _matchesService;
  final TournamentsProvider _tournamentsProvider;
  final void Function(String) showMessage;

  TournamentProvider({
    required MatchesService matchesService,
    required TournamentsProvider tournamentsProvider,
    required this.showMessage,
  }) : _matchesService = matchesService,
       _tournamentsProvider = tournamentsProvider {
    init(_tournamentsProvider.tournament);
  }

  Tournament _tournament = Tournament.empty();

  Tournament get tournament => _tournament;

  int _tab = 0;

  int get tab => _tab;

  String _format = "";

  String get format => _format;

  List<GameMatch> _matches = [];

  List<GameMatch> get matches => _matches;

  final List<StandingData> _standingData = [];

  List<StandingData> get standingData => _standingData;

  void init(Tournament tournament) async {
    _tournament = tournament;
    _format = _tournament.formats.first;
    notifyListeners();
    _updateMatches();
  }

  void setTab(int index) {
    _tab = index;
    notifyListeners();
  }

  void editTeamName(int index, String name) {
    if (name.trim().isEmpty) {
      showMessage("Team name can't be empty");
      return;
    }

    if (_tournament.teams.contains(name)) {
      showMessage("$name already exists");
      return;
    }

    _tournament.teams[index] = name;
    _tournamentsProvider.updateTournament(_tournament);
    notifyListeners();
  }

  void deleteTeam(int index) async {
    if (_tournament.teams.length == 2) {
      showMessage('You must have at least 2 teams');
      return;
    }

    _tournament.teams.removeAt(index);
    _tournamentsProvider.updateTournament(_tournament);
    notifyListeners();
  }

  void editPlayerName(int index, String name) {
    if (name.trim().isEmpty) {
      showMessage("Player name can't be empty");
      return;
    }
    _tournament.players[index] = name;
    _tournamentsProvider.updateTournament(_tournament);
    notifyListeners();
  }

  void deletePlayer(int index) {
    if (_tournament.players.length == 1) {
      showMessage('You must have at least 1 player');
      return;
    }
    _tournament.players.removeAt(index);
    _tournamentsProvider.updateTournament(_tournament);
    notifyListeners();
  }

  void editLocationName(int index, String name) {
    if (name.trim().isEmpty) {
      showMessage("Location name can't be empty");
      return;
    }
    _tournament.locations[index] = name;
    _tournamentsProvider.updateTournament(_tournament);
    notifyListeners();
  }

  void deleteLocation(int index) {
    if (_tournament.locations.length == 1) {
      showMessage('You must have at least 1 location');
      return;
    }
    _tournament.locations.removeAt(index);
    _tournamentsProvider.updateTournament(_tournament);
    notifyListeners();
  }

  void changeTournamentName(String name) {
    if (name.trim().isEmpty) {
      showMessage("Tournament name can't be empty");
      return;
    }
    _tournament.name = name;
    _tournamentsProvider.updateTournament(_tournament);
    notifyListeners();
  }

  void setFormat(String text) {
    _format = text;
    notifyListeners();
    _updateMatches();
  }

  void saveMatches(List<GameMatch> matches) async {
    final list = List<GameMatch>.from(
      matches.map((e) {
        e.tournamentId = _tournament.id;
        e.format = _format;
        return e;
      }),
    );

    if (list.isEmpty) {
      final pairs = _makePairs(_tournament.teams);
      final matchesNumber = formatMap[_format];

      for (var i = 0; i < matchesNumber!; i++) {
        final firstTeam = pairs[i % pairs.length][0];
        final secondTeam = pairs[i % pairs.length][1];
        final location =
            _tournament.locations[i % _tournament.locations.length];

        list.add(
          GameMatch(
            id: 0,
            tournamentId: _tournament.id,
            format: _format,
            firstTeam: firstTeam,
            secondTeam: secondTeam,
            location: location,
            created: DateTime.now().add(Duration(days: i)),
            team1Stats: List.generate(9, (index) => 0),
            team2Stats: List.generate(9, (index) => 0),
          ),
        );
      }
    }

    await _matchesService.saveMatches(list);
    notifyListeners();

    _updateMatches();
  }

  void _updateMatches() async {
    _matches = await _matchesService.getMatchesByFormat(
      _tournament.id,
      _format,
    );
    notifyListeners();

    _updateStandings();
  }

  List<List<String>> _makePairs(List<String> items) {
    final pairs = <List<String>>[];

    for (var i = 0; i < items.length; i++) {
      for (var j = i + 1; j < items.length; j++) {
        pairs.add([items[i], items[j]]);
      }
    }

    return [...pairs, ...pairs, ...pairs];
  }

  void saveMatch(GameMatch match) async {
    await _matchesService.updateMatch(match);
    _updateMatches();
  }

  void _updateStandings() async {
    final matches = await _matchesService.getMatchesByTournament(
      _tournament.id,
    );

    _standingData.clear();

    if(matches.isEmpty) return;

    final teams = <String>{};

    for (var item in matches) {
      teams.add(item.firstTeam);
      teams.add(item.secondTeam);
    }

    for (var team in teams) {
      _standingData.add(
        StandingData(
          team: team,
          pf: 0,
          pa: 0,
          stats: List.generate(9, (index) => 0),
        ),
      );
    }

    for (var i = 0; i < _standingData.length; i++) {
      for (var match in matches) {
        if (_standingData[i].team == match.firstTeam) {
          _standingData[i].pf += match.team1Stats[4];
          _standingData[i].pa += match.team2Stats[4];
          _standingData[i].stats = _sumLists(
            _standingData[i].stats,
            match.team1Stats,
          );
        } else if (_standingData[i].team == match.secondTeam) {
          _standingData[i].pf += match.team2Stats[4];
          _standingData[i].pa += match.team1Stats[4];
          _standingData[i].stats = _sumLists(
            _standingData[i].stats,
            match.team2Stats,
          );
        }
      }
    }

    _standingData.sort((a, b) => b.points - a.points);

    notifyListeners();
  }

  List<int> _sumLists(List<int> a, List<int> b) {
    final length = a.length < b.length ? a.length : b.length;
    return List.generate(length, (i) => a[i] + b[i]);
  }

  void deleteMatch(GameMatch match) async {
    await _matchesService.deleteMatch(match.id);
    _updateMatches();
  }
}
