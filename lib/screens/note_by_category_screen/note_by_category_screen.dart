import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quick_note/helpers/snackbar_helper.dart';
import 'package:quick_note/models/note_model.dart';
import 'package:quick_note/services/note_service.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';
import 'package:quick_note/utils/routing_setup.dart';
import 'package:quick_note/widgets/note_by_category_screen_widgets/note_by_category_card.dart';

class NoteByCategoryScreen extends StatefulWidget {
  final String category;
  const NoteByCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<NoteByCategoryScreen> createState() => _NoteByCategoryScreenState();
}

class _NoteByCategoryScreenState extends State<NoteByCategoryScreen> {
  final NoteService noteService = NoteService();
  List<NoteModel> filterdNoteList = [];

  //* Get the notes under passing category
  Future<void> _getNotesByCategory() async {
    filterdNoteList = await noteService.getNoteListByCategory(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    _getNotesByCategory();
    super.initState();
  }

  //* Route to note edit page
  void _goToNoteEditScreen(NoteModel note) {
    RoutingSetup.router.push("/edit-note", extra: note);
    log(note.toString());
  }

  //* Remove note
  Future<void> _removeCurrentNote(String noteId) async {
    try {
      await noteService.removeNote(noteId);
      if (context.mounted) {
        SnackbarHelper.showSuccessSnackBar(
            context, "Note deleted successfully!");
      }
    } on Exception catch (e) {
      if (context.mounted) {
        SnackbarHelper.showErrorSnackBar(context, "Failed to delete note!");
      }
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        onPressed: () {},
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
                widget.category,
                style: AppTextStyles.appTitleStyle,
              ),
              SizedBox(
                height: AppConstantProperties.kDefaultPadding * 2,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppConstantProperties.kDefaultPadding,
                  crossAxisSpacing: AppConstantProperties.kDefaultPadding,
                  childAspectRatio: 0.75,
                ),
                itemCount: filterdNoteList.length,
                itemBuilder: (context, index) {
                  return NoteByCategoryCard(
                    title: filterdNoteList[index].title,
                    content: filterdNoteList[index].content,
                    viewNote: () {
                      RoutingSetup.router
                          .push("/view-note", extra: filterdNoteList[index]);
                    },
                    editNote: () async {
                      _goToNoteEditScreen(filterdNoteList[index]);
                    },
                    removeNote: () async {
                      _removeCurrentNote(filterdNoteList[index].id);
                      setState(() {
                        filterdNoteList.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
