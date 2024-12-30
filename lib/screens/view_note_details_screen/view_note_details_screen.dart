import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_note/models/note_model.dart';
import 'package:quick_note/utils/app_constant_properties.dart';
import 'package:quick_note/utils/app_text_styles.dart';
import 'package:quick_note/utils/app_theme_colors.dart';
import 'package:quick_note/utils/routing_setup.dart';

class ViewNoteDetailsScreen extends StatefulWidget {
  final NoteModel noteModel;
  const ViewNoteDetailsScreen({
    super.key,
    required this.noteModel,
  });

  @override
  State<ViewNoteDetailsScreen> createState() => _ViewNoteDetailsScreenState();
}

class _ViewNoteDetailsScreenState extends State<ViewNoteDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMEd().format(widget.noteModel.date);
    final formattedTime = DateFormat.jm().format(widget.noteModel.date);

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            AppConstantProperties.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.folder_open_rounded,
                    size: 30,
                    color: AppThemeColors.kWhiteColor,
                  ),
                  Text(
                    " ${widget.noteModel.category} /",
                    style: AppTextStyles.appTitleStyle,
                  ),
                ],
              ),
              SizedBox(
                height: AppConstantProperties.kDefaultPadding * 2,
              ),
              Text(
                widget.noteModel.title,
                style: AppTextStyles.appSubTitleStyle,
              ),
              SizedBox(
                height: AppConstantProperties.kDefaultPadding / 2,
              ),
              Row(
                children: [
                  Text(
                    formattedDate,
                    style: AppTextStyles.appSubDescriptionStyle.copyWith(
                      color: AppThemeColors.kWhiteColor.withAlpha(150),
                    ),
                  ),
                  SizedBox(
                    width: AppConstantProperties.kDefaultPadding,
                  ),
                  Text(
                    formattedTime,
                    style: AppTextStyles.appSubDescriptionStyle.copyWith(
                      color: AppThemeColors.kWhiteColor.withAlpha(150),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppConstantProperties.kDefaultPadding * 1.5,
              ),
              Text(
                widget.noteModel.content,
                style: AppTextStyles.appDescriptionStyle,
              ),
              SizedBox(
                height: AppConstantProperties.kDefaultPadding,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
