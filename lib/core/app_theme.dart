import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppThemes {
  AppThemes._();

  static ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.robotoTextTheme(),
    appBarTheme: AppBarTheme(
        titleSpacing: 0,
        color: AppColors.primaryColor,
        titleTextStyle: AppTextStyles.bodyWhite18,
        iconTheme: const IconThemeData(color: Colors.white)),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.light,
    ),
  );
}
