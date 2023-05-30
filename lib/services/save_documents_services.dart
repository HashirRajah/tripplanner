import 'dart:io';
import 'package:path/path.dart';

class SaveDocumentsService {
  //
  Future<String?> saveDocument(String filePath, String newFilePath) async {
    try {
      // get filename
      final String fileName = basename(filePath);
      //
      final Directory docDir = Directory(newFilePath);
      // check if directory exits
      if (!await docDir.exists()) {
        await docDir.create(recursive: true);
      }
      //
      final String newPath = '$newFilePath$fileName';
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
    List<String?> filePaths,
    String newFilePath,
  ) async {
    List<String> unsavedFiles = [];
    //
    for (String? filePath in filePaths) {
      if (filePath != null) {
        dynamic result = await saveDocument(filePath, newFilePath);
        //
        if (result != null) {
          unsavedFiles.add('$filePath - $result');
        }
      }
    }
    //
    return unsavedFiles;
  }

  Future<String> renameDoc(String filePath, String newFileName) async {
    final File doc = File(filePath);
    //
    String dirPath = dirname(filePath);
    //
    String docNewPath = join(dirPath, newFileName);
    //
    final File newDoc = await doc.rename(docNewPath);
    //
    return newDoc.path;
  }

  Future<String?> deleteDoc(String filePath) async {
    final File doc = File(filePath);
    //
    try {
      await doc.delete();
      //
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
