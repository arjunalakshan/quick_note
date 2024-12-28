import 'package:flutter/material.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/routing_setup.dart';
import 'package:quick_note/widgets/home_screen_widgets/daily_progress_card.dart';
import 'package:quick_note/widgets/home_screen_widgets/note_and_todo_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QuickNote"),
        titleTextStyle: AppTextStyles.appTitleStyle,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstantProperties.kDefaultPadding),
          child: Column(
            children: [
              SizedBox(
                height: AppConstantProperties.kDefaultPadding,
              ),
              DailyProgressCard(
                noOfCompletedTasks: 1,
                noOfTotalTasks: 5,
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
                      noOfItems: 10,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      RoutingSetup.router.push("/todolist");
                    },
                    child: NoteAndTodoCard(
                      topIcon: Icons.checklist_rounded,
                      mainType: "To-do list",
                      noOfItems: 15,
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
                    "Pending tasks",
                    style: AppTextStyles.appSubTitleStyle,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "See All",
                      style: AppTextStyles.appBodyStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
