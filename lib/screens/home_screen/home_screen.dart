import 'package:flutter/material.dart';
import 'package:quick_note/models/note_model.dart';
import 'package:quick_note/models/todo_model.dart';
import 'package:quick_note/services/note_service.dart';
import 'package:quick_note/services/todo_service.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/routing_setup.dart';
import 'package:quick_note/widgets/home_screen_widgets/daily_progress_card.dart';
import 'package:quick_note/widgets/home_screen_widgets/note_and_todo_card.dart';
import 'package:quick_note/widgets/home_screen_widgets/todo_progress_card.dart';
import 'package:quick_note/widgets/inherited_widgets/todo_inherited_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _checkAndCreateInitialDummyObjects();
    super.initState();
  }

  final NoteService _noteService = NoteService();
  final TodoService _todoService = TodoService();
  List<NoteModel> noteModelList = [];
  List<TodoModel> todoModelList = [];

  Future<void> _checkAndCreateInitialDummyObjects() async {
    final bool isFirst = await _noteService.isFirstTimeUser() ||
        await _todoService.isFirstTimeUser();

    if (isFirst) {
      await _noteService.createInitialNoteList();
      await _todoService.createInitialTodoList();
    }
    await _getNoteAndTodoList();
  }

  Future<void> _getNoteAndTodoList() async {
    final results = await Future.wait([
      _noteService.getNoteList(),
      _todoService.getTodoList(),
    ]);
    final List<NoteModel> noteList = results[0] as List<NoteModel>;
    final List<TodoModel> todoList = results[1] as List<TodoModel>;

    setState(() {
      noteModelList = noteList;
      todoModelList = todoList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TodoInheritedWidget(
      todoList: todoModelList,
      onChageTodo: _getNoteAndTodoList,
      child: Scaffold(
        appBar: AppBar(
          title: Text("QuickNote"),
          titleTextStyle: AppTextStyles.appTitleStyle,
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.all(AppConstantProperties.kDefaultPadding),
            child: Column(
              children: [
                SizedBox(
                  height: AppConstantProperties.kDefaultPadding,
                ),
                DailyProgressCard(
                  noOfCompletedTasks: todoModelList
                      .where((element) => element.isCompleted)
                      .length,
                  noOfTotalTasks: todoModelList.length,
                ),
                SizedBox(
                  height: AppConstantProperties.kDefaultPadding * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        RoutingSetup.router.push("/notes");
                      },
                      child: NoteAndTodoCard(
                        topIcon: Icons.notes_rounded,
                        mainType: "Notes",
                        noOfItems: noteModelList.length,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        RoutingSetup.router.push("/todolist");
                      },
                      child: NoteAndTodoCard(
                        topIcon: Icons.checklist_rounded,
                        mainType: "To-do list",
                        noOfItems: todoModelList.length,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppConstantProperties.kDefaultPadding * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Task status",
                      style: AppTextStyles.appSubTitleStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        RoutingSetup.router.push("/todolist");
                      },
                      child: Text(
                        "See All",
                        style: AppTextStyles.appBodyStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppConstantProperties.kDefaultPadding,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return TodoProgressCard(todoModel: todoModelList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
