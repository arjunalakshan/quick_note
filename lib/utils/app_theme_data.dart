import 'package:flutter/material.dart';
import 'package:quick_note/utils/app_theme_colors.dart';

class AppThemeData {
  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().primaryColor,
    scaffoldBackgroundColor: AppThemeColors.kBgColor,
    colorScheme: ColorScheme.dark().copyWith(
      primary: AppThemeColors.kWhiteColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppThemeColors.kBgColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppThemeColors.kWhiteColor,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppThemeColors.kFloatingABColor,
    ),
  );
}
