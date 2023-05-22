import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ImageOCRService {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
}
