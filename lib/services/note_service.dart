import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:quick_note/models/note_model.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  List<NoteModel> noteList = [
    NoteModel(
      id: Uuid().v8(),
      category: "Work",
      title: "Standup meeting points",
      content:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      date: DateTime.now(),
    ),
    NoteModel(
      id: Uuid().v8(),
      category: "Studie",
      title: "Studie points to memorize",
      content:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      date: DateTime.now(),
    ),
    NoteModel(
      id: Uuid().v8(),
      category: "Personal",
      title: "Daily breakfirst choice",
      content:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      date: DateTime.now(),
    ),
  ];

  //* Create hive box reference for note
  final _noteBox = Hive.box(AppConstantProperties.kNoteHiveBox);

  //* Check whether first time user or not
  Future<bool> isFirstTimeUser() async {
    return _noteBox.isEmpty;
  }

  //* If note box is empty in hive, put the initial notes in there
  Future<void> createInitialNoteList() async {
    if (_noteBox.isEmpty) {
      await _noteBox.put(AppConstantProperties.kNoteKey, noteList);
    }
  }

  //* Get note list from hive
  Future<List<NoteModel>> getNoteList() async {
    final dynamic notes = _noteBox.get(AppConstantProperties.kNoteKey);

    if (notes != null && notes is List<dynamic>) {
      return notes.cast<NoteModel>().toList();
    }
    return [];
  }

  //* Group by category and map with respected notes
  Map<String, List<NoteModel>> categoryToNoteModel(
      List<NoteModel> noteListArg) {
    Map<String, List<NoteModel>> categoryToNote = {};
    for (final note in noteListArg) {
      if (categoryToNote.containsKey(note.category)) {
        categoryToNote[note.category]!.add(note);
      } else {
        categoryToNote[note.category] = [note];
      }
    }
    return categoryToNote;
  }

  //* Get notes by category
  Future<List<NoteModel>> getNoteListByCategory(String categoryArg) async {
    final dynamic notes = _noteBox.get(AppConstantProperties.kNoteKey);
    final List<NoteModel> filteredNotes = [];

    for (final note in notes) {
      if (note.category == categoryArg) {
        filteredNotes.add(note);
      }
    }
    return filteredNotes;
  }

  //* Create a new Note
  Future<void> addNewNote(NoteModel noteModel) async {
    try {
      final dynamic notes = await _noteBox.get(AppConstantProperties.kNoteKey);
      notes.add(noteModel);
      _noteBox.put(AppConstantProperties.kNoteKey, notes);
    } catch (error) {
      log(error.toString());
    }
  }

  //* Update Note
  Future<void> updateNote(NoteModel noteModelArg) async {
    try {
      final dynamic notes = _noteBox.get(AppConstantProperties.kNoteKey);
      final int index = notes.indexWhere((e) => e.id == noteModelArg.id);
      notes[index] = noteModelArg;
      await _noteBox.put(AppConstantProperties.kNoteKey, notes);
    } catch (error) {
      log(error.toString());
    }
  }

  //* Delete Note
  Future<void> removeNote(String noteIdArg) async {
    try {
      final dynamic notes = _noteBox.get(AppConstantProperties.kNoteKey);
      notes.removeWhere((e) => e.id == noteIdArg);
      await _noteBox.put(AppConstantProperties.kNoteKey, notes);
    } catch (error) {
      log(error.toString());
    }
  }

  //* Get all available note categories
  Future<List<String>> getAvailableCategories() async {
    final dynamic notes = _noteBox.get(AppConstantProperties.kNoteKey);
    final List<String> categoryList = [];
    for (final note in notes) {
      if (!categoryList.contains(note.category)) {
        categoryList.add(note.category);
      }
    }
    return categoryList;
  }
}
