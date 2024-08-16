import Foundation

extension GitHubApiClient {
  static func mock() -> Self {
    return .init(
      getUser: { url in
        .init(value: PrivateUser.createMockPrivateUser(), pageInfo: nil)
      },
      getUsers: { nextURL, _, _ in
        .init(value: [], pageInfo: nil)
      },
      getRepos: { nextURL, _, _ in
        .init(value: GitHubRepo.generateMockRepositories(), pageInfo: nil)
      }
    )
  }
}
