import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quick_note/helpers/snackbar_helper.dart';
import 'package:quick_note/models/todo_model.dart';
import 'package:quick_note/services/todo_service.dart';
import 'package:quick_note/utils/app_theme_colors.dart';
import 'package:quick_note/widgets/todo_screen_widgets/todo_card.dart';

class CompletedTaskTab extends StatefulWidget {
  final List<TodoModel> completedTodoList;
  final List<TodoModel> pendingTodoList;
  const CompletedTaskTab({
    super.key,
    required this.completedTodoList,
    required this.pendingTodoList,
  });

  @override
  State<CompletedTaskTab> createState() => _CompletedTaskTabState();
}

class _CompletedTaskTabState extends State<CompletedTaskTab> {
  //* Set as pending task
  void _markTodoAsPending(TodoModel todoItem) async {
    try {
      final unmarkedTodoItem = TodoModel(
        id: todoItem.id,
        title: todoItem.title,
        date: todoItem.date,
        time: todoItem.time,
        isCompleted: false,
      );
      await TodoService().markAsCompleteOrPending(unmarkedTodoItem);
      setState(() {
        widget.completedTodoList.remove(todoItem);
        widget.pendingTodoList.add(unmarkedTodoItem);
      });
      SnackbarHelper.showSuccessSnackBar(context, "Task marked as pending!");
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
            itemCount: widget.completedTodoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(widget.completedTodoList[index].id.toString()),
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
                    TodoService()
                        .deleteTodoTask(widget.completedTodoList[index]);
                    setState(() {
                      widget.completedTodoList.removeAt(index);
                    });
                    SnackbarHelper.showSuccessSnackBar(
                        context, "Task deleted!");
                  } on Exception catch (e) {
                    log(e.toString());
                  }
                },
                child: TodoCard(
                  todoModel: widget.completedTodoList[index],
                  isMarkAsDone: widget.completedTodoList[index].isCompleted,
                  onCheckedChange: () =>
                      _markTodoAsPending(widget.completedTodoList[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
