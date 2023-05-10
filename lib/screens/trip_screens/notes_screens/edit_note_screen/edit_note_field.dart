import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/quill_toolbar.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EditNoteField extends StatelessWidget {
  final QuillController quillController;
  //
  const EditNoteField({super.key, required this.quillController});

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return SizedBox(
      height: (getXPercentScreenHeight(60, screenHeight)),
      child: Column(
        children: <Widget>[
          CustomQuillToolBar(quillController: quillController),
          addVerticalSpace(spacing_16),
          Expanded(
            child: QuillEditor(
              controller: quillController,
              focusNode: FocusNode(),
              scrollController: ScrollController(),
              padding: const EdgeInsets.all(0.0),
              scrollable: true,
              autoFocus: false,
              readOnly: false,
              expands: true, // true for view only mode
              placeholder: 'Type here...',
            ),
          ),
        ],
      ),
    );
  }
}
