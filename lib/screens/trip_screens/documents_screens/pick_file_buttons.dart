import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/rename_image.dart';
import 'package:tripplanner/services/information_filtering_services.dart';
import 'package:tripplanner/services/pdf_text_extraction_services.dart';
import 'package:tripplanner/services/save_documents_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/services/file_picker_service.dart';
import 'package:tripplanner/services/image_picker_services.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:path/path.dart';

class PickFileButtons {
  //
  final bool extractHotelInfo;
  final bool extractAirTicketInfo;
  final bool extractActivityInfo;
  final bool extractBoardingPassInfo;
  final bool extractCarRentalInfo;
  final bool extractAirportTransferInfo;
  String successMessage = 'Documents Added';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  final String newFilePath;
  final BuildContext context;
  final AnimationController controller;
  final FilePickerService filePickerService = FilePickerService();
  final ImagePickerService imagePickerService = ImagePickerService();
  final SaveDocumentsService saveDocumentsService = SaveDocumentsService();
  final InformationFilteringService infoFilterService =
      InformationFilteringService();
  //
  PickFileButtons({
    required this.newFilePath,
    required this.controller,
    required this.context,
    this.extractAirTicketInfo = false,
    this.extractHotelInfo = false,
    this.extractActivityInfo = false,
    this.extractAirportTransferInfo = false,
    this.extractBoardingPassInfo = false,
    this.extractCarRentalInfo = false,
  });
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
          if (errors.isEmpty) {
            //
            if (filePaths.length == 1) {
              successMessage = 'Document Added';
            }
            //
            if (extractHotelInfo) {
              await extractHotelsInfoFromPDF(filePaths, newFilePath);
            }
            //
            if (context.mounted) {
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
                saveImage(result.path);
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
                saveImage(result.path);
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
  Future<List<String>> getExtractedTextsFromPDFs(
      List<String?> filePaths, String newFilePath) async {
    List<String> extractedTexts = [];
    //
    final PDFTextExtractionService pdfTextExtractionService =
        PDFTextExtractionService();
    //
    for (String? filePath in filePaths) {
      if (filePath != null) {
        String fileName = basename(filePath);
        //
        String extractedText = await pdfTextExtractionService
            .getExtractedText('$newFilePath$fileName');
        //
        debugPrint(extractedText);
        extractedTexts.add(extractedText);
        //
      }
    }
    //
    return extractedTexts;
  }

  //
  Future<void> extractHotelsInfoFromPDF(
      List<String?> filePaths, String newFilePath) async {
    List<String> extractedTexts =
        await getExtractedTextsFromPDFs(filePaths, newFilePath);
    //
    for (String extractedText in extractedTexts) {
      debugPrint(infoFilterService.filterPrice(extractedText));
    }
    //
  }

  //
  void saveImage(String filePath) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      clipBehavior: Clip.hardEdge,
      backgroundColor: docTileColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (context) {
        return RenameImage(filePath: filePath, newFilePath: newFilePath);
      },
    );
  }

  //
  Future<void> extractHotelsInfoFromImage() async {}
  //
  Future<void> extractAirTicketsInfoFromPDF() async {}
  //
  Future<void> extractAirTicketsInfoFromImage() async {}
  //
  Future<void> extractActivityInfoFromPDF() async {}
  //
  Future<void> extractActivityInfoFromImage() async {}
  //
  Future<void> extractBoardingPassInfoFromPDF() async {}
  //
  Future<void> extractBoardingPassInfoFromImage() async {}
  //
  Future<void> extractCarRentalInfoFromPDF() async {}
  //
  Future<void> extractCarRentalInfoFromImage() async {}
  //
  Future<void> extractAirportTransferInfoFromPDF() async {}
  //
  Future<void> extractAirportTransferInfoFromImage() async {}
}
