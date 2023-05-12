import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/services/file_picker_service.dart';

class PickFileButtons {
  //
  final FilePickerService filePickerService = FilePickerService();
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
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: green_10,
      ),
      onTap: () async {
        filePickerService.pickPDFFiles();
      },
    );
  }
}
