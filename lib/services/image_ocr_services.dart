import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ImageOCRService {
  Future<String?> extractTextFromImage(String imagePath) async {
    try {
      //
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final InputImage inputImage = InputImage.fromFilePath(imagePath);
      String extractedText = '';
      //
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      //
      extractedText = recognizedText.text;
      textRecognizer.close();
      //
      return extractedText;
    } catch (e) {
      return null;
    }
  }
}
