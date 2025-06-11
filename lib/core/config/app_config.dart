import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {

  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  final String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? '';
  final String environment = dotenv.env['ENVIRONMENT'] ?? 'pro';
  final String appVersion = dotenv.env['APP_VERSION'] ?? '1.0.0';
  final String sentryDns = dotenv.env['SENTRY_DNS'] ?? '';

  ThemeData get appTheme => ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true);

  bool get isDev => environment == 'dev';
}
