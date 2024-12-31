import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_note/models/todo_model.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';

class TodoProgressCard extends StatefulWidget {
  final TodoModel todoModel;
  const TodoProgressCard({
    super.key,
    required this.todoModel,
  });

  @override
  State<TodoProgressCard> createState() => _TodoProgressCardState();
}

class _TodoProgressCardState extends State<TodoProgressCard> {
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMEd().format(widget.todoModel.date);
    final timeFormat = DateFormat.jm().format(widget.todoModel.time);
    return Container(
      margin:
          EdgeInsets.only(bottom: AppConstantProperties.kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: AppThemeColors.kCardBgColor,
        borderRadius: BorderRadius.circular(
          AppConstantProperties.kBorderRadius,
        ),
      ),
      child: ListTile(
        title: Text(widget.todoModel.title),
        style: ListTileStyle.list,
        titleTextStyle: AppTextStyles.appSubTitleStyle,
        subtitle: Text("$dateFormat - $timeFormat"),
        subtitleTextStyle: AppTextStyles.appSubDescriptionStyle.copyWith(
          color: AppThemeColors.kWhiteColor.withAlpha(150),
        ),
        trailing: widget.todoModel.isCompleted
            ? Icon(
                Icons.check_circle_rounded,
                size: 30,
                color: AppThemeColors.kWhiteColor.withAlpha(150),
              )
            : Icon(
                Icons.pending_rounded,
                size: 30,
                color: AppThemeColors.kWhiteColor.withAlpha(80),
              ),
      ),
    );
  }
}
