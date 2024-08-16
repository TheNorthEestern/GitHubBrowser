import SwiftUI

extension GitHubRepo {
  static func generateMockRepositories(count: Int = 30) -> [GitHubRepo] {
    var repositories: [GitHubRepo] = []

    for i in 1...count {
      let owner = GitHubRepoOwner(
        login: "user\(i)",
        id: i,
        nodeId: "node\(i)",
        avatarUrl: URL(string: "https://example.com/avatar\(i).png")!,
        gravatarId: "",
        url: URL(string: "https://api.example.com/users/user\(i)")!,
        htmlUrl: URL(string: "https://example.com/users/user\(i)")!,
        followersUrl: URL(string: "https://api.example.com/users/user\(i)/followers")!,
        followingUrl: "https://api.example.com/users/user\(i)/following{/other_user}",
        gistsUrl: "https://api.example.com/users/user\(i)/gists{/gist_id}",
        starredUrl: "https://api.example.com/users/user\(i)/starred{/owner}{/repo}",
        subscriptionsUrl: URL(string: "https://api.example.com/users/user\(i)/subscriptions")!,
        organizationsUrl: URL(string: "https://api.example.com/users/user\(i)/orgs")!,
        reposUrl: URL(string: "https://api.example.com/users/user\(i)/repos")!,
        eventsUrl: "https://api.example.com/users/user\(i)/events{/privacy}",
        receivedEventsUrl: URL(string: "https://api.example.com/users/user\(i)/received_events")!,
        type: "User",
        siteAdmin: false
      )

      let permissions = GitHubRepoPermissions(admin: false, push: false, pull: true)

      let securityAndAnalysis = GitHubRepoSecurity(
        advancedSecurity: GitHubRepoSecurity.AdvancedSecurity(status: "enabled"),
        secretScanning: GitHubRepoSecurity.SecretScanning(status: "enabled"),
        secretScanningPushProtection: GitHubRepoSecurity.SecretScanningPushProtection(status: "disabled"),
        secretScanningNonProviderPatterns: GitHubRepoSecurity.SecretScanningNonProviderPatterns(status: "disabled")
      )

      let repository = GitHubRepo(
        id: i,
        nodeId: "MDEwOlJlcG9zaXRvcnkxMjk2MjY\(i)",
        name: "Repo\(i)",
        fullName: "user\(i)/Repo\(i)",
        owner: owner,
        isPrivate: false,
        htmlUrl: URL(string: "https://example.com/user\(i)/Repo\(i)")!,
        description: "This is undoubtedly an awesome repo.",
        fork: false,
        url: URL(string: "https://api.example.com/repos/user\(i)/Repo\(i)")!,
        archiveUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/{archive_format}{/ref}",
        assigneesUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/assignees{/user}",
        blobsUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/git/blobs{/sha}",
        branchesUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/branches{/branch}",
        collaboratorsUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/collaborators{/collaborator}",
        commentsUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/comments{/number}",
        commitsUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/commits{/sha}",
        compareUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/compare/{base}...{head}",
        contentsUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/contents/{+path}",
        contributorsUrl: URL(string: "https://api.example.com/repos/user\(i)/Repo\(i)/contributors")!,
        deploymentsUrl: URL(string: "https://api.example.com/repos/user\(i)/Repo\(i)/deployments")!,
        downloadsUrl: URL(string: "https://api.example.com/repos/user\(i)/Repo\(i)/downloads")!,
        eventsUrl: URL(string: "https://api.example.com/repos/user\(i)/Repo\(i)/events")!,
        forksUrl: URL(string: "https://api.example.com/repos/user\(i)/Repo\(i)/forks")!,
        gitCommitsUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/git/commits{/sha}",
        gitRefsUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/git/refs{/sha}",
        gitTagsUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/git/tags{/sha}",
        gitUrl: "git://example.com/user\(i)/Repo\(i).git",
        issueCommentUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/issues/comments{/number}",
        issueEventsUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/issues/events{/number}",
        issuesUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/issues{/number}",
        keysUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/keys{/key_id}",
        labelsUrl: "https://api.example.com/repos/user\(i)/Repo\(i)/labels{/name}",
        languagesUrl: URL(string: "https://api.example.com/repos/user\(i)/Repo\(i)/languages")!,
        mergesUrl: URL(string: "https://api.example.com/repos/user(i)/Repo(i)/merges")!,
        milestonesUrl: "https://api.example.com/repos/user(i)/Repo(i)/milestones{/number}",
        notificationsUrl: "https://api.example.com/repos/user(i)/Repo(i)/notifications{?since,all,participating}",
        pullsUrl: "https://api.example.com/repos/user(i)/Repo(i)/pulls{/number}",
        releasesUrl: "https://api.example.com/repos/user(i)/Repo(i)/releases{/id}",
        sshUrl: "git@github.com:user(i)/Repo(i).git",
        stargazersUrl: URL(string: "https://api.example.com/repos/user(i)/Repo(i)/stargazers")!,
        statusesUrl: "https://api.example.com/repos/user(i)/Repo(i)/statuses/{sha}",
        subscribersUrl: URL(string: "https://api.example.com/repos/user(i)/Repo(i)/subscribers")!,
        subscriptionUrl: URL(string: "https://api.example.com/repos/user(i)/Repo(i)/subscription")!,
        tagsUrl: URL(string: "https://api.example.com/repos/user(i)/Repo(i)/tags")!,
        teamsUrl: URL(string: "https://api.example.com/repos/user(i)/Repo(i)/teams")!,
        treesUrl: "https://api.example.com/repos/user(i)/Repo(i)/git/trees{/sha}",
        cloneUrl: URL(string: "https://example.com/user(i)/Repo(i).git")!,
        mirrorUrl: URL(string: "git://mirror.example.com/user(i)/Repo(i).git"),
        hooksUrl: URL(string: "https://api.example.com/repos/user(i)/Repo(i)/hooks")!,
        svnUrl: URL(string: "https://svn.example.com/user(i)/Repo(i)")!,
        homepage: "https://example.com",
        language: Color.githubLanguageColors.keys.randomElement(),
        forksCount: Int.random(in: 0...100),
        stargazersCount: Int.random(in: 0...1000),
        watchersCount: Int.random(in: 0...1000),
        size: Int.random(in: 0...1000),
        defaultBranch: "master",
        openIssuesCount: Int.random(in: 0...100),
        isTemplate: false,
        topics: ["topic1", "topic2", "topic3"],
        hasIssues: true,
        hasProjects: true,
        hasWiki: true,
        hasPages: false,
        hasDownloads: true,
        hasDiscussions: false,
        archived: false,
        disabled: false,
        visibility: "public",
        pushedAt: "2011-01-26T19:06:43Z",
        createdAt: "2011-01-26T19:01:12Z",
        updatedAt: "2011-01-26T19:14:43Z",
        permissions: permissions,
        securityAndAnalysis: securityAndAnalysis
      )
      repositories.append(repository)
    }
    return repositories
  }
}


