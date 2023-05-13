import 'dart:io';
import 'package:path/path.dart';
import 'package:tripplanner/services/app_dir.dart';

class SaveDocumentsService {
  //
  Future<String?> saveDocument(String filePath, String newFilePath) async {
    try {
      //
      final String fileName = basename(filePath);
      //
      final String newPath =
          '${AppDirectoryProvider.appDir.path}/trips/$newFilePath/$fileName';
      //
      await File(filePath).copy(newPath);
      //
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  //
  Future<List<String>> saveMultipleDocuments(
    List<String> filePaths,
    String newFilePath,
  ) async {
    List<String> unsavedFiles = [];
    //
    for (String filePath in filePaths) {
      dynamic result = await saveDocument(filePath, newFilePath);
      //
      if (result != null) {
        unsavedFiles.add('$filePath - $result');
      }
    }
    //
    return unsavedFiles;
  }
}
