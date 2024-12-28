import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/models/note_model.dart';
import 'package:quick_note/screens/create_a_new_note_screen/create_a_new_note_screen.dart';
import 'package:quick_note/screens/edit_note_screen/edit_note_screen.dart';
import 'package:quick_note/screens/home_screen/home_screen.dart';
import 'package:quick_note/screens/note_by_category_screen/note_by_category_screen.dart';
import 'package:quick_note/screens/notes_screen/notes_screen.dart';
import 'package:quick_note/screens/todo_screen/todo_screen.dart';

class RoutingSetup {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      //* Home Screen
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return HomeScreen();
        },
      ),
      //* Notes Screen
      GoRoute(
        name: "notes",
        path: "/notes",
        builder: (context, state) {
          return NotesScreen();
        },
      ),
      //* To do list
      GoRoute(
        name: "to-do-list",
        path: "/todolist",
        builder: (context, state) {
          return TodoScreen();
        },
      ),
      //* Notes inside the category
      GoRoute(
        name: "notes-by-category",
        path: "/notes-by-category",
        builder: (context, state) {
          final String categoryPassing = state.extra as String;
          return NoteByCategoryScreen(category: categoryPassing);
        },
      ),
      //* Create a new note/Category
      GoRoute(
        name: "create-a-new-note-or-category",
        path: "/create-note-or-category",
        builder: (context, state) {
          final bool isNewCategoryCreate = state.extra as bool;
          return CreateANewNoteScreen(isNewCategory: isNewCategoryCreate);
        },
      ),
      //* Note Edit
      GoRoute(
        name: "edit-note",
        path: "/edit-note",
        builder: (context, state) {
          final NoteModel editNoteModel = state.extra as NoteModel;
          return EditNoteScreen(
            noteModel: editNoteModel,
          );
        },
      ),
    ],
  );
}
