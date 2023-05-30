import 'package:flutter/material.dart';
import 'package:tripplanner/services/save_documents_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class RenameDocForm extends StatefulWidget {
  //
  final String title;
  final String filePath;
  final Function onDone;
  //
  const RenameDocForm({
    super.key,
    required this.title,
    required this.filePath,
    required this.onDone,
  });

  @override
  State<RenameDocForm> createState() => _RenameDocFormState();
}

class _RenameDocFormState extends State<RenameDocForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _nameFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _nameFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();
  final SaveDocumentsService saveDocumentsService = SaveDocumentsService();
  //
  String name = '';
  //
  bool processing = false;
  //
  late final String successMessage;
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  final String errorTitle = 'An error occurred';
  late final String errorMessage;
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    successMessage = '${widget.title} renamed';
    errorMessage = 'Could not rename ${widget.title}';
    //
    _nameFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_nameFormFieldKey, _nameFocusNode));
    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.popUntil(
          context,
          (route) => route.settings.name == '/documents',
        );
        controller.reset();
      }
    });
  }

  //
  Future<void> _renameDoc() async {
    if (_formkey.currentState!.validate()) {
      try {
        await saveDocumentsService.renameDoc(widget.filePath, name);
        //
        widget.onDone();
        //
        if (context.mounted) {
          messageDialog(context, successMessage, successLottieFilePath,
              controller, false);
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
      }
      //
    }
  }

  //
  @override
  void dispose() {
    //
    super.dispose();
    // dispose focus nodes
    _nameFocusNode.dispose();
    controller.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: _nameFormFieldKey,
            initialValue: name,
            onChanged: (value) => setState(() => name = value),
            onEditingComplete: () => _nameFocusNode.unfocus(),
            validator: (value) => validationService.validateImageName(name),
            decoration: InputDecoration(
              prefixIcon: Icon(widget.title == 'Document'
                  ? Icons.picture_as_pdf
                  : Icons.image),
              hintText: '${widget.title} name',
            ),
            focusNode: _nameFocusNode,
          ),
          addVerticalSpace(spacing_24),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async {
                await _renameDoc();
              },
              child: ButtonChildProcessing(
                processing: processing,
                title: 'Save',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
