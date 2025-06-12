import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class GlobalFunctions {
  static const MethodChannel _channel =
      MethodChannel('com.example.base_template/device_id');

  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(date);
  }

  static Future<bool> isConnectedToNetwork() async {
    final result = await Connectivity().checkConnectivity();
    final check = result.firstWhere(
      (element) =>
          element == ConnectivityResult.mobile ||
          element == ConnectivityResult.wifi,
      orElse: () => ConnectivityResult.none,
    );
    return check != ConnectivityResult.none;
  }

  static Future<String?> getDeviceId() async {
    try {
      final String? deviceId = await _channel.invokeMethod('getDeviceId');
      return deviceId;
    } on PlatformException catch (e) {
      print("Failed to get device ID: ${e.message}");
      return null;
    }
  }

  // static Future<String?> getDeviceIdIOS() async {
  //   try {
  //     final String? deviceId = await _channel.invokeMethod('getDeviceId');
  //     return deviceId;
  //   } on PlatformException catch (e) {
  //     print("Failed to get device ID: ${e.message}");
  //     return null;
  //   }
  // }
}
