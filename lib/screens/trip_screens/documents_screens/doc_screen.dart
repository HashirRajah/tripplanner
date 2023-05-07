import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_app_bar.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DocScreen extends StatelessWidget {
  final String title;
  //
  const DocScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tripCardColor,
      body: CustomScrollView(
        slivers: <Widget>[
          DocSliverAppBar(title: title),
        ],
      ),
      floatingActionButton: SpeedDial(
        spacing: spacing_8,
        spaceBetweenChildren: spacing_16,
        overlayColor: Colors.black,
        overlayOpacity: 0.6,
        children: <SpeedDialChild>[
          SpeedDialChild(
            child: Icon(
              Icons.card_travel_outlined,
              color: green_10,
            ),
            label: 'Use from other Trips',
            backgroundColor: searchBarColor,
            labelBackgroundColor: docTileColor,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: green_10,
            ),
          ),
          SpeedDialChild(
            child: Icon(
              Icons.picture_as_pdf_outlined,
              color: green_10,
            ),
            label: 'Add a PDF document',
            backgroundColor: searchBarColor,
            labelBackgroundColor: docTileColor,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: green_10,
            ),
          ),
          SpeedDialChild(
            child: Icon(
              Icons.add_a_photo_outlined,
              color: green_10,
            ),
            label: 'Add an Image',
            backgroundColor: searchBarColor,
            labelBackgroundColor: docTileColor,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: green_10,
            ),
          ),
        ],
        child: const Icon(Icons.add),
      ),
    );
  }
}
