import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:quick_note/models/todo_model.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:uuid/uuid.dart';

class TodoService {
  List<TodoModel> todoList = [
    TodoModel(
      id: Uuid().v8(),
      title: "Do the homework",
      date: DateTime.now(),
      time: DateTime.now(),
      isCompleted: false,
    ),
    TodoModel(
      id: Uuid().v8(),
      title: "Go for a walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isCompleted: false,
    ),
    TodoModel(
      id: Uuid().v8(),
      title: "Read a book",
      date: DateTime.now(),
      time: DateTime.now(),
      isCompleted: false,
    ),
  ];

  //* Create a Hive box reference for todo
  final _todoBox = Hive.box(AppConstantProperties.kTodoHiveBox);

  //* Check whether user is first time user or not
  Future<bool> isFirstTimeUser() async {
    return _todoBox.isEmpty;
  }

  //* Create initial todo list
  Future<void> createInitialTodoList() async {
    if (_todoBox.isEmpty) {
      await _todoBox.put(AppConstantProperties.kTodoKey, todoList);
    }
  }

  //* Get todo list from HiveBox
  Future<List<TodoModel>> getTodoList() async {
    final List todos = await _todoBox.get(AppConstantProperties.kTodoKey);
    if (todos.isNotEmpty) {
      return todos.cast<TodoModel>();
    }
    return [];
  }

  //* Mark as done pending todo item
  Future<void> markAsCompleteOrPending(TodoModel todoArg) async {
    try {
      final List todos = await _todoBox.get(AppConstantProperties.kTodoKey);
      final int todoItemIndex =
          todos.indexWhere((element) => element.id == todoArg.id);
      if (todoItemIndex != -1) {
        todos[todoItemIndex] = todoArg;
        await _todoBox.put(AppConstantProperties.kTodoKey, todos);
      } else {
        log("Item Not Found");
      }
    } catch (error) {
      log(error.toString());
    }
  }

  //* Create new todo task
  Future<void> addTodoTask(TodoModel todoArg) async {
    try {
      final List todos = await _todoBox.get(AppConstantProperties.kTodoKey);
      todos.add(todoArg);
      await _todoBox.put(AppConstantProperties.kTodoKey, todos);
    } catch (error) {
      log(error.toString());
    }
  }

  //* Delete todo task
  Future<void> deleteTodoTask(TodoModel todoArg) async {
    try {
      final List todos = await _todoBox.get(AppConstantProperties.kTodoKey);
      todos.remove(todoArg);
      log(todos.length.toString());
      await _todoBox.put(AppConstantProperties.kTodoKey, todos);
    } catch (error) {
      log(error.toString());
    }
  }
}
