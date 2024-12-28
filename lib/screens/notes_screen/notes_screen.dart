import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quick_note/models/note_model.dart';
import 'package:quick_note/services/note_service.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';
import 'package:quick_note/utils/routing_setup.dart';
import 'package:quick_note/widgets/notes_screen_widgets/add_new_category_note_bottomsheet.dart';
import 'package:quick_note/widgets/notes_screen_widgets/note_category_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NoteService noteService = NoteService();
  List<NoteModel> fetchedNotes = [];
  Map<String, List<NoteModel>> fetchedCategoryToNote = {};

  @override
  void initState() {
    _createNotesForFirstTimeUser();
    super.initState();
  }

  //* Create dummy notes for first time user
  void _createNotesForFirstTimeUser() async {
    final bool isFirst = await noteService.isFirstTimeUser();
    if (isFirst) {
      await noteService.createInitialNoteList();
    }

    _getNoteList();
  }

  //* Get note list as Map <Category: NoteModel>
  Future<void> _getNoteList() async {
    final List<NoteModel> listOfNotes = await noteService.getNoteList();
    final Map<String, List<NoteModel>> mapOfCategoryNotes =
        noteService.categoryToNoteModel(listOfNotes);
    setState(() {
      fetchedNotes = listOfNotes;
      fetchedCategoryToNote = mapOfCategoryNotes;
      log(fetchedCategoryToNote.toString());
    });
  }

  //* Open bottom sheet for display add new functions
  void openBottomSheet() {
    showModalBottomSheet(
      barrierColor: AppThemeColors.kBgColor.withAlpha(150),
      context: context,
      builder: (context) {
        return AddNewCategoryNoteBottomsheet(
          onTapNewCategory: () {
            Navigator.pop(context);
            RoutingSetup.router.push("/create-note-or-category", extra: true);
          },
          onTapNewNote: () {
            Navigator.pop(context);
            RoutingSetup.router.push("/create-note-or-category", extra: false);
          },
        );
      },
    );
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
        onPressed: () {
          openBottomSheet();
        },
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
          padding: EdgeInsets.all(
            AppConstantProperties.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notes",
                style: AppTextStyles.appTitleStyle,
              ),
              SizedBox(
                height: AppConstantProperties.kDefaultPadding * 2,
              ),
              fetchedNotes.isEmpty
                  ? Center(
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.35,
                        child: Text(
                          "No notes yet, please add notes to show in here",
                          style: AppTextStyles.appDescriptionStyle.copyWith(
                            color: AppThemeColors.kWhiteColor.withAlpha(150),
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing:
                              AppConstantProperties.kDefaultPadding,
                          mainAxisSpacing:
                              AppConstantProperties.kDefaultPadding,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: fetchedCategoryToNote.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              RoutingSetup.router.push(
                                "/notes-by-category",
                                extra:
                                    fetchedCategoryToNote.keys.elementAt(index),
                              );
                            },
                            child: NoteCategoryCard(
                              categoryName:
                                  fetchedCategoryToNote.keys.elementAt(index),
                              notesCount: fetchedCategoryToNote.values
                                  .elementAt(index)
                                  .length,
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
