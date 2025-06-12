import 'dart:convert';
import 'dart:typed_data';
import 'package:base_template/services/session_service.dart';
import 'package:pointycastle/export.dart';

class CryptoService {
  static Future<String> encryptData(String data) async {
    final cipherKey = await SessionService.getCipherKey();
    final cipherIvKey = await SessionService.getIvKey();

    final key =
        Uint8List.fromList(utf8.encode(cipherKey)); // Clave de descifrado
    final iv = base64Decode(cipherIvKey); // Vector de inicialización (IV)

    // Configura el algoritmo AES-GCM
    final gcm = GCMBlockCipher(AESEngine())
      ..init(
        true, // true para cifrar
        AEADParameters(
          KeyParameter(key), // Clave
          128, // Tamaño del tag en bits (generalmente 128 bits)
          iv, // Vector de inicialización
          Uint8List(
              0), // AAD (Additional Authenticated Data), si no se usa, pasa un array vacío
        ),
      );
    // Convierte los datos a Uint8List
    final inputData = utf8.encode(data).buffer.asUint8List();

    // Cifra los datos
    final encryptedData = gcm.process(inputData);

    // Separa los datos cifrados y el tag de autenticación
    final encryptedBytes =
        encryptedData.sublist(0, encryptedData.length - 16); // Datos cifrados
    final authTag = encryptedData
        .sublist(encryptedData.length - 16); // Tag de autenticación

    // Devuelve los datos cifrados y el tag concatenados en Base64
    return '${base64Encode(encryptedBytes)}:${base64Encode(authTag)}';
  }

  static Future<String> decryptData(String data) async {
    final cipherKey = await SessionService.getCipherKey();
    final cipherIvKey = await SessionService.getIvKey();

    final key =
        Uint8List.fromList(utf8.encode(cipherKey)); // Clave de descifrado
    final iv = base64Decode(cipherIvKey); // Vector de inicialización (IV)

    // Divide los datos cifrados y el tag de autenticación
    final parts = data.split(':');
    final encryptedData = base64Decode(parts[0]); // Datos cifrados
    final authTag = base64Decode(parts[1]); // Tag de autenticación

// Configura el algoritmo AES-GCM
    final gcm = GCMBlockCipher(AESEngine())
      ..init(
        false, // false para descifrar
        AEADParameters(
          KeyParameter(key), // Clave
          128, // Tamaño del tag en bits (generalmente 128 bits)
          iv, // Vector de inicialización
          Uint8List(
              0), // AAD (Additional Authenticated Data), si no se usa, pasa un array vacío
        ),
      );

    // Combina los datos cifrados y el tag de autenticación
    final combinedData = Uint8List.fromList([...encryptedData, ...authTag]);

    // Descifra los datos
    final decryptedData = gcm.process(combinedData);

    return utf8.decode(decryptedData);
  }
}
