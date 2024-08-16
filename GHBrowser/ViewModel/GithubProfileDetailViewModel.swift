import SwiftUI

@Observable class GithubProfileDetailViewModel {
  private let dependencies: Dependencies
  private var pageInfo: GitHubV3Service.PageInfo? = nil
  var selectedSortMethod = SortMethod.name
  var user: DetailUser?
  var sortedRepos = [Repo]()
  var headerLoadingState: LoadingState = .loading
  var listLoadingState: LoadingState = .loading
  private var repos = [Repo]()

  var paginationDidReachEnd: Bool = false

  private let initialParams: [URLQueryItem] = []

  var viewRepoProfileAction: (URL) -> Void

  struct Dependencies {
    let apiClient: GitHubApiClient
    let profileURL: URL
    let reposURL: URL

    init(profileURL: URL, reposURL: URL, apiClient: GitHubApiClient) {
      self.apiClient = apiClient
      self.profileURL = profileURL
      self.reposURL = reposURL
    }
  }

  init(dependencies: Dependencies, viewRepoProfileAction: @escaping (URL) -> Void) {
    self.dependencies = dependencies
    self.viewRepoProfileAction = viewRepoProfileAction
  }

  func sortReposBy(sortMethod: SortMethod) {
    selectedSortMethod = sortMethod
    switch sortMethod {
    case .stars:
      sortedRepos.sort { $1.numberOfStars < $0.numberOfStars }
    case .name:
      sortedRepos.sort { $0.repositoryName.lowercased() < $1.repositoryName.lowercased() }
    case .language:
      sortedRepos.sort { $0.programmingLanguage.lowercased() < $1.programmingLanguage.lowercased() }
    }
  }

  @MainActor
  func getUser() async throws {
    do {
      headerLoadingState = .loading
      let result = try await dependencies
        .apiClient
        .getUser(dependencies.profileURL)

      user = DetailUser(
        username: result.value.login,
        legalName: result.value.name,
        followers: result.value.followers,
        followings: result.value.following,
        profileImageURL: result.value.avatarUrl
      )
      headerLoadingState = .done
    } catch let error {
      headerLoadingState = .failure(error)
      throw error
    }
  }

  @MainActor
  func getRepos(startingFromBeginning: Bool = false) async throws {
    if pageInfo?.next == nil, !startingFromBeginning {
      paginationDidReachEnd = true
      return
    }

    do {
      listLoadingState = .loading
      let startingURL: GitHubV3Service.GitHubPath? = startingFromBeginning ? .resourcePath(resource: dependencies.reposURL) : nil
      let params = startingFromBeginning ? initialParams : pageInfo?.next?.queryItems

      let response = try await dependencies
        .apiClient
        .getRepos(pageInfo?.next, startingURL, params)

      repos += response
        .value
        .filter { !$0.fork }
        .map {
          Repo(
            repositoryName: $0.name,
            programmingLanguage: $0.language ?? "",
            numberOfStars: $0.stargazersCount,
            description: $0.description ?? "",
            htmlURL: $0.htmlUrl
          )
        }

      sortedRepos = repos
      sortReposBy(sortMethod: selectedSortMethod)

      pageInfo = response.pageInfo
      listLoadingState = .done
    } catch let error {
      listLoadingState = .failure(error)
      throw error
    }
  }
}
