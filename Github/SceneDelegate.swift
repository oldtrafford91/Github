import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = createTabbarController()
    configureAppearance()
    window?.makeKeyAndVisible()
  }
  
  //MARK: - Helpers
  
  private func createTabbarController() -> UITabBarController{
    let tabbarController = UITabBarController()
    tabbarController.viewControllers = [createSearchNavigationController(), createFavoritesNavigationController()]
    return tabbarController
  }
  
  private func createSearchNavigationController() -> UINavigationController {
    let searchViewController = SearchViewController()
    searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    let searchNavigationController = UINavigationController(rootViewController: searchViewController)
    return searchNavigationController
  }
  
  private func createFavoritesNavigationController() -> UINavigationController {
    let favoritesViewController = FavoritesViewController()
    favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
    return favoritesNavigationController
  }
  
  private func configureAppearance() {
    UITabBar.appearance().tintColor = .systemGreen
    UINavigationBar.appearance().tintColor = .systemGreen
  }
}
