import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    //
    GMSServices.provideAPIKey("AIzaSyA-OdT7FKbRWppKW3TImqclXyG30Sg29N8")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
