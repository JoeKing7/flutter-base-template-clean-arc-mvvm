import 'package:flutter/material.dart';

class AppColors {
  // Light
  static const lightPrimary = Color(0xFF0050AC);
  static const lightBackground = Color(0xFFF6F6F6);
  static const lightBlack = Colors.black;
  static const lightGrey = Colors.grey;

  // Dark
  static const darkPrimary = Color(0xFF90CAF9);
  static const darkBackground = Color(0xFF121212);
  static const darkWhite = Colors.white;
  static const darkGrey = Colors.grey;

  static Color primary(Brightness brightness) =>
      brightness == Brightness.dark ? darkPrimary : lightPrimary;

  static Color background(Brightness brightness) =>
      brightness == Brightness.dark ? darkBackground : lightBackground;

  static Color blackWhite(Brightness brightness) =>
      brightness == Brightness.dark ? darkWhite : lightBlack;

  static Color grey(Brightness brightness) =>
      brightness == Brightness.dark ? darkGrey : lightGrey;
}
