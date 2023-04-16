import 'package:open_mail_app/open_mail_app.dart';

class LauncherServices {
  // launch email app
  Future<void> launchEmailApp() async {
    await OpenMailApp.openMailApp();
  }
}
