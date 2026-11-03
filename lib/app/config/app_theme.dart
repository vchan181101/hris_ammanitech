import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/color_schemes.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.lightColorScheme,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      fontFamily: 'Roboto',
    );
  }
}
