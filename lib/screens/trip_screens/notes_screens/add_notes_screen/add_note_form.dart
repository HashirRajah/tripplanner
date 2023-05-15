import 'package:flutter/material.dart';
import 'package:tripplanner/models/budget_model.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/screens/home_screens/add_trip_screen/date_range_field.dart';
import 'package:tripplanner/screens/home_screens/add_trip_screen/destinations_field.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/add_notes_screen/note_field.dart';
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
  final QuillController quillController = QuillController.basic();
  //
  final FocusNode _titleFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();

  //
  String noteTitle = '';
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
  Future addNote() async {}
  //
  Future addPersonalNote() async {}
  //
  Future addGroupNote() async {}
  //
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: _titleFormFieldKey,
            initialValue: noteTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) => setState(() => noteTitle = value),
            onEditingComplete: () => _titleFocusNode.unfocus(),
            validator: (value) =>
                validationService.validateNoteTitle(noteTitle),
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
            maxLength: 21,
          ),
          addVerticalSpace(spacing_16),
          NoteField(quillController: quillController),
          addVerticalSpace(spacing_16),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async => addNote(),
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
