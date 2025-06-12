import 'dart:convert';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:base_template/core/security/crypto_service.dart';
import 'package:base_template/core/utils/device_info_helper.dart';
import 'package:base_template/services/session_service.dart';

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
    final email = await SessionService.getEmail();
    final userId = await SessionService.getUserIdentification();

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

    final data = await CryptoService.encryptData(report.toString());
    // 🔁 Aquí decides a dónde enviarlo:
    print(
        '📤 ERROR REPORT enviado: ${JsonEncoder().convert(await CryptoService.decryptData(data))}');

    // Opción 1: Firebase Crashlytics
    // await FirebaseCrashlytics.instance.recordError(...);

    // Opción 2: Sentry
    // Sentry.captureException(...);
    Sentry.configureScope((scope) {
      scope.setUser(SentryUser(
          id: userId, email: email, username: '', ipAddress: '', segment: ''));
    });

    await Sentry.captureException(
      data,
      stackTrace: stackTrace,
      hint: Hint()..set('Title', code),
      withScope: (scope) {
        scope.setTag('screen', screen ?? 'unknown');
        scope.setTag('code', code);
        scope.setTag(
            'messageDev',
            messageDev.length > 120
                ? '${messageDev.substring(0, 120)}...'
                : messageDev);
        scope.setContexts('device_info', deviceInfo);
        if (extra != null) {
          scope.setContexts('extra_data', extra);
        }
      },
    );

    // Opción 3: Enviar a API
    // await dio.post('/api/errors/report', data: report);

    // Opción 4: Log local (archivos o consola)
    // File('logs.txt').writeAsString(..., mode: append)
  }
}
