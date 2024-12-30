import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_note/models/todo_model.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';

class TodoCard extends StatefulWidget {
  final TodoModel todoModel;
  final bool isMarkAsDone;
  final Function() onCheckedChange;
  const TodoCard({
    super.key,
    required this.todoModel,
    required this.isMarkAsDone,
    required this.onCheckedChange,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMEd().format(widget.todoModel.date);
    final formattedTime = DateFormat.jm().format(widget.todoModel.time);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppConstantProperties.kDefaultPadding),
      margin:
          EdgeInsets.only(bottom: AppConstantProperties.kDefaultPadding / 2),
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
                widget.todoModel.title,
                style: AppTextStyles.appSubTitleStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: AppConstantProperties.kDefaultPadding / 2,
              ),
              Text(
                "$formattedDate - $formattedTime",
                style: AppTextStyles.appSubDescriptionStyle.copyWith(
                  color: AppThemeColors.kWhiteColor.withAlpha(150),
                ),
              ),
            ],
          ),
          Checkbox(
            value: widget.isMarkAsDone,
            onChanged: (value) => widget.onCheckedChange(),
          ),
        ],
      ),
    );
  }
}
