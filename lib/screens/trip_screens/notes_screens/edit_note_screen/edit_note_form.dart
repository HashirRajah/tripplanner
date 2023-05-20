import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/blocs/notes_list_bloc/notes_list_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/personal_note_model.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/edit_note_screen/edit_note_field.dart';
import 'package:tripplanner/services/firestore_services/personal_notes_crud_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditNoteForm extends StatefulWidget {
  //
  final String title;
  final PersonalNoteModel note;
  //
  const EditNoteForm({
    super.key,
    required this.title,
    required this.note,
  });

  @override
  State<EditNoteForm> createState() => _EditNoteFormState();
}

class _EditNoteFormState extends State<EditNoteForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _titleFormFieldKey = GlobalKey<FormFieldState>();
  //
  late final QuillController quillController;
  //
  final FocusNode _titleFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();
  late final PersonalNotesCRUD personalNotesCRUD;
  //
  late String noteTitle;
  late final String userId;
  //
  bool processing = false;
  //
  final String successMessage = 'Note Saved';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    noteTitle = widget.note.title;
    //
    var body = jsonDecode(widget.note.body);
    //
    quillController = QuillController(
      document: Document.fromJson(body),
      selection: const TextSelection.collapsed(offset: 0),
    );
    //
    String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    personalNotesCRUD = PersonalNotesCRUD(
      tripId: tripId,
      userId: userId,
      noteId: widget.note.noteId,
    );
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
        //
        bool all = BlocProvider.of<NotesListBloc>(context).all;
        //
        if (all) {
          BlocProvider.of<NotesListBloc>(context).add(LoadAllPersonalNotes());
        } else {
          BlocProvider.of<NotesListBloc>(context)
              .add(LoadImportantPersonalNotes());
        }
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
  Future _editNote() async {
    String errorTitle = 'Failed to save note';
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
      dynamic result = await personalNotesCRUD.updateNote(
        noteTitle,
        jsonEncode(quillController.document.toDelta().toJson()),
        DateTime.now().toIso8601String(),
      );
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
          EditNoteField(
            quillController: quillController,
            lastEdited: widget.note.getModifiedAtFormatted(),
          ),
          addVerticalSpace(spacing_16),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async {
                await _editNote();
              },
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
