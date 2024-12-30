import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quick_note/helpers/snackbar_helper.dart';
import 'package:quick_note/models/todo_model.dart';
import 'package:quick_note/services/todo_service.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';
import 'package:uuid/uuid.dart';

class AddNewTaskPopup extends StatefulWidget {
  final VoidCallback onNewTaskAdded;
  const AddNewTaskPopup({
    super.key,
    required this.onNewTaskAdded,
  });

  @override
  State<AddNewTaskPopup> createState() => _AddNewTaskPopupState();
}

class _AddNewTaskPopupState extends State<AddNewTaskPopup> {
  TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  //* Add new task function
  void _addNewTask() async {
    if (taskController.text.isNotEmpty) {
      try {
        await TodoService().addTodoTask(
          TodoModel(
            id: Uuid().v8(),
            title: taskController.text,
            date: DateTime.now(),
            time: DateTime.now(),
            isCompleted: false,
          ),
        );
        if (context.mounted) {
          SnackbarHelper.showSuccessSnackBar(context, "New task added!");
          widget.onNewTaskAdded();
          Navigator.of(context).pop();
        }
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppThemeColors.kCardBgColor,
      contentPadding: EdgeInsets.all(AppConstantProperties.kDefaultPadding),
      title: Text(
        "Add new tassk",
        style: AppTextStyles.appSubTitleStyle,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextField(
              controller: taskController,
              style: AppTextStyles.appDescriptionStyle,
              decoration: InputDecoration(
                hintText: "Enter task name",
                hintStyle: AppTextStyles.appDescriptionStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstantProperties.kBorderRadius,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              AppThemeColors.kBgColor,
            ),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(
                vertical: AppConstantProperties.kDefaultPadding / 2,
                horizontal: AppConstantProperties.kDefaultPadding,
              ),
            ),
          ),
          child: Text(
            "Cancel",
            style: AppTextStyles.appButtonStyle,
          ),
        ),
        ElevatedButton(
          onPressed: _addNewTask,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              AppThemeColors.kFloatingABColor,
            ),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(
                vertical: AppConstantProperties.kDefaultPadding / 2,
                horizontal: AppConstantProperties.kDefaultPadding * 2,
              ),
            ),
          ),
          child: Text(
            "Add",
            style: AppTextStyles.appButtonStyle,
          ),
        ),
      ],
    );
  }
}
