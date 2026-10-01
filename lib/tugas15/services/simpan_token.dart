import 'package:shared_preferences/shared_preferences.dart';

class SimpanToken {
  static Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('autentikasi_token', token);
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('autentikasi_token');
  }

  static Future<void> hapusToken() async {
    final pref = await SharedPreferences.getInstance();
    // Remove stored authentication token and any user related data
    await pref.remove('autentikasi_token');
    await pref.remove('nama_user');
  }
}
