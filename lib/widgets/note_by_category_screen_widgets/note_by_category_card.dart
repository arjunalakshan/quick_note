import 'package:flutter/material.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';

class NoteByCategoryCard extends StatefulWidget {
  final String title;
  final String content;
  final Future Function() editNote;
  final Future Function() removeNote;
  final void Function() viewNote;
  const NoteByCategoryCard({
    super.key,
    required this.title,
    required this.content,
    required this.editNote,
    required this.removeNote,
    required this.viewNote,
  });

  @override
  State<NoteByCategoryCard> createState() => _NoteByCategoryCardState();
}

class _NoteByCategoryCardState extends State<NoteByCategoryCard> {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: widget.editNote,
                icon: Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: AppThemeColors.kWhiteColor.withAlpha(150),
                ),
              ),
              SizedBox(
                width: AppConstantProperties.kDefaultPadding / 2,
              ),
              IconButton(
                onPressed: widget.removeNote,
                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: 20,
                  color: AppThemeColors.kWhiteColor.withAlpha(150),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppConstantProperties.kDefaultPadding / 2,
          ),
          GestureDetector(
            onTap: widget.viewNote,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: AppTextStyles.appSubTitleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: AppConstantProperties.kDefaultPadding / 2,
                ),
                Text(
                  widget.content,
                  style: AppTextStyles.appSubDescriptionStyle.copyWith(
                    color: AppThemeColors.kWhiteColor.withAlpha(150),
                  ),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
