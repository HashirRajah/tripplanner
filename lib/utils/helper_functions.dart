import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//get a color object from a hexadecimal color code
Color colorFromHexCode(String hexCode) {
  hexCode = '0xff$hexCode';
  // remove # if any
  hexCode = hexCode.replaceAll('#', '');
  //return color
  return Color(int.parse(hexCode));
}

// change status bar color to transparent
void changeStatusBarColorToTransparent() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

// add vertical space
SizedBox addVerticalSpace(double space) {
  return SizedBox(height: space);
}

// add horizontal space
SizedBox addHorizontalSpace(double space) {
  return SizedBox(width: space);
}
