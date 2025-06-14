import 'package:flutter/material.dart';

class AppColors {
  // Light
  static const lightPrimary = Color(0xFFF97316);
  static const lightBackground = Color(0xFFF6F6F6);
  static const lightBlack = Colors.black;
  static const lightSecondary = Color(0xFF292524);
  static const lightTertiary = Color(0xFFB9B9B9);
  static const lightSuccess = Color(0xFF16A34A);
  static const lightError = Color(0xFFEF4444);

  // Dark
  static const darkPrimary = Color(0xFFEA580C);
  static const darkBackground = Color(0xFF121212);
  static const darkWhite = Colors.white;
  static const darkSecondary = Color(0xFF4D4C4C);
  static const darkTertiary = Color(0xFF292524);
  static const darkSuccess = Color(0xFF22C55E);
  static const darkError = Color(0xFFDC2626);

  static Color primary(Brightness brightness) =>
      brightness == Brightness.dark ? darkPrimary : lightPrimary;

  static Color success(Brightness brightness) =>
      brightness == Brightness.dark ? darkSuccess : lightSuccess;

  static Color background(Brightness brightness) =>
      brightness == Brightness.dark ? darkBackground : lightBackground;

  static Color darkWhiteLightBlack(Brightness brightness) =>
      brightness == Brightness.dark ? darkWhite : lightBlack;

  static Color darkBlackLightWhite(Brightness brightness) =>
      brightness == Brightness.dark ? lightBlack : darkWhite;

  static Color secondary(Brightness brightness) =>
      brightness == Brightness.dark ? darkSecondary : lightSecondary;

  static Color errorColor(Brightness brightness) =>
      brightness == Brightness.dark ? darkError : lightError;

  static Color textFieldBorder(Brightness brightness) =>
      brightness == Brightness.dark ? darkSecondary : lightTertiary;
}
