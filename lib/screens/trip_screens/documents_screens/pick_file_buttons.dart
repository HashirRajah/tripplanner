import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripplanner/services/save_documents_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/services/file_picker_service.dart';
import 'package:tripplanner/services/image_picker_services.dart';

class PickFileButtons {
  //
  final FilePickerService filePickerService = FilePickerService();
  final ImagePickerService imagePickerService = ImagePickerService();
  final SaveDocumentsService saveDocumentsService = SaveDocumentsService();
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
          print(filePaths.toString());
          //saveDocumentsService.saveMultipleDocuments(filePaths, newFilePath);
        }
      },
    );
  }

  //
  SpeedDialChild uploadImageButton(BuildContext context) {
    return SpeedDialChild(
      child: Icon(
        Icons.add_a_photo_outlined,
        color: green_10,
      ),
      label: 'Add an Image',
      backgroundColor: searchBarColor,
      labelBackgroundColor: docTileColor,
      labelStyle: speedDialTextStyle,
      onTap: () => showImagePickOptions(context),
    );
  }

  //
  Widget takePhotoButton(BuildContext context) {
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
                String filePath = result.path;
                print(filePath);
              }
              //saveDocumentsService.saveMultipleDocuments(filePaths, newFilePath);
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

  Widget uploadFromGalleryButton(BuildContext context) {
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
                print(filePaths.toString());
              }
              //saveDocumentsService.saveMultipleDocuments(filePaths, newFilePath);
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
  void showImagePickOptions(BuildContext context) {
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
              takePhotoButton(context),
              uploadFromGalleryButton(context),
            ],
          ),
        );
      },
    );
  }

  //
}
