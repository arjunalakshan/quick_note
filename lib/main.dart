import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quick_note/models/note_model.dart';
import 'package:quick_note/models/todo_model.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_theme_data.dart';
import 'package:quick_note/utils/routing_setup.dart';

void main() async {
  //* Initialize hive
  await Hive.initFlutter();

  //* Register adapters
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(TodoModelAdapter());

  //* Open hive box
  await Hive.openBox(AppConstantProperties.kNoteHiveBox);
  await Hive.openBox(AppConstantProperties.kTodoHiveBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "QuickNote",
      theme: AppThemeData.darkTheme.copyWith(
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
      ),
      routerConfig: RoutingSetup.router,
    );
  }
}
