import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandlerTugas {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setLogin(bool value) async {
    await _prefs?.setBool('isLogin', value);
  }

  static bool get isLogin {
    return _prefs?.getBool('isLogin') ?? false;
  }

  static Future<void> logOut() async {
    await _prefs?.remove('isLogin');
  }
}
