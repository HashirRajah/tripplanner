import 'dart:io';
import 'package:path/path.dart';
import 'package:tripplanner/models/document_model.dart';

class DocListService {
  final String dirPath;
  late final Directory dir;
  //
  DocListService({required this.dirPath}) {
    //
    dir = Directory(dirPath);
    //
    createDir();
  }
  //
  Future<void> createDir() async {
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }

  // get list of files from directory
  List<DocumentModel> getDocuments() {
    List<DocumentModel> docs = [];
    //
    if (dir.existsSync()) {
      docs = dir.listSync(followLinks: false).map(
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
    }
    //
    return docs;
  }

  Stream<FileSystemEvent> get docStream {
    return dir.watch();
  }
}
