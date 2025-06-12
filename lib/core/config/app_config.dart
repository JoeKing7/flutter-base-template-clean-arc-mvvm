import 'package:flutter/material.dart';

class AppConfig {
  static final supportedLocales = [Locale('en', 'US'), Locale('es', 'CO')];
  static late Map<String, Map<String, String>> translations;

  static ThemeData get appTheme => ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true);
}
