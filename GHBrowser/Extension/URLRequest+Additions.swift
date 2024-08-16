import Foundation

extension URLRequest {
  mutating func setValue(
    _ value: GitHubV3Service.HeaderValue.HeaderType,
    field: GitHubV3Service.HeaderField
  ) {
    let wrappedValue: String = {
      switch value {
      case let .apiVersion(version):
        return version.rawValue
      case let .contentType(type):
        return type.rawValue
      case let .bearerAuthorization(token):
        return "Bearer \(token)"
      }
    }()

    setValue(wrappedValue, forHTTPHeaderField: field.rawValue)
  }
}
