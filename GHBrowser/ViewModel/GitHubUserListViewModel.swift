import Foundation

class GitHubUserListViewModel: ObservableObject {
  struct Dependencies {
    let apiClient: GitHubApiClient
  }

  @Published var loadingState: LoadingState = .loading

  private let dependencies: Dependencies
  private var users = [SimpleUser]()
  private var pageInfo: GitHubV3Service.PageInfo? = nil

  var userCount: Int { users.count }

  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }

	func user(for indexPath: IndexPath) -> SimpleUser? {
		users[safe: indexPath.row]
	}

  func fetchUsers(fromStart fetchFromTheBeginning: Bool = false) {
    clearPageInfoAndUsersForRefreshIfNecessary(fetchingFromBeginning: fetchFromTheBeginning)
    Task.detached { [weak self] in
      guard let self else { return }
      do {
        loadingState = .loading
        let initialPath: GitHubV3Service.GitHubPath? = fetchFromTheBeginning ? .users : nil
        let params = fetchFromTheBeginning ? nil : pageInfo?.next?.queryItems
        let response = try await dependencies.apiClient.getUsers(pageInfo?.next, initialPath, params)
        users.append(contentsOf: response.value)
        pageInfo = response.pageInfo
        loadingState = .done
      } catch let error {
        loadingState = .failure(error)
      }
    }
  }
	
	private func clearPageInfoAndUsersForRefreshIfNecessary(fetchingFromBeginning: Bool) {
    guard fetchingFromBeginning else { return }
		users = []
	}
}
