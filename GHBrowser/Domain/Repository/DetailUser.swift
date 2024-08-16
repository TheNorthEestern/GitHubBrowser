import Foundation

struct DetailUser: Hashable, Identifiable {
  var id: UUID = UUID()
  let username: String
  let legalName: String?
  let followers: Int
  let followings: Int
  let profileImageURL: URL
}
