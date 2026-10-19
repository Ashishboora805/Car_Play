import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  let sharedEngine = FlutterEngine(name: "cpdrive_shared", allowHeadlessExecution: true)
  private(set) var carPlayManager: CarPlayManager!
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    sharedEngine.run()
    let channel = FlutterMethodChannel(name: "cpdrive/car", binaryMessenger: sharedEngine.binaryMessenger)
    carPlayManager = CarPlayManager(channel: channel)
    GeneratedPluginRegistrant.register(with: sharedEngine)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
