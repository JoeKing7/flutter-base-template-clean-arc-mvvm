import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String token) async {
    await _preferences.setString('token', token);
  }

  static Future<String?> getToken() async {
    return _preferences.getString('token');
  }

  static Future<void> setUserIdentification(String userId) async {
    await _preferences.setString('userIdentification', userId);
  }

  static Future<String?> getUserIdentification() async {
    return _preferences.getString('userIdentification');
  }

  static Future<void> setEmail(String email) async {
    await _preferences.setString('email', email);
  }
  
  static Future<String?> getEmail() async {
    return _preferences.getString('email');
  }

  static Future<void> clear() async {
    await _preferences.clear();
  }
}
