import SwiftUI

struct GithubProfileDetailView: View {
  private let viewModel: GithubProfileDetailViewModel
  @State private var performedInitialLoad = false

  init(viewModel: GithubProfileDetailViewModel) {
    self.viewModel = viewModel
  }

  func performInitialFetch() async {
    do {
      if !viewModel.paginationDidReachEnd { return }
      try await viewModel.getUser()
      try await viewModel.getRepos(startingFromBeginning: true)
    } catch let error {
      fatalError("\(error.localizedDescription)")
    }
  }

  var body: some View {
    VStack() {
      GitHubProfileDetailHeader(viewModel: viewModel)
      ZStack {
        if viewModel.sortedRepos.isEmpty && viewModel.listLoadingState == .done {
          List {
            Text("This user doesn't have any repos yet.")
              .buttonStyle(.bordered)
              .buttonBorderShape(.capsule)
          }
        } else {
          if viewModel.listLoadingState != .done {
            ProgressView()
              .progressViewStyle(.circular)
          }
          GitHubRepoList(viewModel: viewModel)
        }
      }
    }
    .task {
      do {
        if !performedInitialLoad {
          try await viewModel.getUser()
          try await viewModel.getRepos(startingFromBeginning: true)
          performedInitialLoad = true
        }
      } catch let error {
        viewModel.sortedRepos = [
          .init(
            repositoryName: "An error occurred",
            programmingLanguage: "ERROR",
            numberOfStars: 0,
            description: "\(error.localizedDescription)",
            htmlURL: URL(string: "https://support.apple.com/en-us/111786")!
          )
        ]
      }
    }
  }
}

#Preview {
  GithubProfileDetailView(
    viewModel: GithubProfileDetailViewModel(
      dependencies: .init(
        profileURL: .init(string: "https://api.github.com/users/defunkt")!,
        reposURL: URL(string: "https://api.github.com/users/defunkt")!,
        apiClient: .mock()
      ), viewRepoProfileAction: { _ in }
    )
  )
}
