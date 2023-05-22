import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFTextExtractionService {
  //
  Future<String> getExtractedText(String filePath) async {
    String extractedText = '';
    //
    PdfDocument document =
        PdfDocument(inputBytes: await readDocumentData(filePath));
    //
    PdfTextExtractor extractor = PdfTextExtractor(document);
    //
    extractedText = extractor.extractText();
    //
    return extractedText;
  }

  //
  Future<List<int>> readDocumentData(String filePath) async {
    File pdfFile = File(filePath);
    //
    return await pdfFile.readAsBytes();
  }
}
