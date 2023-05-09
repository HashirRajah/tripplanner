import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NoteField extends StatelessWidget {
  final QuillController quillController;
  //
  const NoteField({super.key, required this.quillController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spacing_16),
      height: (spacing_8 * 40),
      decoration: BoxDecoration(
        color: tripCardColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(spacing_16),
            decoration: BoxDecoration(
              color: searchBarColor,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: QuillToolbar.basic(
              controller: quillController,
              color: searchBarColor,
              sectionDividerColor: green_10,
              multiRowsDisplay: false,
              showFontFamily: false,
              showFontSize: false,
              showUndo: false,
              showRedo: false,
              showLink: false,
              showSearchButton: false,
              showSubscript: false,
              showSuperscript: false,
              showInlineCode: false,
              showCodeBlock: false,
              showListCheck: false,
              showQuote: false,
              iconTheme: QuillIconTheme(
                iconUnselectedColor: green_10,
                iconSelectedFillColor: green_10,
                iconUnselectedFillColor: searchBarColor,
                borderRadius: 16.0,
              ),
            ),
          ),
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
