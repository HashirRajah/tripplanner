import 'dart:io';
import 'package:path/path.dart';
import 'package:tripplanner/models/document_model.dart';
import 'package:tripplanner/services/app_dir.dart';

class DocListService {
  // get list of files from directory
  List<DocumentModel> getDocuments(String dirPath) {
    final Directory dir = Directory('${AppDirectoryProvider.appDir}/$dirPath');
    //
    List<DocumentModel> docs = dir.listSync(followLinks: false).map(
      (FileSystemEntity fileSystemEntity) {
        String documentPath = fileSystemEntity.path;
        String documentName = basenameWithoutExtension(documentPath);
        String documentExtension = extension(documentPath);

        DocumentModel doc = DocumentModel(
          documentPath: documentPath,
          documentName: documentName,
          documentExtension: documentExtension,
        );
        //
        return doc;
      },
    ).toList();
    //
    return docs;
  }
}
