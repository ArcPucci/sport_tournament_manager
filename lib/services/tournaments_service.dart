import 'package:sport_tournament_manager/models/models.dart';
import 'package:sqflite/sqflite.dart';

const tournamentsTable = 'TOURNAMENTS_TABLE';

class TournamentsService {
  final Database _database;

  TournamentsService(this._database);

  Future<void> createTournament(Tournament tournament) async {
    final map = tournament.toMap();
    map['id'] = null;

    await _database.insert(tournamentsTable, map);
  }

  Future<void> updateTournament(Tournament tournament) async {
    await _database.update(
      tournamentsTable,
      tournament.toMap(),
      where: 'id = ?',
      whereArgs: [tournament.id],
    );
  }

  Future<List<Tournament>> getTournaments() async {
    final result = await _database.query(tournamentsTable);
    if (result.isEmpty) return [];

    return result.map(Tournament.fromMap).toList();
  }

  Future<void> deleteTournament(Tournament tournament) async {
    await _database.delete(
      tournamentsTable,
      where: 'id = ?',
      whereArgs: [tournament.id],
    );
  }
}
