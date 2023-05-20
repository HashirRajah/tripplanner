import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker imagePicker = ImagePicker();
  //
  Future<List<XFile>?> pickImageFromGallery() async {
    try {
      return await imagePicker.pickMultiImage();
    } on PlatformException catch (e) {
      return null;
    }
  }

  //
  Future<XFile?> takePhoto() async {
    try {
      return await imagePicker.pickImage(source: ImageSource.camera);
    } on PlatformException catch (e) {
      return null;
    }
  }
}
