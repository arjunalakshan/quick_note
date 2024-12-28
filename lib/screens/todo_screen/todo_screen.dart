import 'package:flutter/material.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/routing_setup.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
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
    );
  }
}
