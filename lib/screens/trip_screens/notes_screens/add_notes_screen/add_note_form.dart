import 'package:flutter/material.dart';
import 'package:tripplanner/models/budget_model.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/screens/home_screens/add_trip_screen/date_range_field.dart';
import 'package:tripplanner/screens/home_screens/add_trip_screen/destinations_field.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AddNoteForm extends StatefulWidget {
  //
  final String title;
  //
  const AddNoteForm({super.key, required this.title});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _titleFormFieldKey = GlobalKey<FormFieldState>();
  //
  final QuillController _quillController = QuillController.basic();
  //
  final FocusNode _titleFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();

  //
  String tripTitle = '';
  //
  bool processing = false;
  //
  final String successMessage = 'Note Added';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    _titleFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_titleFormFieldKey, _titleFocusNode));

    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.popUntil(context, (route) => route.isFirst);
        controller.reset();
      }
    });
  }

  //
  @override
  void dispose() {
    // dispose focus nodes
    _titleFocusNode.dispose();
    controller.dispose();
    //
    super.dispose();
  }

  //

  //
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: _titleFormFieldKey,
            initialValue: tripTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) => setState(() => tripTitle = value),
            onEditingComplete: () => _titleFocusNode.unfocus(),
            validator: (value) => validationService.validateTitle(tripTitle),
            decoration: InputDecoration(
              filled: true,
              fillColor: tripCardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: const Icon(Icons.title_outlined),
              hintText: 'Title',
            ),
            focusNode: _titleFocusNode,
            maxLength: 23,
          ),
          addVerticalSpace(spacing_16),
          Container(
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
                    controller: _quillController,
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
                    controller: _quillController,
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
          ),
          addVerticalSpace(spacing_16),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async {},
              child: ButtonChildProcessing(
                processing: processing,
                title: widget.title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
