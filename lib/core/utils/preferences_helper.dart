import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await _preferences.setString('token', token);
  }

  static Future<String?> getToken() async {
    return _preferences.getString('token');
  }

  static Future<void> clear() async {
    await _preferences.clear();
  }
}
