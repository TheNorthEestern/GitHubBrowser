import UIKit
import SafariServices

class GithubProfileCoordinator: BaseCoordinator {
  override func start() {
    let viewController = GithubUserListViewController(viewModel: GitHubUserListViewModel(dependencies: .init(apiClient: .live())))
    configureTitleImage(on: viewController)
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
  }

  private func configureTitleImage(on viewController: UIViewController) {
    let image = UIImage(named: "logo-github")
    let titleImage = UIImageView(image: image)

    let purple = UIColor(red: 99/255, green: 97/255, blue: 242/255, alpha: 1)
    titleImage.tintColor = purple

    titleImage.contentMode = .scaleAspectFit

    let stack = UIStackView(arrangedSubviews:  [titleImage])
    stack.distribution = .fillEqually
    viewController.navigationItem.titleView = stack
  }

  func showDetail(profileURL: URL, reposURL: URL) {
    let detailCoordinator = GithubProfileDetailCoordinator(navigationController: navigationController, dependencies: .init(profileURL: profileURL, reposURL: reposURL))
    addChildCoordinator(detailCoordinator)
    detailCoordinator.parentCoordinator = self
    detailCoordinator.start()
  }

  func childDidFinish(_ child: Coordinator) {
    removeChildCoordinator(child)
  }
}

class GithubProfileDetailCoordinator: BaseCoordinator {
  weak var parentCoordinator: GithubProfileCoordinator?

  struct Dependencies {
    let profileURL: URL
    let reposURL: URL
  }

  private let dependencies: Dependencies

  init(navigationController: UINavigationController, dependencies: Dependencies) {
    self.dependencies = dependencies
    super.init(navigationController: navigationController)
  }

  override func start() {
    let viewModel = GithubProfileDetailViewModel(
      dependencies: .init(
        profileURL: dependencies.profileURL,
        reposURL: dependencies.reposURL,
        apiClient: .live()
      ), viewRepoProfileAction: { url in
        self.showWebView(with: url)
      }
    )
    let detailViewController = GithubProfileDetailViewController(viewModel: viewModel)
    detailViewController.coordinator = self
    navigationController.pushViewController(detailViewController, animated: true)
  }
  
  func showWebView(with url: URL) {
    let safariViewController = SFSafariViewController(url: url)
    safariViewController.navigationController?.setNavigationBarHidden(true, animated: false)
    navigationController.present(safariViewController, animated: true)
  }

  func didFinish() {
    parentCoordinator?.childDidFinish(self)
  }
}
