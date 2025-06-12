//  ¿Qué hace SessionService?
// Es una fachada del dominio de sesión del usuario, que encapsula dónde y cómo se guardan los datos,
//sin que otras capas tengan que preocuparse por eso.

import 'package:base_template/core/utils/preferences_helper.dart';
import 'package:base_template/core/utils/secure_keys.dart';
import 'package:base_template/core/utils/secure_storage_helper.dart';

class SessionService {
  static Future<void> setToken(String token) async {
    await SecureStorageHelper.write(SecureKeys.authToken, token);
  }

  static Future<String> getToken() async {
    return await SecureStorageHelper.read(SecureKeys.authToken);
  }

  // 🔐 CipherKey
  static Future<void> setCipherKey(String cipherKey) async {
    await SecureStorageHelper.write(SecureKeys.cipherKeyAuth, cipherKey);
  }

  static Future<String> getCipherKey() async {
    return await SecureStorageHelper.read(SecureKeys.cipherKeyAuth);
  }

  // 🔐 IV
  static Future<void> setIvKey(String iv) async {
    await SecureStorageHelper.write(SecureKeys.cipherIv, iv);
  }

  static Future<String> getIvKey() async {
    return await SecureStorageHelper.read(SecureKeys.cipherIv);
  }

  // 🧾 ID Usuario
  static Future<void> setUserIdentification(String userId) async {
    await PreferencesHelper.setString(SecureKeys.userIdentification, userId);
  }

  static Future<String?> getUserIdentification() async {
    return await PreferencesHelper.getString(SecureKeys.userIdentification);
  }

  // 🧾 Email
  static Future<void> setEmail(String email) async {
    await PreferencesHelper.setString(SecureKeys.userEmail, email);
  }

  static Future<String?> getEmail() async {
    return await PreferencesHelper.getString(SecureKeys.userEmail);
  }

  // App Directory Path
  static Future<void> setAppDirectoryPath(String path) async {
    await PreferencesHelper.setString(SecureKeys.appDirectoryPath, path);
  }

  static Future<String?> getAppDirectoryPath() async {
    return await PreferencesHelper.getString(SecureKeys.appDirectoryPath);
  }

  // App Lang
  static Future<void> setAppLang(int lang) async {
    await PreferencesHelper.setInt(SecureKeys.appLang, lang);
  }

  static Future<int> getAppLang() async {
    return await PreferencesHelper.getInt(SecureKeys.appLang) ?? -1;
  }

  // 🧹 Logout
  static Future<void> clearSession() async {
    await SecureStorageHelper.clearAll();
    await PreferencesHelper.clearAll();
  }
}
