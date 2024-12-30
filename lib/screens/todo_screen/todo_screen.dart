import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quick_note/models/todo_model.dart';
import 'package:quick_note/screens/todo_screen/add_new_task_popup.dart';
import 'package:quick_note/screens/todo_screen/completed_task_tab.dart';
import 'package:quick_note/screens/todo_screen/pending_task_tab.dart';
import 'package:quick_note/services/todo_service.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';
import 'package:quick_note/utils/routing_setup.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<TodoModel> _fetchedTodoList = [];
  late List<TodoModel> _pendingTodoList = [];
  late List<TodoModel> _completedTodoList = [];
  final TodoService _todoService = TodoService();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _checkAndCreateInitalTodoList();
    _getTodoList();
    super.initState();
  }

  //* Check the user is first time user and create dummy todo list
  void _checkAndCreateInitalTodoList() async {
    final bool isFirst = await _todoService.isFirstTimeUser();
    if (isFirst) {
      await _todoService.createInitialTodoList();
    }
  }

  //* Get stored todo List
  Future<void> _getTodoList() async {
    final List<TodoModel> todoList = await _todoService.getTodoList();
    setState(() {
      _fetchedTodoList = todoList;
      log(_fetchedTodoList.toString());
      _pendingTodoList = todoList.where((item) => !item.isCompleted).toList();
      _completedTodoList = todoList.where((item) => item.isCompleted).toList();
    });
  }

  //*  Handle after new task added
  void _afterNewTaskAdded() {
    _getTodoList();
  }

  //* Show dialogBox to add new task
  void _openPopupModel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddNewTaskPopup(
          onNewTaskAdded: _afterNewTaskAdded,
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            RoutingSetup.router.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 40,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openPopupModel(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppConstantProperties.kRoundingBorderRadius),
        ),
        child: Icon(
          Icons.add_rounded,
          size: 30,
          color: AppThemeColors.kWhiteColor,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppConstantProperties.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "To-do List",
                style: AppTextStyles.appTitleStyle,
              ),
              SizedBox(
                height: AppConstantProperties.kDefaultPadding * 2,
              ),
              TabBar(
                controller: _tabController,
                dividerHeight: 0,
                indicatorColor: AppThemeColors.kFloatingABColor,
                tabs: [
                  Tab(
                    child: Text(
                      "Pending",
                      style: AppTextStyles.appSubTitleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Completed",
                      style: AppTextStyles.appSubTitleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppConstantProperties.kDefaultPadding,
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.74,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    PendingTaskTab(
                      pendingtodoList: _pendingTodoList,
                      completedTodoList: _completedTodoList,
                    ),
                    CompletedTaskTab(
                      completedTodoList: _completedTodoList,
                      pendingTodoList: _pendingTodoList,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
