import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    return _preferences.getString(key);
  }

  static Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    return _preferences.getInt(key);
  }

  static Future<void> clearAll() async {
    await _preferences.clear();
  }
}
