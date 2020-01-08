import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    let searchViewController = SearchViewController()

    let tabbarController = UITabBarController()
    tabbarController.viewControllers = [searchViewController]
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = tabbarController
    window?.makeKeyAndVisible()
  }
}
