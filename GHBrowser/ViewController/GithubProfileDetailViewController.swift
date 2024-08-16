import SwiftUI

class GithubProfileDetailViewController: UIHostingController<GithubProfileDetailView> {
  weak var coordinator: GithubProfileDetailCoordinator?
  private let viewModel: GithubProfileDetailViewModel

  init(viewModel: GithubProfileDetailViewModel) {
    self.viewModel = viewModel
    super.init(rootView: GithubProfileDetailView(viewModel: viewModel))
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    coordinator?.didFinish()
  }

  @available(*, unavailable)
  @MainActor required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
