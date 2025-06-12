import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static final _storage = const FlutterSecureStorage();

  // 🔐 Guardar un valor
  static Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // 🔓 Leer un valor
  static Future<String> read(String key) async {
    final value = await _storage.read(key: key);
    return value ?? '';
  }

  // 🧽 Borrar un valor
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // 🧹 Limpiar todo
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // ✅ Verificar existencia
  static Future<bool> containsKey(String key) async {
    final all = await _storage.readAll();
    return all.containsKey(key);
  }

  // 🧾 Leer todos los valores
  static Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}
