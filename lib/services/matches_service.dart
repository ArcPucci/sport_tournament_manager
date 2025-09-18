import 'package:sport_tournament_manager/models/models.dart';
import 'package:sqflite/sqflite.dart';

const matchesTable = 'MATCHES_TABLE';

class MatchesService {
  final Database _database;

  MatchesService(this._database);

  Future<void> createMatch(GameMatch match) async {
    final map = match.toMap();
    map['id'] = null;
    await _database.insert(matchesTable, map);
  }

  Future<List<GameMatch>> getMatchesByFormat(
    int tournamentId,
    String format,
  ) async {
    final maps = await _database.query(
      matchesTable,
      where: 'tournament_id = ? AND format = ?',
      whereArgs: [tournamentId, format],
    );

    if (maps.isEmpty) return [];

    return maps.map(GameMatch.fromMap).toList();
  }

  Future<List<GameMatch>> getMatchesByTournament(int tournamentId) async {
    final maps = await _database.query(
      matchesTable,
      where: 'tournament_id = ?',
      whereArgs: [tournamentId],
    );

    if (maps.isEmpty) return [];

    return maps.map(GameMatch.fromMap).toList();
  }

  Future<void> updateMatch(GameMatch match) async {
    await _database.update(
      matchesTable,
      match.toMap(),
      where: 'id = ?',
      whereArgs: [match.id],
    );
  }

  Future<void> saveMatches(List<GameMatch> matches) async {
    for (final match in matches) {
      await createMatch(match);
    }
  }

  Future<void> deleteMatch(int id) async {
    await _database.delete(matchesTable, where: 'id = ?', whereArgs: [id]);
  }
}
