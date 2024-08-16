import Foundation

struct URLConfig {
  static let baseURLComponents: URLComponents = {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.github.com"

    return components
  }()
  
  static var usersURL: URL? = {
    var userComponents = URLConfig.baseURLComponents
    userComponents.path = "/users"
    return userComponents.url
  }()
}

struct GitHubV3Service: Sendable {
  enum GitHubAPIError: Error {
    case requestFailed
    case urlConfigurationError
  }

  enum GitHubPath {
    case users
    case resourcePath(resource: URL)
  }

  enum HTTPMethod: String {
    case get = "GET"
  }

  enum HeaderField: String {
    case accept = "Accept"
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case githubAPIVersion = "X-GitHub-Api-Version"
  }

  struct HeaderValue {
    enum HeaderType {
      case contentType(type: ContentType)
      case apiVersion(version: APIVersion)
      case bearerAuthorization(token: String)
    }

    enum ContentType: String {
      case applicationJson = "application/json"
      case applicationGithubJson = "application/vnd.github+json"
    }

    enum APIVersion: String {
      case _2022_11_28 = "2022-11-28"
    }
  }

  struct PageInfo {
    var prev: URL?
    var next: URL?
    var first: URL?
    var last: URL?

    static func parse(links: [String: URL]) -> Self {
      PageInfo(
        prev: links["prev"],
        next: links["next"],
        first: links["first"],
        last: links["last"]
      )
    }
  }

  struct GithubBoxedResponse<BoxedObject> {
    let value: BoxedObject
    let pageInfo: PageInfo?
  }

  private let session = URLSession(configuration: .default)
  private let decoder = JSONDecoder()

  private func gitHubURLWith(path: GitHubPath, params: [URLQueryItem]?) -> URL? {
    switch path {
    case .users:
      return URLConfig.usersURL
    case let .resourcePath(url):
      var ephemeralComponents = URLConfig.baseURLComponents
      guard let resourcePathComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
      ephemeralComponents = resourcePathComponents
      ephemeralComponents.queryItems = params
      return ephemeralComponents.url
    }
  }

  private func parseLinkHeader(_ linkHeader: String) -> PageInfo {
    // Define the regex pattern to match links and their rel values
    let pattern = "<([^>]+)>; rel=\"([^\"]+)\""

    // Create a regex object
    guard let regex = try? NSRegularExpression(pattern: pattern) else {
      return PageInfo()
    }

    // Find all matches in the linkHeader
    let matches = regex.matches(in: linkHeader, options: [], range: NSRange(location: 0, length: linkHeader.count))

    let links = matches.reduce(into: [String: URL]()) { partialResult, match in
      if match.numberOfRanges == 3,
         let urlRange = Range(match.range(at: 1), in: linkHeader),
         let relRange = Range(match.range(at: 2), in: linkHeader) {
        let urlString = String(linkHeader[urlRange])
        let rel = String(linkHeader[relRange])

        if let url = URL(string: urlString) {
          partialResult[rel] = url
        }
      }
    }

    // Return the paginated links
    return .parse(links: links)
  }
  
  /// Creates a URLRequest with GitHub-specific headers.
  /// - Parameters:
  ///   - method: The HTTP method to be used for the request (e.g., GET, POST).
  ///   - url: The URL for the request.
  /// - Returns: A URLRequest configured with GitHub-specific headers.
  func requestWithGitHubHeaders(method: HTTPMethod, url: URL, params: [URLQueryItem]? = nil) throws -> URLRequest {
    guard let requestURL = gitHubURLWith(path: .resourcePath(resource: url), params: params) else { throw GitHubAPIError.urlConfigurationError }
    var request = URLRequest(url: requestURL)

    request.httpMethod = method.rawValue
    request.setValue(.contentType(type: .applicationGithubJson), field: .accept)
    request.setValue(.bearerAuthorization(token: ""), field: .authorization)
    request.setValue(.apiVersion(version: ._2022_11_28), field: .githubAPIVersion)

    return request
  }

  func getUser(with url: URL) async throws -> GitHubV3Service.GithubBoxedResponse<PrivateUser> {
    let request = try requestWithGitHubHeaders(method: .get, url: url)
    let (userData, _) = try await session.data(for: request)


    let user = try decoder.decode(
      PrivateUser.self,
      from: userData
    )

    return GithubBoxedResponse(value: user, pageInfo: nil)
  }

  /// Fetches a paginated collection of resources from a GitHub API endpoint.
  ///
  /// This function is designed to handle GitHub API requests that may span multiple pages of results.
  /// It can start from a given endpoint or continue from a provided URL for the next page of results.
  ///
  /// - Parameters:
  ///   - nextURL: The URL for the next page of results. If `nil`, the function will use the `endpoint` to start fetching results.
  ///   - endpoint: The GitHub API endpoint to start fetching results from. This parameter is used if `nextURL` is `nil`.
  /// - Returns: A `Result` containing either a `GithubBoxedResponse` with an array of `RemoteResource` if the request is successful, or a `GitHubAPIError` if the request fails.
  func getPaginatedCollection<RemoteResource: Decodable>(
    with nextURL: URL? = nil,
    startWith endpoint: GitHubPath? = nil,
    params: [URLQueryItem]? = nil
  ) async throws -> GithubBoxedResponse<[RemoteResource]> {
    let resourceURL = switch endpoint {
    case let .resourcePath(pathURL):
      pathURL
    case .users:
      URLConfig.usersURL
    case nil:
      nextURL
    }

    guard let resourceURL else { throw GitHubAPIError.urlConfigurationError }
    let request = try requestWithGitHubHeaders(method: .get, url: resourceURL, params: params)
    let (data, response) = try await session.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw URLError(.badServerResponse)
    }

    let decodedData = try decoder.decode(
      [RemoteResource].self,
      from: data
    )
    let pageInfo = parseLinkHeader(httpResponse.allHeaderFields["Link"] as? String ?? "")
    return GithubBoxedResponse(value: decodedData, pageInfo: pageInfo)
  }
}
