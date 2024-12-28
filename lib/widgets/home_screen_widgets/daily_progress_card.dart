import 'package:flutter/material.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';

class DailyProgressCard extends StatefulWidget {
  final int noOfCompletedTasks;
  final int noOfTotalTasks;
  const DailyProgressCard({
    super.key,
    required this.noOfCompletedTasks,
    required this.noOfTotalTasks,
  });

  @override
  State<DailyProgressCard> createState() => _DailyProgressCardState();
}

class _DailyProgressCardState extends State<DailyProgressCard> {
  @override
  Widget build(BuildContext context) {
    //* Calculate task complete percentage
    double taskCompletedPercentage = widget.noOfTotalTasks != 0
        ? (widget.noOfCompletedTasks / widget.noOfTotalTasks) * 100
        : 0;

    return Container(
      padding: EdgeInsets.all(AppConstantProperties.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppThemeColors.kCardBgColor,
        borderRadius: BorderRadius.circular(
          AppConstantProperties.kBorderRadius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Progress",
                style: AppTextStyles.appSubTitleStyle,
              ),
              SizedBox(
                height: AppConstantProperties.kDefaultPadding / 2,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.55,
                child: Text(
                  "You have completed ${widget.noOfCompletedTasks} of the ${widget.noOfTotalTasks} tasks, \nkeep up the progress!",
                  style: AppTextStyles.appSubDescriptionStyle.copyWith(
                    color: AppThemeColors.kWhiteColor.withAlpha(150),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              gradient: AppThemeColors().kPrimaryGradieant,
              borderRadius: BorderRadius.circular(
                  AppConstantProperties.kRoundingBorderRadius),
            ),
            alignment: Alignment.center,
            child: Text(
              "${taskCompletedPercentage.toStringAsFixed(0)}%",
              style: AppTextStyles.appTitleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
