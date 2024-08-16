import Foundation

struct GitHubRepoPermissions: Codable {
    let admin: Bool
    let push: Bool
    let pull: Bool
}
