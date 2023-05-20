import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripplanner/services/save_documents_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/services/file_picker_service.dart';
import 'package:tripplanner/services/image_picker_services.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';

class PickFileButtons {
  //
  final String newFilePath;
  final BuildContext context;
  String successMessage = 'Documents Added';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  final AnimationController controller;
  final FilePickerService filePickerService = FilePickerService();
  final ImagePickerService imagePickerService = ImagePickerService();
  final SaveDocumentsService saveDocumentsService = SaveDocumentsService();
  //
  PickFileButtons(
      {required this.newFilePath,
      required this.controller,
      required this.context});
  //
  SpeedDialChild pickPDFButton() {
    return SpeedDialChild(
      child: Icon(
        Icons.picture_as_pdf_outlined,
        color: green_10,
      ),
      label: 'Add PDF document',
      backgroundColor: searchBarColor,
      labelBackgroundColor: docTileColor,
      labelStyle: speedDialTextStyle,
      onTap: () async {
        dynamic result = await filePickerService.pickPDFFiles();
        //
        if (result != null) {
          List<String?> filePaths = result.paths;
          List<String> errors =
              await saveDocumentsService.saveMultipleDocuments(
            filePaths,
            newFilePath,
          );
          //
          if (context.mounted) {
            if (errors.isEmpty) {
              if (filePaths.length == 1) {
                successMessage = 'Document Added';
              }
              //
              messageDialog(context, successMessage, successLottieFilePath,
                  controller, false);
            }
          }
        }
      },
    );
  }

  //
  SpeedDialChild uploadImageButton() {
    return SpeedDialChild(
      child: Icon(
        Icons.add_a_photo_outlined,
        color: green_10,
      ),
      label: 'Add an Image',
      backgroundColor: searchBarColor,
      labelBackgroundColor: docTileColor,
      labelStyle: speedDialTextStyle,
      onTap: () => showImagePickOptions(),
    );
  }

  //
  Widget takePhotoButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: searchBarColor,
          foregroundColor: green_10,
          child: IconButton(
            onPressed: () async {
              if (context.mounted) {
                Navigator.pop(context);
              }
              //
              dynamic result = await imagePickerService.takePhoto();
              //
              if (result != null) {
                List<String> filePaths = [result.path];
                //
                List<String> errors =
                    await saveDocumentsService.saveMultipleDocuments(
                  filePaths,
                  newFilePath,
                );
                //
                if (context.mounted) {
                  if (errors.isEmpty) {
                    if (filePaths.length == 1) {
                      successMessage = 'Document Added';
                    }
                    //
                    messageDialog(context, successMessage,
                        successLottieFilePath, controller, false);
                  }
                }
              }
            },
            icon: const Icon(Icons.camera_alt_outlined),
          ),
        ),
        Text(
          'Camera',
          style: TextStyle(
            color: white_60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget uploadFromGalleryButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: searchBarColor,
          foregroundColor: green_10,
          child: IconButton(
            onPressed: () async {
              if (context.mounted) {
                Navigator.pop(context);
              }
              //
              dynamic result = await imagePickerService.pickImageFromGallery();
              //
              if (result != null) {
                List<String> filePaths = [];
                //
                for (XFile file in result) {
                  filePaths.add(file.path);
                }
                List<String> errors =
                    await saveDocumentsService.saveMultipleDocuments(
                  filePaths,
                  newFilePath,
                );
                //
                if (context.mounted) {
                  if (errors.isEmpty) {
                    if (filePaths.length == 1) {
                      successMessage = 'Document Added';
                    }
                    //
                    messageDialog(context, successMessage,
                        successLottieFilePath, controller, false);
                  }
                }
              }
            },
            icon: const Icon(Icons.photo_library_outlined),
          ),
        ),
        Text(
          'Gallery',
          style: TextStyle(
            color: white_60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  //
  void showImagePickOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(spacing_16),
          height: spacing_128,
          decoration: BoxDecoration(
            color: green_10,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              takePhotoButton(),
              uploadFromGalleryButton(),
            ],
          ),
        );
      },
    );
  }
  //
}
