import 'dart:convert';

class Tournament {
  final int id;
  String name;
  String logo;
  final DateTime created;
  final List<String> players;
  final List<String> teams;
  final List<String> locations;
  final List<String> formats;

  Tournament({
    required this.id,
    required this.name,
    required this.logo,
    required this.created,
    required this.players,
    required this.teams,
    required this.locations,
    required this.formats,
  });

  factory Tournament.empty() => Tournament(
    id: -1,
    name: '',
    logo: 'assets/png/logo3.png',
    created: DateTime.now(),
    players: [],
    teams: [],
    locations: [],
    formats: [],
  );

  Tournament copyWith({
    int? id,
    String? name,
    String? logo,
    DateTime? created,
    List<String>? players,
    List<String>? teams,
    List<String>? locations,
    List<String>? formats,
  }) {
    return Tournament(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      created: created ?? this.created,
      players: players ?? this.players,
      teams: teams ?? this.teams,
      locations: locations ?? this.locations,
      formats: formats ?? this.formats,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'created': created.microsecondsSinceEpoch,
      'players': jsonEncode(players),
      'teams': jsonEncode(teams),
      'locations': jsonEncode(locations),
      'formats': jsonEncode(formats),
    };
  }

  factory Tournament.fromMap(Map<String, dynamic> map) {
    final players = (jsonDecode(map['players']) as List<dynamic>)
        .cast<String>();
    final teams = (jsonDecode(map['teams']) as List<dynamic>).cast<String>();
    final locations = (jsonDecode(map['locations']) as List<dynamic>)
        .cast<String>();
    final formats = (jsonDecode(map['formats']) as List<dynamic>)
        .cast<String>();

    return Tournament(
      id: map['id'] as int,
      name: map['name'] as String,
      logo: map['logo'] as String,
      created: DateTime.fromMicrosecondsSinceEpoch(map['created'] as int),
      players: players,
      teams: teams,
      locations: locations,
      formats: formats,
    );
  }
}
