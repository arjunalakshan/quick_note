import 'package:flutter/material.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';

class NoteAndTodoCard extends StatefulWidget {
  final IconData topIcon;
  final String mainType;
  final int noOfItems;
  const NoteAndTodoCard({
    super.key,
    required this.topIcon,
    required this.mainType,
    required this.noOfItems,
  });

  @override
  State<NoteAndTodoCard> createState() => _NoteAndTodoCardState();
}

class _NoteAndTodoCardState extends State<NoteAndTodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.42,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstantProperties.kDefaultPadding,
        vertical: AppConstantProperties.kDefaultPadding * 2,
      ),
      decoration: BoxDecoration(
        color: AppThemeColors.kCardBgColor,
        borderRadius:
            BorderRadius.circular(AppConstantProperties.kBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            widget.topIcon,
            color: AppThemeColors.kWhiteColor,
            size: 40,
          ),
          SizedBox(
            height: AppConstantProperties.kDefaultPadding / 2,
          ),
          Text(
            widget.mainType,
            style: AppTextStyles.appSubTitleStyle,
          ),
          Text(
            widget.mainType == "Notes"
                ? "${widget.noOfItems} notes"
                : "${widget.noOfItems} tasks",
            style: AppTextStyles.appDescriptionStyle.copyWith(
              color: AppThemeColors.kWhiteColor.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }
}
