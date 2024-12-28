import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quick_note/helpers/snackbar_helper.dart';
import 'package:quick_note/models/note_model.dart';
import 'package:quick_note/services/note_service.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';
import 'package:quick_note/utils/routing_setup.dart';

class EditNoteScreen extends StatefulWidget {
  final NoteModel noteModel;
  const EditNoteScreen({
    super.key,
    required this.noteModel,
  });

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  List<String> categoryList = [];
  NoteService noteService = NoteService();

  final _formHndler = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String selectedCategory = "";

  Future _getAllCategories() async {
    categoryList = await noteService.getAvailableCategories();
    setState(() {
      log(categoryList.toString());
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _titleController.text = widget.noteModel.title;
    _contentController.text = widget.noteModel.content;
    selectedCategory = widget.noteModel.category;
    _getAllCategories();
    super.initState();
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppConstantProperties.kDefaultPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit note",
                  style: AppTextStyles.appTitleStyle,
                ),
                SizedBox(
                  height: AppConstantProperties.kDefaultPadding * 2,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: AppConstantProperties.kDefaultPadding,
                  ),
                  child: Form(
                    key: _formHndler,
                    child: Column(
                      children: [
                        //* Show dropdown
                        DropdownButtonFormField<String>(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select a category";
                            }
                            return null;
                          },
                          isExpanded: false,
                          hint: Text(
                            "Select a category",
                            style: AppTextStyles.appBodyStyle,
                          ),
                          borderRadius: BorderRadius.circular(
                            AppConstantProperties.kBorderRadius,
                          ),
                          style: AppTextStyles.appBodyStyle,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstantProperties.kBorderRadius,
                              ),
                              borderSide: BorderSide(
                                color:
                                    AppThemeColors.kWhiteColor.withAlpha(150),
                              ),
                            ),
                          ),
                          items: categoryList.map((String category) {
                            return DropdownMenuItem<String>(
                              alignment: Alignment.centerLeft,
                              value: category,
                              child: Text(
                                category,
                                style: AppTextStyles.appBodyStyle,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? categoryName) {
                            setState(() {
                              selectedCategory = categoryName!;
                            });
                          },
                        ),
                        SizedBox(
                          height: AppConstantProperties.kDefaultPadding,
                        ),
                        //* Title input field
                        TextFormField(
                          controller: _titleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a note title";
                            }
                            return null;
                          },
                          maxLines: 2,
                          style: AppTextStyles.appSubTitleStyle.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 24,
                          ),
                          decoration: InputDecoration(
                            hintText: "Note title",
                            hintStyle: AppTextStyles.appSubTitleStyle.copyWith(
                              color: AppThemeColors.kWhiteColor.withAlpha(150),
                              fontWeight: FontWeight.normal,
                              fontSize: 24,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                        SizedBox(
                          height: AppConstantProperties.kDefaultPadding,
                        ),
                        //* Content input field
                        TextFormField(
                          controller: _contentController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter note content";
                            }
                            return null;
                          },
                          maxLines: 14,
                          style: AppTextStyles.appSubTitleStyle.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                            hintText: "Note Content",
                            hintStyle: AppTextStyles.appSubTitleStyle.copyWith(
                              color: AppThemeColors.kWhiteColor.withAlpha(150),
                              fontWeight: FontWeight.normal,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                        SizedBox(
                          height: AppConstantProperties.kDefaultPadding,
                        ),
                        Divider(
                          color: AppThemeColors.kWhiteColor.withAlpha(16),
                        ),
                        SizedBox(
                          height: AppConstantProperties.kDefaultPadding,
                        ),
                        //* Save button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                //* Updating note
                                if (_formHndler.currentState!.validate()) {
                                  try {
                                    noteService.updateNote(
                                      NoteModel(
                                        category: selectedCategory,
                                        title: _titleController.text,
                                        content: _contentController.text,
                                        date: DateTime.now(),
                                        id: widget.noteModel.id,
                                      ),
                                    );
                                    SnackbarHelper.showSuccessSnackBar(
                                      context,
                                      "Note updated successfully!",
                                    );
                                    _titleController.clear();
                                    _contentController.clear();
                                    RoutingSetup.router.pop(context);
                                  } catch (error) {
                                    log(error.toString());
                                    SnackbarHelper.showErrorSnackBar(
                                      context,
                                      "Failed to update note!",
                                    );
                                  }
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  AppThemeColors.kFloatingABColor,
                                ),
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.symmetric(
                                    vertical:
                                        AppConstantProperties.kDefaultPadding,
                                    horizontal:
                                        AppConstantProperties.kDefaultPadding *
                                            3,
                                  ),
                                ),
                                textStyle: WidgetStateProperty.all(
                                  AppTextStyles.appButtonStyle,
                                ),
                              ),
                              child: Text("Update note"),
                            ),
                          ],
                        ),
                      ],
                    ),
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
