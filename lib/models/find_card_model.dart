import 'package:flutter/material.dart';

class FindCardModel {
  final String title;
  final String svgFilePath;
  final Color cardColor;
  final Color buttonColor;
  final Widget navigationRoute;
  //
  FindCardModel({
    required this.title,
    required this.svgFilePath,
    required this.cardColor,
    required this.buttonColor,
    required this.navigationRoute,
  });
  //
  void onPressed(BuildContext context) {
    String routeName = '/${title.toLowerCase()}';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => navigationRoute,
        settings: RouteSettings(
          name: routeName,
        ),
      ),
    );
  }
}
