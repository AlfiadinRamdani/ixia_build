import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper13 {
  static final Databasehelper13 instance = Databasehelper13._init();

  static Database? _database;

  Databasehelper13._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('users.db');
    return _database!;
  }

  // =========================================================
  // MEMBUAT DATABASE
  // =========================================================

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // =========================================================
  // MEMBUAT TABLE
  // =========================================================

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        phone TEXT NOT NULL UNIQUE
      )
    ''');
  }

  // =========================================================
  // INSERT
  // =========================================================

  Future<int> insertUser(Map<String, dynamic> data) async {
    final db = await database;

    return await db.insert('users', data);
  }

  // =========================================================
  // READ
  // =========================================================

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;

    return await db.query('users', orderBy: 'id DESC');
  }

  // =========================================================
  // CEK EMAIL
  // =========================================================

  Future<bool> isEmailRegistered(String email, {int? excludeId}) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: excludeId == null ? 'email = ?' : 'email = ? AND id != ?',
      whereArgs: excludeId == null ? [email] : [email, excludeId],
    );

    return result.isNotEmpty;
  }

  // =========================================================
  // CEK NOMOR HP
  // =========================================================

  Future<bool> isPhoneRegistered(String phone, {int? excludeId}) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: excludeId == null ? 'phone = ?' : 'phone = ? AND id != ?',
      whereArgs: excludeId == null ? [phone] : [phone, excludeId],
    );

    return result.isNotEmpty;
  }

  // =========================================================
  // UPDATE
  // =========================================================

  Future<int> updateUser(int id, Map<String, dynamic> data) async {
    final db = await database;

    return await db.update('users', data, where: 'id = ?', whereArgs: [id]);
  }

  // =========================================================
  // DELETE
  // =========================================================

  Future<int> deleteUser(int id) async {
    final db = await database;

    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // =========================================================
  // CLOSE DATABASE
  // =========================================================

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
