import 'package:flutter/material.dart';
import 'package:quick_note/utils/app_theme_colors.dart';

class AppTextStyles {
  static const TextStyle appTitleStyle = TextStyle(
    color: AppThemeColors.kWhiteColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle appSubTitleStyle = TextStyle(
    color: AppThemeColors.kWhiteColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle appDescriptionStyle = TextStyle(
    color: AppThemeColors.kWhiteColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle appSubDescriptionStyle = TextStyle(
    color: AppThemeColors.kWhiteColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle appBodyStyle = TextStyle(
    color: AppThemeColors.kWhiteColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle appButtonStyle = TextStyle(
    color: AppThemeColors.kWhiteColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
