import 'package:flutter/material.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';

class AddNewCategoryNoteBottomsheet extends StatelessWidget {
  final Function() onTapNewNote;
  final Function() onTapNewCategory;
  const AddNewCategoryNoteBottomsheet({
    super.key,
    required this.onTapNewNote,
    required this.onTapNewCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.35,
      padding: EdgeInsets.all(AppConstantProperties.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppThemeColors.kCardBgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstantProperties.kBorderRadius),
          topRight: Radius.circular(AppConstantProperties.kBorderRadius),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: AppConstantProperties.kDefaultPadding,
          ),
          GestureDetector(
            onTap: onTapNewNote,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Create a New Note",
                  style: AppTextStyles.appSubTitleStyle,
                ),
                Icon(
                  Icons.arrow_right_rounded,
                  size: 30,
                  color: AppThemeColors.kWhiteColor,
                )
              ],
            ),
          ),
          SizedBox(
            height: AppConstantProperties.kDefaultPadding,
          ),
          Divider(
            color: AppThemeColors.kWhiteColor.withAlpha(64),
            thickness: 1.5,
          ),
          SizedBox(
            height: AppConstantProperties.kDefaultPadding,
          ),
          GestureDetector(
            onTap: onTapNewCategory,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Create a New Note Category",
                  style: AppTextStyles.appSubTitleStyle,
                ),
                Icon(
                  Icons.arrow_right_rounded,
                  size: 30,
                  color: AppThemeColors.kWhiteColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
