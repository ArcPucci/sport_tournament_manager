import 'dart:convert';

class GameMatch {
  final int id;
  int tournamentId;
  String format;
  String firstTeam;
  String secondTeam;
  DateTime? created;
  String location;
  final List<int> team1Stats;
  final List<int> team2Stats;

  GameMatch({
    required this.id,
    required this.tournamentId,
    required this.format,
    required this.firstTeam,
    required this.secondTeam,
    this.created,
    required this.location,
    required this.team1Stats,
    required this.team2Stats,
  });

  bool get canSave =>
      firstTeam.isNotEmpty &&
      secondTeam.isNotEmpty &&
      location.isNotEmpty &&
      created != null;

  factory GameMatch.empty() => GameMatch(
    id: -1,
    tournamentId: -1,
    format: '',
    firstTeam: '',
    secondTeam: '',
    location: '',
    team1Stats: List.generate(9, (index) => 0),
    team2Stats: List.generate(9, (index) => 0),
  );

  GameMatch copyWith({
    int? id,
    int? tournamentId,
    String? format,
    String? firstTeam,
    String? secondTeam,
    DateTime? created,
    String? location,
    List<int>? team1,
    List<int>? team2,
  }) {
    return GameMatch(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      format: format ?? this.format,
      firstTeam: firstTeam ?? this.firstTeam,
      secondTeam: secondTeam ?? this.secondTeam,
      created: created ?? this.created,
      location: location ?? this.location,
      team1Stats: team1 ?? team1Stats,
      team2Stats: team2 ?? team2Stats,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tournament_id': tournamentId,
      'format': format,
      'first_team': firstTeam,
      'second_team': secondTeam,
      'created': created!.microsecondsSinceEpoch,
      'location': location,
      'team1_stats': jsonEncode(team1Stats),
      'team2_stats': jsonEncode(team2Stats),
    };
  }

  factory GameMatch.fromMap(Map<String, dynamic> map) {
    return GameMatch(
      id: map['id'] as int,
      tournamentId: map['tournament_id'] as int,
      format: map['format'] as String,
      firstTeam: map['first_team'] as String,
      secondTeam: map['second_team'] as String,
      created: DateTime.fromMicrosecondsSinceEpoch(map['created'] as int),
      location: map['location'] as String,
      team1Stats: List<int>.from(jsonDecode(map['team1_stats'])),
      team2Stats: List<int>.from(jsonDecode(map['team2_stats'])),
    );
  }
}
