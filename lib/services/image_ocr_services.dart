import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ImageOCRService {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
}
