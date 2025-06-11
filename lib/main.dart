import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:base_template/core/utils/preferences_helper.dart';
import 'package:base_template/config/app_pages.dart';
import 'package:base_template/config/bindings/initial_bindings.dart';
import 'package:base_template/core/config/app_config.dart';
import 'package:base_template/core/database/isar_db_service.dart';
import 'package:base_template/core/firebase/firebase_notification_service.dart';
import 'package:base_template/presentation/widgets/error_custom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesHelper.init();
  await AppConfig.initEnvironment(); // Carga las variables de entorno
  // await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  // ByteData data = await rootBundle.load('assets/cert.pem');
  // SecurityContext securityContext = SecurityContext.defaultContext;
  // securityContext.setAlpnProtocols(['h2'], true);
  // securityContext.setAlpnProtocols(['http/1.1'], false);
  // securityContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    bool isDebug = false;
    assert(() {
      isDebug = false;
      return true;
    }());
    if (isDebug) return ErrorWidget(errorDetails.exception);
    return CustomWidgetError(errorDetails: errorDetails);
    };
  await SentryFlutter.init(
    (options) {
      options.dsn = AppConfig().sentryDns; // Configura Sentry con el DSN
      options.tracesSampleRate = 1.0; // 100% rastreo (en desarrollo)
    },
    appRunner: () => runApp(SentryWidget(child: MyApp())),
  );
  // await IsarDBService.init(); // Inicia base de datos local
  // await FirebaseNotificationService().initialize(); // Notificaciones Push

  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppConfig config = AppConfig();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter APP',
      initialBinding: InitialBindings(),
      theme: config.appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        if (host.isNotEmpty && AppConfig().apiBaseUrl.contains(host)) {
          return true;
        } else {
          return false;
        }
      };
  }
}