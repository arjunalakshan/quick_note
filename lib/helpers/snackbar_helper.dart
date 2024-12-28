import 'package:flutter/material.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';

class SnackbarHelper {
  static void showSuccessSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppThemeColors.kCardBgColor,
        duration: Duration(seconds: 2),
        content: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 25,
              color: AppThemeColors.kWhiteColor,
            ),
            SizedBox(
              width: AppConstantProperties.kDefaultPadding,
            ),
            Text(
              msg,
              style: AppTextStyles.appDescriptionStyle,
            ),
          ],
        ),
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade900,
        duration: Duration(seconds: 2),
        content: Row(
          children: [
            Icon(
              Icons.error_rounded,
              size: 25,
              color: AppThemeColors.kWhiteColor,
            ),
            SizedBox(
              width: AppConstantProperties.kDefaultPadding,
            ),
            Text(
              msg,
              style: AppTextStyles.appDescriptionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
