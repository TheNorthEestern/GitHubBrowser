import UIKit

class AppCoordinator: Coordinator {
  var window: UIWindow?
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  var mainCoordinator: GithubProfileCoordinator?

  init(window: UIWindow?) {
    self.window = window
    self.navigationController = UINavigationController()
  }

  func configureNavigationControllerStyle() {
	  let appearance = UINavigationBarAppearance()
	  appearance.configureWithOpaqueBackground()
	  appearance.shadowImage = UIImage()
	  appearance.shadowColor = .clear
	  
	navigationController.navigationBar.standardAppearance = appearance
    navigationController.navigationBar.isTranslucent = true
    navigationController.navigationBar.shadowImage = UIImage()
    navigationController.view.backgroundColor = .systemBackground
  }

  func start() {
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    configureNavigationControllerStyle()
    startGithubProfileFlow()
  }

  func startGithubProfileFlow() {
    mainCoordinator = GithubProfileCoordinator(navigationController: navigationController)
    mainCoordinator?.start()
  }
}
