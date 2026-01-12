import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6200EE);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFB00020);
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color grey500 = Color(0xFF9E9E9E);
}

class AppTextStyles {
  static TextStyle get todoContent => const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  static TextStyle get todoCompleted => const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.grey500,
      decoration: TextDecoration.lineThrough);
  static TextStyle get todoDate => const TextStyle(
      fontSize: 14,
      color: AppColors.textSecondary);

  static TextStyle get statCount => const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600
  );
}

class AppSpacing {
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
}

class AppRadius {
  static const double md = 12.0;

  static BorderRadius get mediumRadius =>  BorderRadius.circular(md);
}
