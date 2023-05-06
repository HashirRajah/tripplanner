import 'package:flutter/material.dart';

class DocTileModel {
  final String title;
  final IconData iconData;
  final Widget navigationScreen;
  //
  DocTileModel({
    required this.title,
    required this.iconData,
    required this.navigationScreen,
  });
}
