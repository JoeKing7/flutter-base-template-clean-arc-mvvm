import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:base_template/config/app_pages.dart';
import 'package:base_template/core/utils/app_translations.dart';
import 'package:base_template/config/bindings/initial_bindings.dart';
import 'package:base_template/core/config/app_config.dart';
import 'package:base_template/core/config/env_config.dart';
import 'package:base_template/core/utils/preferences_helper.dart';
import 'package:base_template/presentation/widgets/error_custom.dart';
import 'package:base_template/services/session_service.dart';
import 'package:translations_loader/translations_loader.dart';
import 'package:base_template/presentation/viewmodels/app_controller.dart';

class AppInitializer {
  Future<void> init() async {
    await _initializeBasics();
    // await _initializeSecurity();
    await _initializeDownloader();
    await _initializeStorage();
  }

  Future<void> _initializeBasics() async {
    WidgetsFlutterBinding.ensureInitialized();
    await PreferencesHelper.init();
    await EnvConfig.initEnvironment();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    AppConfig.translations = await TranslationsLoader.loadTranslations(
        'assets/i18n', AppConfig.supportedLocales);

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
    final EnvConfig envConfig = EnvConfig();
    SessionService.setCipherKey(envConfig.cipherKey);
    SessionService.setIvKey(envConfig.cipherIv);
    // Agregar estas líneas antes de SentryFlutter.init
    final appController = Get.put(AppController(), permanent: true);
    await appController.initializeLocale();

    await SentryFlutter.init(
      (options) {
        options.dsn = envConfig.sentryDns; // Configura Sentry con el DSN
        options.tracesSampleRate = 1.0; // 100% rastreo (en desarrollo)
      },
      appRunner: () => runApp(SentryWidget(child: MyApp())),
    );
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // await IsarDBService.init(); // Inicia base de datos local
    // await FirebaseNotificationService().initialize(); // Notificaciones Push
  }

  static Future<void> _initializeSecurity() async {
    HttpOverrides.global = MyHttpOverrides();
    final data = await rootBundle.load('assets/cert.pem');
    final securityContext = SecurityContext.defaultContext;
    securityContext.setAlpnProtocols(['h2'], true);
    securityContext.setAlpnProtocols(['http/1.1'], false);
    securityContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  static Future<void> _initializeDownloader() async {
    // await FlutterDownloader.initialize(
    //   debug: Enviroment.appEnviroment != Enviroment.proVariable,
    //   ignoreSsl: Enviroment.appEnviroment != Enviroment.proVariable,
    // );
  }

  static Future<void> _initializeStorage() async {
    final path = Platform.isIOS
        ? (await getApplicationDocumentsDirectory()).path
        : (await getExternalStorageDirectory())!.path;
    SessionService.setAppDirectoryPath(path);
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        // statusBarColor: ColorsTheme.primary, //top status bar
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light, // status bar icons' color
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness:
            Brightness.dark, //navigation bar icons' color
      ),
      child: GetMaterialApp(
        builder: (context, child) {
          return MediaQuery.withClampedTextScaling(
              minScaleFactor: 0.8, maxScaleFactor: 1.0, child: child!);
        },
        initialBinding: InitialBindings(),
        theme: AppConfig.appTheme,
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(AppConfig.translations),
        fallbackLocale: AppConfig.supportedLocales[0],
        locale: Get.find<AppController>().currentLocale,
        supportedLocales: AppConfig.supportedLocales,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}

Future<Locale> getLocale() async {
  final lang = await SessionService.getAppLang();
  if (lang > -1) {
    return AppConfig.supportedLocales[lang];
  }

  if (Get.deviceLocale.toString().split('_').contains('es')) {
    SessionService.setAppLang(1);
    return AppConfig.supportedLocales[1];
  }

  if (Get.deviceLocale.toString().split('_').contains('en')) {
    SessionService.setAppLang(0);
    return AppConfig.supportedLocales[0];
  }

  SessionService.setAppLang(0);
  return AppConfig.supportedLocales[0];
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        if (host.isNotEmpty && EnvConfig().apiBaseUrl.contains(host)) {
          return true;
        } else {
          return false;
        }
      };
  }
}
