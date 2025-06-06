import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  final String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? '';
  final String environment = dotenv.env['ENVIRONMENT'] ?? 'pro';

  ThemeData get appTheme => ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true);

  bool get isDev => environment == 'dev';
}
