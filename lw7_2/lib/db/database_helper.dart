// db/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/athlete.dart';

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

  // Инициализация базы данных
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'athlete.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Создание таблицы спортсменов
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE athletes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        sport TEXT,
        score INTEGER
      )
    ''');
  }

  // CRUD операции
  Future<int> insertAthlete(Athlete athlete) async {
    final db = await database;
    return await db.insert('athletes', athlete.toMap());
  }

  Future<List<Athlete>> getAthletes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('athletes');

    return List.generate(maps.length, (i) {
      return Athlete.fromMap(maps[i]);
    });
  }

  Future<int> updateAthlete(Athlete athlete) async {
    final db = await database;

    return await db.update(
      'athletes',
      athlete.toMap(), // Преобразуем данные спортсмена в Map
      where: 'id = ?', // Ищем по id
      whereArgs: [athlete.id], // Передаем id как аргумент
    );
  }


  Future<int> deleteAthlete(int id) async {
    final db = await database;
    return await db.delete('athletes', where: 'id = ?', whereArgs: [id]);
  }
}
