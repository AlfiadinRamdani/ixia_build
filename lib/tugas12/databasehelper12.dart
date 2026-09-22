import 'dart:developer' as developer;
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
        nama TEXT ,
        email TEXT UNIQUE,
        no_hp TEXT ,
        password TEXT ,
        asal_kota TEXT 
      )
    ''');
  }

  Future<bool> registerUser(UserModel pengguna) async {
    final db = await database;

    try {
      // db.insert menerima nama tabel dan Map data dari model
      await db.insert('users', pengguna.toMap());
      return true;
    } catch (e) {
      developer.log('Error saat registerUser: ${e.toString()}');
      return false;
    }
  }

  // CHECK UNIQUE NAME
  Future<UserModel?> loginUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [
        email,
        password,
      ], // Parameter '?' akan digantikan oleh nilai ini secara aman
    );

    // Jika data ditemukan (results tidak kosong), kembalikan data user pertama
    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
    }
    // Jika tidak ditemukan atau password salah, kembalikan null
    return null;
  }

  /// --------------------------------------------------------------------------
  /// 3. READ ALL: Mengambil Seluruh Data Pengguna
  /// --------------------------------------------------------------------------
  /// Mengambil semua baris data di tabel 'users' dan mengubahnya menjadi `List<UserModelsSQL>`.
  Future<List<UserModel>> getAllUsers() async {
    final db = await database;
    // Query tanpa 'where' akan mengambil seluruh record di tabel
    final List<Map<String, dynamic>> results = await db.query('users');

    // Konversi setiap Map hasil query menjadi objek UserModelsSQL menggunakan fromMap()
    return results.map((map) => UserModel.fromMap(map)).toList();
  }

  /// --------------------------------------------------------------------------
  /// 4. DELETE: Menghapus Pengguna Berdasarkan ID
  /// --------------------------------------------------------------------------
  /// Menghapus baris pada tabel 'users' yang memiliki ID yang cocok.
  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  /// --------------------------------------------------------------------------
  /// 5. UPDATE: Memperbarui Data Pengguna
  /// --------------------------------------------------------------------------
  /// Mengubah data email / password pengguna berdasarkan ID-nya.
  /// Mengembalikan `true` jika setidaknya ada 1 baris yang terupdate.
  Future<bool> updateUser(UserModel pengguna) async {
    final db = await database;

    try {
      int count = await db.update(
        'users',
        pengguna.toMap(),
        where: 'id = ?',
        whereArgs: [pengguna.id],
      );
      // count adalah jumlah baris yang berhasil diubah di database
      return count > 0;
    } catch (e) {
      developer.log('Error saat updateUser: ${e.toString()}');
      return false;
    }
  }
}
