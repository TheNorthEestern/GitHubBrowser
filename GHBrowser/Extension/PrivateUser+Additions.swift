import Foundation

extension PrivateUser {
  static func createMockPrivateUser() -> Self {
    Self(
      login: "defunkt",
      id: 2,
      nodeId: "MDQ6VXNlcjI=",
      avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/2?v=4")!,
      gravatarId: "",
      url: URL(string: "https://api.github.com/users/defunkt")!,
      htmlUrl: URL(string: "https://github.com/defunkt")!,
      followersUrl: URL(string: "https://api.github.com/users/defunkt/followers")!,
      followingUrl: URL(string: "https://api.github.com/users/defunkt/following{/other_user}")!,
      gistsUrl: URL(string: "https://api.github.com/users/defunkt/gists{/gist_id}")!,
      starredUrl: URL(string: "https://api.github.com/users/defunkt/starred{/owner}{/repo}")!,
      subscriptionsUrl: URL(string: "https://api.github.com/users/defunkt/subscriptions")!,
      organizationsUrl: URL(string: "https://api.github.com/users/defunkt/orgs")!,
      reposUrl: URL(string: "https://api.github.com/users/defunkt/repos")!,
      eventsUrl: URL(string: "https://api.github.com/users/defunkt/events{/privacy}")!,
      receivedEventsUrl: URL(string: "https://api.github.com/users/defunkt/received_events")!,
      type: "User",
      siteAdmin: false,
      name: "Chris Wanstrath",
      company: nil,
      blog: "http://chriswanstrath.com/",
      location: nil,
      email: nil,
      hireable: nil,
      bio: "🍔",
      twitterUsername: nil,
      publicRepos: 107,
      publicGists: 274,
      followers: 22357,
      following: 215,
      createdAt: "2007-10-20T05:24:19Z",
      updatedAt: "2024-05-25T22:31:18Z"
    )
  }
}
