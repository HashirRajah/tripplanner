import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/group_note_model.dart';
import 'package:tripplanner/models/personal_note_model.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/add_notes_screen/note_field.dart';
import 'package:tripplanner/services/firestore_services/group_notes_crud_services.dart';
import 'package:tripplanner/services/firestore_services/personal_notes_crud_services.dart';
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
        Navigator.popUntil(context, (route) => route.settings.name == '/trips');
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
  Future _addNote() async {
    String errorTitle = 'Failed to add note';
    String errorMessage = '';
    // validate form
    bool validForm = _formkey.currentState!.validate();
    //
    String? noteError = validationService
        .validateNoteBody(quillController.document.toPlainText());
    //
    if (noteError != null) {
      validForm = false;
      //
      errorMessage = noteError;
      //
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
      }
    }
    //
    if (validForm) {
      //
      setState(() => processing = true);
      //
      bool personal = BlocProvider.of<AddNoteCubit>(context).state.personal;
      String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
      String userId = Provider.of<User?>(context, listen: false)!.uid;
      //
      dynamic result;
      //
      if (personal) {
        result = await _addPersonalNote(tripId, userId);
      } else {
        result = await _addGroupNote(tripId, userId);
      }
      //
      setState(() => processing = false);
      // check if errors
      if (result != null) {
        //
        errorMessage = result;
        //
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
        }
      } else if (result == null) {
        if (context.mounted) {
          messageDialog(context, successMessage, successLottieFilePath,
              controller, false);
        }
      }
    }
  }

  //
  Future<String?> _addPersonalNote(String tripId, String userId) async {
    final PersonalNotesCRUD personalNotesCRUD =
        PersonalNotesCRUD(tripId: tripId, userId: userId);
    //
    final PersonalNoteModel note = PersonalNoteModel(
      title: noteTitle,
      body: jsonEncode(quillController.document.toDelta().toJson()),
      important: false,
      modifiedAt: DateTime.now().toIso8601String(),
    );
    //
    return await personalNotesCRUD.addNote(note);
  }

  //
  Future<String?> _addGroupNote(String tripId, String userId) async {
    final GroupNotesCRUD groupNotesCRUD =
        GroupNotesCRUD(tripId: tripId, userId: userId);
    //
    final GroupNoteModel note = GroupNoteModel(
      title: noteTitle,
      body: jsonEncode(quillController.document.toDelta().toJson()),
      modifiedAt: DateTime.now().toIso8601String(),
      owner: userId,
      staredBy: [],
    );
    //
    return await groupNotesCRUD.addNote(note);
  }

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
              onPressed: () async => await _addNote(),
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
