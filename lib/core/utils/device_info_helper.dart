import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoHelper {
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    Map<String, dynamic> deviceData = {
        'platform': 'unknown',
      };

    if (Platform.isAndroid) {
      final info = await deviceInfoPlugin.androidInfo;
      deviceData = {
        'platform': 'Android',
        'os_version': info.version.release,
        'model': info.model,
        'manufacturer': info.manufacturer,
        'version_sdk': info.version.sdkInt,
        'version_release': info.version.release,
        'is_physical': info.isPhysicalDevice,
      };
    }
     if (Platform.isIOS) {
      final info = await deviceInfoPlugin.iosInfo;
      deviceData = {
        'platform': 'iOS',
        'os_version': info.systemVersion,
        'model': info.utsname.machine,
        'name': info.name,
        'system_version': info.systemVersion,
        'is_physical': info.isPhysicalDevice,
      };
    } 
    deviceData.addAll({
     'app_version': packageInfo.version,
      'build_number': packageInfo.buildNumber,
    });

    return deviceData;
  }
}
