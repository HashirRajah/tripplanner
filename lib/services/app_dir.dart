import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppDirectoryProvider {
  static late Directory appDir;
  //
  Future<void> init() async {
    appDir = await getApplicationDocumentsDirectory();
  }
}
