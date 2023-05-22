import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:tripplanner/services/save_documents_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class RenameImageForm extends StatefulWidget {
  //
  final String title;
  final String filePath;
  final String newFilePath;
  //
  const RenameImageForm({
    super.key,
    required this.title,
    required this.filePath,
    required this.newFilePath,
  });

  @override
  State<RenameImageForm> createState() => _RenameImageFormState();
}

class _RenameImageFormState extends State<RenameImageForm>
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
  final String successMessage = 'Image added';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
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
  Future<void> _saveImage() async {
    if (_formkey.currentState!.validate()) {
      //
      File image = File(widget.filePath);
      //
      String dirPath = path.dirname(widget.filePath);
      String imageNewPath = path.join(dirPath, name);
      //
      File imageRenamed = image.renameSync(imageNewPath);
      //
      List<String> filePaths = [imageRenamed.path];
      //
      List<String> errors = await saveDocumentsService.saveMultipleDocuments(
        filePaths,
        widget.newFilePath,
      );
      //
      if (context.mounted) {
        if (errors.isEmpty) {
          messageDialog(context, successMessage, successLottieFilePath,
              controller, false);
        }
      }
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
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.image),
              hintText: 'Image name',
            ),
            focusNode: _nameFocusNode,
          ),
          addVerticalSpace(spacing_24),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async {
                await _saveImage();
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
