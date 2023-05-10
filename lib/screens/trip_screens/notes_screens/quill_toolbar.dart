import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class CustomQuillToolBar extends StatelessWidget {
  //
  final QuillController quillController;
  //
  const CustomQuillToolBar({super.key, required this.quillController});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
