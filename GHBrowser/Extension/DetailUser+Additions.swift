import Foundation

extension DetailUser {
  static func createMockDetailUser() -> Self {
    Self(
      username: "defunkt",
      legalName: "Chris Wanstrath",
      followers: 22357,
      followings: 215,
      profileImageURL: URL(string: "https://avatars.githubusercontent.com/u/2?v=4")!
    )
  }
}
