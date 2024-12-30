import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quick_note/helpers/snackbar_helper.dart';
import 'package:quick_note/models/todo_model.dart';
import 'package:quick_note/services/todo_service.dart';
import 'package:quick_note/utils/app_theme_colors.dart';
import 'package:quick_note/widgets/todo_screen_widgets/todo_card.dart';

class PendingTaskTab extends StatefulWidget {
  final List<TodoModel> pendingtodoList;
  final List<TodoModel> completedTodoList;
  const PendingTaskTab({
    super.key,
    required this.pendingtodoList,
    required this.completedTodoList,
  });

  @override
  State<PendingTaskTab> createState() => _PendingTaskTabState();
}

class _PendingTaskTabState extends State<PendingTaskTab> {
  //* Set Todo as completed
  void _markTodoAsCompleted(TodoModel todoItem) async {
    try {
      final markedTodoItem = TodoModel(
        id: todoItem.id,
        title: todoItem.title,
        date: todoItem.date,
        time: todoItem.time,
        isCompleted: true,
      );
      await TodoService().markAsCompleteOrPending(markedTodoItem);
      if (context.mounted) {
        SnackbarHelper.showSuccessSnackBar(context, "Task marked as done!");
      }
      setState(() {
        widget.pendingtodoList.remove(todoItem);
        widget.completedTodoList.add(markedTodoItem);
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: widget.pendingtodoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(widget.pendingtodoList[index].id.toString()),
                direction: DismissDirection.startToEnd,
                background: Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.delete_sweep_rounded,
                    color: AppThemeColors.kWhiteColor.withAlpha(150),
                    size: 30,
                  ),
                ),
                onDismissed: (direction) {
                  try {
                    TodoService().deleteTodoTask(widget.pendingtodoList[index]);
                    setState(() {
                      widget.pendingtodoList.removeAt(index);
                    });
                    SnackbarHelper.showSuccessSnackBar(
                        context, "Task deleted!");
                  } on Exception catch (e) {
                    log(e.toString());
                  }
                },
                child: TodoCard(
                  todoModel: widget.pendingtodoList[index],
                  isMarkAsDone: widget.pendingtodoList[index].isCompleted,
                  onCheckedChange: () =>
                      _markTodoAsCompleted(widget.pendingtodoList[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
