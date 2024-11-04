import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'javaDeveloper.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'developers.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE developers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        specialty TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertDeveloper(JavaDeveloper developer) async {
    final db = await database;
    return await db.insert('developers', {
      'name': developer.name,
      'specialty': developer.specialty,
    });
  }

  Future<int> updateDeveloper(JavaDeveloper developer) async {
    final db = await database;
    return await db.update(
      'developers',
      {
        'name': developer.name,
        'specialty': developer.specialty,
      },
      where: 'id = ?',
      whereArgs: [developer.id],
    );
  }


  Future<int> deleteDeveloper(int id) async {
    final db = await database;
    return await db.delete(
    'developers',
    where: 'id = ?',
    whereArgs: [id],
    );
  }

  Future<List<JavaDeveloper>> getDevelopers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('developers');

    return List.generate(
      maps.length,
          (i) => JavaDeveloper(
        id: maps[i]['id'],
        name: maps[i]['name'],
        specialty: maps[i]['specialty'],
      ),
    );
  }
}