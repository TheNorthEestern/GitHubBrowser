import SwiftUI

struct GitHubRepoList: View {
  private let viewModel: GithubProfileDetailViewModel

  init(viewModel: GithubProfileDetailViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    List {
      ForEach(viewModel.sortedRepos) { repo in
        VStack(alignment: .leading, spacing: 12) {
          HStack {
            Button(repo.repositoryName) {
              viewModel.viewRepoProfileAction(repo.htmlURL)
            }
            .font(.system(.headline))
            Spacer()
            if repo.numberOfStars > 0 {
              HStack(alignment: .center) {
                Text("\(Image(systemName:"star"))\(repo.numberOfStars)")
              }
            }
          }

          if !repo.description.isEmpty {
            Text("\(Image(systemName: "info.circle")) \(repo.description)")
          }

          if !repo.programmingLanguage.isEmpty {
            Text("\(repo.programmingLanguage)")
              .padding([.leading, .trailing], 10)
              .padding([.top, .bottom], 5)
              .background(repo.backgroundColor)
              .foregroundColor(repo.foregroundColor)
              .clipShape(Capsule(style: .circular))
              .font(.system(.footnote))
              .monospaced()
              .fontWeight(.semibold)
          }

        }
        .padding()
      }
      .listRowSeparator(.hidden)
      .background(Color(red: 221 / 255, green: 219 / 255, blue: 238 / 255, opacity: 1))
      .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))

      ZStack {
        if !viewModel.sortedRepos.isEmpty {
          Color.clear
            .frame(height: 1)
            .listRowSeparator(.hidden)
            .task {
              do {
                try await viewModel.getRepos()
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
        if viewModel.paginationDidReachEnd {
          Text("You're up to date! 🥳 🎉")
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .listRowSeparator(.hidden)
        }
        if viewModel.listLoadingState == .loading && !viewModel.sortedRepos.isEmpty {
          ProgressView()
            .progressViewStyle(.circular)
        }
      }
      .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
    .listSectionSeparator(.hidden)
  }
}
