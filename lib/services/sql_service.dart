import 'dart:async';
import 'package:path/path.dart';
import 'package:sport_tournament_manager/services/services.dart';
import 'package:sqflite/sqflite.dart';

const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
const uuidType = "TEXT PRIMARY KEY";
const boolType = "BOOLEAN DEFAULT FALSE";
const intType = "INTEGER NOT NULL";
const textType = "TEXT NOT NULL";
const blobType = "BLOB NOT NULL";
const timestampType = "DATETIME DEFAULT CURRENT_TIMESTAMP";
const doubleType = "REAL DEFAULT 0";
const textOrNullType = "TEXT DEFAULT NULL";

class SqlService {
  static final SqlService _instance = SqlService._();

  static Database? _database;

  SqlService._();

  factory SqlService() => _instance;

  Database get database => _database!;

  Future<void> init() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'sport_profile.db');

    _database = await openDatabase(path, version: 1, onCreate: _createDB);
  }

  FutureOr<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tournamentsTable (
        id $idType,
        name $textType,
        logo $textType,
        created $intType,
        players $textType,
        teams $textType,
        locations $textType,
        formats $textType
      )
    ''');
    await db.execute('''
      CREATE TABLE $matchesTable (
        id $idType,
        tournament_id $intType,
        format $textType,
        first_team $textType,
        second_team $textType,
        created $intType,
        location $textType,
        team1_stats $textType,
        team2_stats $textType
      )
    ''');
  }

  Future<void> close() async {
    _database?.close();
  }
}
