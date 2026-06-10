import 'package:batterylevel/sql_lite/model/dog.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DogDatabase {
  static final DogDatabase instance = DogDatabase._init();
  static Database? _database;

  DogDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('doggie_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dogs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL
      )
    ''');
  }

  Future<void> insertDog(Dog dog) async {
    final db = await instance.database;
    await db.insert('dogs', dog.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Dog>> readAllDogs() async {
    final db = await instance.database;
    final result = await db.query('dogs', orderBy: 'id DESC');

    return result.map((json) => Dog.fromJson(json)).toList();
  }

  Future<void> deleteDog(int id) async {
    final db = await instance.database;
    await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
