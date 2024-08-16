import Foundation

struct GitHubRepo: Codable {
  let id: Int
  let nodeId: String
  let name: String
  let fullName: String
  let owner: GitHubRepoOwner
  let isPrivate: Bool
  let htmlUrl: URL
  let description: String?
  let fork: Bool
  let url: URL
  let archiveUrl: String
  let assigneesUrl: String
  let blobsUrl: String
  let branchesUrl: String
  let collaboratorsUrl: String
  let commentsUrl: String
  let commitsUrl: String
  let compareUrl: String
  let contentsUrl: String
  let contributorsUrl: URL
  let deploymentsUrl: URL
  let downloadsUrl: URL
  let eventsUrl: URL
  let forksUrl: URL
  let gitCommitsUrl: String
  let gitRefsUrl: String
  let gitTagsUrl: String
  let gitUrl: String
  let issueCommentUrl: String
  let issueEventsUrl: String
  let issuesUrl: String
  let keysUrl: String
  let labelsUrl: String
  let languagesUrl: URL
  let mergesUrl: URL
  let milestonesUrl: String
  let notificationsUrl: String
  let pullsUrl: String
  let releasesUrl: String
  let sshUrl: String
  let stargazersUrl: URL
  let statusesUrl: String
  let subscribersUrl: URL
  let subscriptionUrl: URL
  let tagsUrl: URL
  let teamsUrl: URL
  let treesUrl: String
  let cloneUrl: URL
  let mirrorUrl: URL?
  let hooksUrl: URL
  let svnUrl: URL
  let homepage: String?
  let language: String?
  let forksCount: Int
  let stargazersCount: Int
  let watchersCount: Int
  let size: Int
  let defaultBranch: String
  let openIssuesCount: Int
  let isTemplate: Bool
  let topics: [String]
  let hasIssues: Bool
  let hasProjects: Bool
  let hasWiki: Bool
  let hasPages: Bool
  let hasDownloads: Bool
  let hasDiscussions: Bool
  let archived: Bool
  let disabled: Bool
  let visibility: String
  let pushedAt: String?
  let createdAt: String
  let updatedAt: String
  let permissions: GitHubRepoPermissions
  let securityAndAnalysis: GitHubRepoSecurity?

  enum CodingKeys: String, CodingKey {
    case id
    case nodeId = "node_id"
    case name
    case fullName = "full_name"
    case owner
    case isPrivate = "private"
    case htmlUrl = "html_url"
    case description
    case fork
    case url
    case archiveUrl = "archive_url"
    case assigneesUrl = "assignees_url"
    case blobsUrl = "blobs_url"
    case branchesUrl = "branches_url"
    case collaboratorsUrl = "collaborators_url"
    case commentsUrl = "comments_url"
    case commitsUrl = "commits_url"
    case compareUrl = "compare_url"
    case contentsUrl = "contents_url"
    case contributorsUrl = "contributors_url"
    case deploymentsUrl = "deployments_url"
    case downloadsUrl = "downloads_url"
    case eventsUrl = "events_url"
    case forksUrl = "forks_url"
    case gitCommitsUrl = "git_commits_url"
    case gitRefsUrl = "git_refs_url"
    case gitTagsUrl = "git_tags_url"
    case gitUrl = "git_url"
    case issueCommentUrl = "issue_comment_url"
    case issueEventsUrl = "issue_events_url"
    case issuesUrl = "issues_url"
    case keysUrl = "keys_url"
    case labelsUrl = "labels_url"
    case languagesUrl = "languages_url"
    case mergesUrl = "merges_url"
    case milestonesUrl = "milestones_url"
    case notificationsUrl = "notifications_url"
    case pullsUrl = "pulls_url"
    case releasesUrl = "releases_url"
    case sshUrl = "ssh_url"
    case stargazersUrl = "stargazers_url"
    case statusesUrl = "statuses_url"
    case subscribersUrl = "subscribers_url"
    case subscriptionUrl = "subscription_url"
    case tagsUrl = "tags_url"
    case teamsUrl = "teams_url"
    case treesUrl = "trees_url"
    case cloneUrl = "clone_url"
    case mirrorUrl = "mirror_url"
    case hooksUrl = "hooks_url"
    case svnUrl = "svn_url"
    case homepage
    case language
    case forksCount = "forks_count"
    case stargazersCount = "stargazers_count"
    case watchersCount = "watchers_count"
    case size
    case defaultBranch = "default_branch"
    case openIssuesCount = "open_issues_count"
    case isTemplate = "is_template"
    case topics
    case hasIssues = "has_issues"
    case hasProjects = "has_projects"
    case hasWiki = "has_wiki"
    case hasPages = "has_pages"
    case hasDownloads = "has_downloads"
    case hasDiscussions = "has_discussions"
    case archived
    case disabled
    case visibility
    case pushedAt = "pushed_at"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case permissions
    case securityAndAnalysis = "security_and_analysis"
  }
}
