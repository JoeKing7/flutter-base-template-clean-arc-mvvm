import 'dart:convert';

import 'package:base_template/core/utils/device_info_helper.dart';
import 'package:base_template/core/utils/preferences_helper.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ErrorReporterService {
  Future<void> report({
    required String code,
    required String title,
    required String message,
    required String messageDev,
    StackTrace? stackTrace,
    String? screen,
    dynamic extra,
  }) async {
    final now = DateTime.now().toIso8601String();
    final deviceInfo = await DeviceInfoHelper.getDeviceInfo();
    final email = await PreferencesHelper.getEmail();
    final userId = await PreferencesHelper.getUserIdentification();

    final report = {
      'userId': userId,
      'email': email,
      'timestamp': now,
      'code': code,
      'title': title,
      'message': message,
      'messageDev': messageDev,
      'stackTrace': stackTrace?.toString(),
      'screen': screen,
      'extra': extra,
      'deviceInfo': deviceInfo,
      // Puedes agregar aquí: userId, email, device, version, etc.
    };

    // 🔁 Aquí decides a dónde enviarlo:
    print('📤 ERROR REPORT enviado: ${JsonEncoder().convert(report)}');

    // Opción 1: Firebase Crashlytics
    // await FirebaseCrashlytics.instance.recordError(...);

    // Opción 2: Sentry
    // Sentry.captureException(...);
    Sentry.configureScope((scope) {
      scope.setUser(SentryUser(id: userId, email: email, username: '', ipAddress: '', segment: ''));
    });

    await Sentry.captureException(report, stackTrace: stackTrace, withScope: (scope) {
        scope.setTag('screen', screen ?? 'unknown');
        scope.setTag('code', code);
        scope.setContexts('device_info', deviceInfo);
        if (extra != null) {
          scope.setContexts('extra_data', extra);
        }
    },);

    // Opción 3: Enviar a API
    // await dio.post('/api/errors/report', data: report);

    // Opción 4: Log local (archivos o consola)
    // File('logs.txt').writeAsString(..., mode: append)
  }
}
