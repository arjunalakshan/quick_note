import 'package:flutter/widgets.dart';
import 'package:quick_note/models/todo_model.dart';

class TodoInheritedWidget extends InheritedWidget {
  final List<TodoModel> todoList;
  final Function() onChageTodo;

  const TodoInheritedWidget({
    super.key,
    required super.child,
    required this.todoList,
    required this.onChageTodo,
  });

  static TodoInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant TodoInheritedWidget oldWidget) {
    return todoList != oldWidget.todoList;
  }
}
