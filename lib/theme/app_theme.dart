import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF0B0D17);
  static const surface = Color(0xFF191C2A);
  static const surfaceLight = Color(0xFF242839);
  static const accent = Color(0xFFE50932);
  static const textSecondary = Color(0xFFADB2C3);
  static const border = Color(0xFF303448);
}

class AppTheme {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      secondary: Color(0xFFFF536B),
      surface: AppColors.surface,
      error: Color(0xFFFF6B6B),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF121522),
      indicatorColor: AppColors.accent.withValues(alpha: 0.18),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return TextStyle(
          fontSize: 11,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? Colors.white : AppColors.textSecondary,
        );
      }),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.surfaceLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
