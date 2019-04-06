//
//  PaversParsec2Tests.swift
//  PaversParsec2Tests
//
//  Created by Keith on 2018/6/25.
//  Copyright © 2018 Keith. All rights reserved.
//

import XCTest
import Foundation
@testable import PaversParsec2

class PaversParsec2Tests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.

  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  var json: String = """
  {
  "id": 98719339,
  "node_id": "MDEwOlJlcG9zaXRvcnk5ODcxOTMzOQ==",
  "name": "Pavers",
  "full_name": "KeithPiTsui/Pavers",
  "owner": {
    "login": "KeithPiTsui",
    "id": 12403137,
    "node_id": "MDQ6VXNlcjEyNDAzMTM3",
    "avatar_url": "https://avatars1.githubusercontent.com/u/12403137?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/KeithPiTsui",
    "html_url": "https://github.com/KeithPiTsui",
    "followers_url": "https://api.github.com/users/KeithPiTsui/followers",
    "following_url": "https://api.github.com/users/KeithPiTsui/following{/other_user}",
    "gists_url": "https://api.github.com/users/KeithPiTsui/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/KeithPiTsui/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/KeithPiTsui/subscriptions",
    "organizations_url": "https://api.github.com/users/KeithPiTsui/orgs",
    "repos_url": "https://api.github.com/users/KeithPiTsui/repos",
    "events_url": "https://api.github.com/users/KeithPiTsui/events{/privacy}",
    "received_events_url": "https://api.github.com/users/KeithPiTsui/received_events",
    "type": "User",
    "site_admin": false
  },
  "private": false,
  "html_url": "https://github.com/KeithPiTsui/Pavers",
  "description": "A collective framework to support functional programming in Swift",
  "fork": false,
  "url": "https://api.github.com/repos/KeithPiTsui/Pavers",
  "forks_url": "https://api.github.com/repos/KeithPiTsui/Pavers/forks",
  "keys_url": "https://api.github.com/repos/KeithPiTsui/Pavers/keys{/key_id}",
  "collaborators_url": "https://api.github.com/repos/KeithPiTsui/Pavers/collaborators{/collaborator}",
  "teams_url": "https://api.github.com/repos/KeithPiTsui/Pavers/teams",
  "hooks_url": "https://api.github.com/repos/KeithPiTsui/Pavers/hooks",
  "issue_events_url": "https://api.github.com/repos/KeithPiTsui/Pavers/issues/events{/number}",
  "events_url": "https://api.github.com/repos/KeithPiTsui/Pavers/events",
  "assignees_url": "https://api.github.com/repos/KeithPiTsui/Pavers/assignees{/user}",
  "branches_url": "https://api.github.com/repos/KeithPiTsui/Pavers/branches{/branch}",
  "tags_url": "https://api.github.com/repos/KeithPiTsui/Pavers/tags",
  "blobs_url": "https://api.github.com/repos/KeithPiTsui/Pavers/git/blobs{/sha}",
  "git_tags_url": "https://api.github.com/repos/KeithPiTsui/Pavers/git/tags{/sha}",
  "git_refs_url": "https://api.github.com/repos/KeithPiTsui/Pavers/git/refs{/sha}",
  "trees_url": "https://api.github.com/repos/KeithPiTsui/Pavers/git/trees{/sha}",
  "statuses_url": "https://api.github.com/repos/KeithPiTsui/Pavers/statuses/{sha}",
  "languages_url": "https://api.github.com/repos/KeithPiTsui/Pavers/languages",
  "stargazers_url": "https://api.github.com/repos/KeithPiTsui/Pavers/stargazers",
  "contributors_url": "https://api.github.com/repos/KeithPiTsui/Pavers/contributors",
  "subscribers_url": "https://api.github.com/repos/KeithPiTsui/Pavers/subscribers",
  "subscription_url": "https://api.github.com/repos/KeithPiTsui/Pavers/subscription",
  "commits_url": "https://api.github.com/repos/KeithPiTsui/Pavers/commits{/sha}",
  "git_commits_url": "https://api.github.com/repos/KeithPiTsui/Pavers/git/commits{/sha}",
  "comments_url": "https://api.github.com/repos/KeithPiTsui/Pavers/comments{/number}",
  "issue_comment_url": "https://api.github.com/repos/KeithPiTsui/Pavers/issues/comments{/number}",
  "contents_url": "https://api.github.com/repos/KeithPiTsui/Pavers/contents/{+path}",
  "compare_url": "https://api.github.com/repos/KeithPiTsui/Pavers/compare/{base}...{head}",
  "merges_url": "https://api.github.com/repos/KeithPiTsui/Pavers/merges",
  "archive_url": "https://api.github.com/repos/KeithPiTsui/Pavers/{archive_format}{/ref}",
  "downloads_url": "https://api.github.com/repos/KeithPiTsui/Pavers/downloads",
  "issues_url": "https://api.github.com/repos/KeithPiTsui/Pavers/issues{/number}",
  "pulls_url": "https://api.github.com/repos/KeithPiTsui/Pavers/pulls{/number}",
  "milestones_url": "https://api.github.com/repos/KeithPiTsui/Pavers/milestones{/number}",
  "notifications_url": "https://api.github.com/repos/KeithPiTsui/Pavers/notifications{?since,all,participating}",
  "labels_url": "https://api.github.com/repos/KeithPiTsui/Pavers/labels{/name}",
  "releases_url": "https://api.github.com/repos/KeithPiTsui/Pavers/releases{/id}",
  "deployments_url": "https://api.github.com/repos/KeithPiTsui/Pavers/deployments",
  "created_at": "2017-07-29T08:26:10Z",
  "updated_at": "2018-03-30T09:34:05Z",
  "pushed_at": "2018-06-26T09:12:51Z",
  "git_url": "git://github.com/KeithPiTsui/Pavers.git",
  "ssh_url": "git@github.com:KeithPiTsui/Pavers.git",
  "clone_url": "https://github.com/KeithPiTsui/Pavers.git",
  "svn_url": "https://github.com/KeithPiTsui/Pavers",
  "homepage": null,
  "size": 4890,
  "stargazers_count": 0,
  "watchers_count": 0,
  "language": "Swift",
  "has_issues": true,
  "has_projects": true,
  "has_downloads": true,
  "has_wiki": true,
  "has_pages": false,
  "forks_count": 0,
  "mirror_url": null,
  "archived": false,
  "open_issues_count": 0,
  "license": {
    "key": "mit",
    "name": "MIT License",
    "spdx_id": "MIT",
    "url": "https://api.github.com/licenses/mit",
    "node_id": "MDc6TGljZW5zZTEz"
  },
  "forks": 0,
  "open_issues": 0,
  "watchers": 0,
  "default_branch": "master",
  "network_count": 0,
  "subscribers_count": 0
  }
  """

  
  func testNSJSONSerialization() {
    self.measure {
      for _ in 1 ... 1 {
          _ = try? JSONSerialization.jsonObject(with: self.json.data(using: .utf8)!,
                                                          options:JSONSerialization.ReadingOptions(rawValue: 0))
      }
    }
  }
  
  func testParsecJSON() {
    let r = object().parse(ParserState.init(stringLiteral: self.json))
    print(r)
  }
}
