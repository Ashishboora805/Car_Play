import Flutter
import UIKit

class PhoneSceneDelegate: FlutterSceneDelegate {
  override func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene,
          let app = UIApplication.shared.delegate as? AppDelegate else { return }
    // CarPlay is native; only the phone attaches a Flutter view.
    guard app.sharedEngine.viewController == nil else { return }
    let phoneWindow = UIWindow(windowScene: windowScene)
    phoneWindow.rootViewController = FlutterViewController(
      engine: app.sharedEngine, nibName: nil, bundle: nil)
    window = phoneWindow
    super.scene(scene, willConnectTo: session, options: connectionOptions)
    phoneWindow.makeKeyAndVisible()
  }

  override func sceneDidDisconnect(_ scene: UIScene) {
    super.sceneDidDisconnect(scene)
    if let controller = window?.rootViewController as? FlutterViewController,
       controller.engine?.viewController === controller {
      controller.engine?.viewController = nil
    }
    window = nil
  }
}
