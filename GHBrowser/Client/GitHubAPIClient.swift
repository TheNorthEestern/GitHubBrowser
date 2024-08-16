import Foundation

struct GitHubApiClient: Sendable {
  public var getUser: @Sendable (_ url: URL) async throws -> GitHubV3Service.GithubBoxedResponse<PrivateUser>
  public var getUsers: @Sendable (_ nextURL: URL?, _ startsWith: GitHubV3Service.GitHubPath?, _ params: [URLQueryItem]?) async throws -> GitHubV3Service.GithubBoxedResponse<[SimpleUser]>
  public var getRepos: @Sendable (_ nextURL: URL?, _ startsWith: GitHubV3Service.GitHubPath?, _ params: [URLQueryItem]?) async throws -> GitHubV3Service.GithubBoxedResponse<[GitHubRepo]>

  static func live() -> Self {
    let service = GitHubV3Service()

    return .init(
      getUser: { url in
        try await service.getUser(with: url)
      },
      getUsers: { nextURL, startingURL, params in
        try await service.getPaginatedCollection(with: nextURL, startWith: startingURL, params: params)
      },
      getRepos: { nextURL, startingURL, params in
        try await service.getPaginatedCollection(
          with: nextURL,
          startWith: startingURL,
          params: params
        )
      }
    )
  }
}
