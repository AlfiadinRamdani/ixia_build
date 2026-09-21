import 'package:ixia_build/tugas12/user12.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  // Mengambil database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('user.db');

    return _database!;
  }

  // Membuat database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Membuat tabel
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        email TEXT NOT NULL,
        no_hp TEXT NOT NULL,
        password TEXT NOT NULL,
        asal_kota TEXT NOT NULL
      )
    ''');
  }

  // CHECK UNIQUE NAME
  Future<bool> isNamaExist(String nama) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'nama = ?',
      whereArgs: [nama],
    );
    return result.isNotEmpty;
  }

  // CREATE
  Future<int> insertUser(UserModel user) async {
    final db = await instance.database;

    return await db.insert('users', user.toMap());
  }

  // READ ALL
  Future<List<UserModel>> getUsers() async {
    final db = await instance.database;

    final result = await db.query('users', orderBy: 'id DESC');

    return result.map((map) => UserModel.fromMap(map)).toList();
  }
}