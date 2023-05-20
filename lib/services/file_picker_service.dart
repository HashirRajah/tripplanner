import 'package:file_picker/file_picker.dart';

class FilePickerService {
  //
  Future<FilePickerResult?> pickPDFFiles() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
  }
}
