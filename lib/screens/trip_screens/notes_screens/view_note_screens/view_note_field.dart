import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ViewNoteField extends StatelessWidget {
  final QuillController quillController;
  //
  const ViewNoteField({super.key, required this.quillController});

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return Container(
      padding: const EdgeInsets.all(spacing_16),
      height: (getXPercentScreenHeight(80, screenHeight)),
      decoration: BoxDecoration(
        color: tripCardColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(),
      ),
      child: Column(
        children: [
          Expanded(
            child: QuillEditor(
              controller: quillController,
              focusNode: FocusNode(),
              scrollController: ScrollController(),
              padding: const EdgeInsets.all(0.0),
              scrollable: true,
              autoFocus: false,
              readOnly: true,
              expands: true, // true for view only mode
            ),
          ),
        ],
      ),
    );
  }
}
