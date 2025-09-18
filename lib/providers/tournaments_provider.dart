import 'package:flutter/material.dart';
import 'package:sport_tournament_manager/services/services.dart';

import '../models/models.dart';

class TournamentsProvider extends ChangeNotifier {
  final TournamentsService _tournamentsService;

  TournamentsProvider({required TournamentsService tournamentsService})
    : _tournamentsService = tournamentsService {
    init();
  }

  Tournament _tournament = Tournament.empty();

  Tournament get tournament => _tournament;

  List<Tournament> _tournaments = [];

  List<Tournament> get tournaments => _tournaments;

  bool _backToTournament = false;

  void init() async {
    _tournaments = await _tournamentsService.getTournaments();
    notifyListeners();
  }

  void createTournament(Tournament tournament) async {
    await _tournamentsService.createTournament(tournament);
    _tournaments = await _tournamentsService.getTournaments();
    notifyListeners();
  }

  void updateTournament(Tournament tournament) async {
    await _tournamentsService.updateTournament(tournament);
    _tournaments = await _tournamentsService.getTournaments();
    notifyListeners();
  }

  void setTournament(Tournament tournament) {
    _tournament = tournament;
  }

  void deleteTournament(Tournament tournament) async {
    await _tournamentsService.deleteTournament(tournament);
    _tournaments = await _tournamentsService.getTournaments();
    notifyListeners();
  }

  void editTournament(Tournament tournament) {
    _tournament = tournament;
    _backToTournament = true;
  }

  void backToTournament() {
    _backToTournament = false;
  }
}
