import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

class ImageOCRService {
  Future<String?> extractTextFromImage(String imagePath) async {
    try {
      //
      String extractedText = await FlutterTesseractOcr.extractText(imagePath);
      //
      return extractedText;
    } catch (e) {
      return null;
    }
  }
}
