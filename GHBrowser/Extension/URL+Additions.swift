import Foundation

extension URL {
  var queryItems: [URLQueryItem]? {
    let components = URLComponents(url: self, resolvingAgainstBaseURL: false)
    return components?.queryItems
  }
}

