import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle title(BuildContext context) => TextStyle(
      fontSize: _scale(context, 26),
      fontWeight: FontWeight.bold,
      color: AppColors.darkWhiteLightBlack(Theme.of(context).brightness));

  static TextStyle subtitle(BuildContext context) => TextStyle(
      fontSize: _scale(context, 22),
      fontWeight: FontWeight.w500,
      color: AppColors.secondary(Theme.of(context).brightness));

  static TextStyle bodyLarge(BuildContext context) => TextStyle(
      fontSize: _scale(context, 16),
      color: AppColors.darkWhiteLightBlack(Theme.of(context).brightness));

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
      fontSize: _scale(context, 14),
      color: AppColors.darkWhiteLightBlack(Theme.of(context).brightness));

  static TextStyle bodySmall(BuildContext context) => TextStyle(
      fontSize: _scale(context, 12),
      color: AppColors.darkWhiteLightBlack(Theme.of(context).brightness));

  static TextStyle button(BuildContext context) => TextStyle(
      fontSize: _scale(context, 16),
      fontWeight: FontWeight.bold,
      color: Colors.white);

  static double _scale(BuildContext context, double base) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 600) return base * 1.2; // tablets
    if (screenWidth <= 320) return base * 0.9; // teléfonos pequeños
    return base;
  }
}
