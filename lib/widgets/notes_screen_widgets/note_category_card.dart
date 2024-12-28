import 'package:flutter/material.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';

class NoteCategoryCard extends StatelessWidget {
  final String categoryName;
  final int notesCount;
  const NoteCategoryCard({
    super.key,
    required this.categoryName,
    required this.notesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstantProperties.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppThemeColors.kCardBgColor,
        borderRadius: BorderRadius.circular(
          AppConstantProperties.kBorderRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_rounded,
            size: 30,
            color: AppThemeColors.kWhiteColor,
          ),
          SizedBox(
            height: AppConstantProperties.kDefaultPadding / 2,
          ),
          Text(
            categoryName,
            style: AppTextStyles.appSubTitleStyle,
          ),
          Text(
            notesCount == 1 ? "$notesCount note" : "$notesCount notes",
            style: AppTextStyles.appBodyStyle.copyWith(
              color: AppThemeColors.kWhiteColor.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }
}
