//
//  ParsecMockTests.swift
//  ParsecMockTests
//
//  Created by Keith on 2018/6/27.
//  Copyright © 2018 Keith. All rights reserved.
//

import XCTest
@testable import ParsecMock
import PaversFRP

class ParsecMockTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  static let json2: String = """
  {
  "id": 98719339,
  "node_id": "MDEwOlJlcG9zaXRvcnk5ODcxOTMzOQ==",
  "name": "Pavers",
  "full_name": "KeithPiTsui/Pavers",
  "kk":[1,2,3],
  "owner": {
    "login": "KeithPiTsui",
    "id": 12403137
  },
  "private": false
  }
  """
  
  static let json: String = """
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
  
  let parserStateString = ParserStateS("[1,2,3,\"123\",[1,2,3,\"123\"],4,5,{\"Keith\":\"Tsui\"}, 1, 2]")
  let parserStateObject = ParserStateS(ParsecMockTests.json2)
  let parserStateJSON = ParserStateS(ParsecMockTests.json)
  let parserStateTrue = ParserStateS("false")
  func testJSON() {
    let r =
      //      JSON.array().unParser(self.parserStateString)
      //    JSON.jstring.unParser(self.parserState)
      JSON.object().unParser(self.parserStateJSON)
    //      JSON.array().unParser(self.parserStateString)
    //    JSON.bool.unParser(self.parserStateTrue)
    print("\(r)")
    
    switch r {
    case .consumed(let r):
      switch r() {
      case .ok(_, _, _): break
      case .error(let e):
        print(e.description);
        XCTAssert(false)
      }
    case .empty(let r):
      switch r() {
      case .ok(_, _, _): break
      case .error(let e):
        print(e);
        XCTAssert(false)
      }
    }
  }
  
  func testA() {
    /**
     S ::= PQ | Q
     P ::= "P"
     Q ::= "PQ"
     */
    let p: ParserS<String> = string("P")
    let q: ParserS<String> = string("PQ")
    let s: ParserS<String> = (p >>- q) <|> q
    let r = s.unParser(ParserStateS("PQ"))
    print(r)
  }
  
  func testB() {
    /**
     S ::= PQ
     P ::= "P" | e
     Q ::= "PQ"
     */
    let p: ParserS<String> = string("P") <|> parserReturn("p")
    let q: ParserS<String> = string("PQ")
    let s: ParserS<String> = (p >>- q)
    let r = s.unParser(ParserStateS("PQ"))
    print(r)
  }
  
  func testNSJSONSerialization() {
    self.measure {
      for _ in 1 ... 1 {
        _ = try? JSONSerialization.jsonObject(with: ParsecMockTests.json.data(using: .utf8)!,
                                              options:JSONSerialization.ReadingOptions(rawValue: 0))
      }
    }
  }
  //
  func testParsecJSON() {
    self.measure {
      for _ in 1 ... 2 {
        _ = JSON.object().unParser(parserStateJSON)
      }
    }
  }
  //
  
  func testCharacterSet() {
    let ascii = CharacterSet.ascii
    print(ascii.characters)
  }
  
  func testDFA() {
    let customer = customerDFA()
    let bank = bankDFA()
    let store = storeDFA()
    let combined: DFA<Pair<Int, Int>, ElectronicMoneyEvents>
      = customer * bank
    let combined2: DFA<Pair<Pair<Int, Int>, Int>, ElectronicMoneyEvents>
      = combined * store
    let events: [ElectronicMoneyEvents] = [.pay, .ship, .redeem, .transfer]
    let result = process(input: events, on: combined2)
    print(result)
    XCTAssert(result, "DFA should accept the events")
  }
  
  func testNFA() {
    let input: [BinaryDigit] = [.zero, .zero, .one, .zero, .one]
    let ended01 = endedWith01()
    let state = ended01.extendedTransition(ended01.initial, input)
    let accepted = !ended01.finals.intersection(state).isEmpty
    print(accepted)
    print(ended01.accessibleStates)
    XCTAssert(accepted)
    
    let dfa01 = transform(nfa: ended01)
    let acceptedDFA = process(input: input, on: dfa01)
    print(acceptedDFA)
    print(dfa01.accessibleStates)
    XCTAssert(acceptedDFA)
  }
  
  func testKeywordAutomata() {
    let input = "xxseweb".chars
    let keywordNFA = keywords()
    let accepted = process(input: input, on: keywordNFA)
    print(accepted)
    print(keywordNFA.accessibleStates)
    XCTAssert(accepted)
    let keywordDFA = transform(nfa: keywordNFA)
    let acceptedDFA = process(input: input, on: keywordDFA)
    print(acceptedDFA)
    print(keywordDFA.accessibleStates)
    XCTAssert(acceptedDFA)
  }
  
  func testNumberENFA() {
    let input = "1255.635".chars
    let numberENFA = number()
    let accepted = process(input: input, on: numberENFA)
    print(accepted)
    print(numberENFA.accessibleStates)
    XCTAssert(accepted)
    
    let numberDFA = transform(enfa: numberENFA)
    let acceptedDFA = process(input: input, on: numberDFA)
    print(acceptedDFA)
    print(numberDFA.accessibleStates)
    XCTAssert(acceptedDFA)
  }
  
  func testSection() {
    let f = sec(2, +) >>> sec(3, +)
    let addedOne = [1,2,3].map(f)
    print(addedOne)
  }
  
  
  func testRE2DFA() {
    
    let zero = RegularExpression.primitives(0)
    let one = RegularExpression.primitives(1)
    let oneOrZeor = RegularExpression.union(zero, one)
    let manyOneOrZero = RegularExpression.kleeneClosure(oneOrZeor)
    
    let manyOneOrZeroThenOne = RegularExpression.concatenation(manyOneOrZero, one)
    let manyOneOrZeroThenOneThenOneOrZero = RegularExpression.concatenation(manyOneOrZeroThenOne, oneOrZeor)

    let enfa = transform(re: manyOneOrZeroThenOneThenOneOrZero)
    let input = [0, 0, 1, 0]
    let accepted = process(input: input, on: enfa)
    print(accepted)
    print("Alphabet of ENFA: \(enfa.alphabet)")
    print("States of ENFA: \(enfa.accessibleStates)")
    XCTAssert(accepted)
    
    
    let dfa_ = transform(enfa: enfa)
    let dfa = renamedStates(of: dfa_, start: 1)
    let acceptedDFA = process(input: input, on: dfa)
    print(acceptedDFA)
    print(dfa.accessibleStates)
    XCTAssert(acceptedDFA)
  }
  
  func testDFA2RE() {
    let zero = RegularExpression.primitives(0)
    let one = RegularExpression.primitives(1)
    let re = zero * (zero + one).*
    print(re)
    
    let enfa = transform(re: re)
    let input = [0, 1]
    let accepted = process(input: input, on: enfa)
    print(accepted)
    print("Alphabet of ENFA: \(enfa.alphabet)")
    print("States of ENFA: \(enfa.accessibleStates)")
    XCTAssert(accepted)
    
    let dfa_ = transform(enfa: enfa)
    let dfa = renamedStates(of: dfa_, start: 1)
    let acceptedDFA = process(input: input, on: dfa)
    print(acceptedDFA)
    print("Alphabet of DFA: \(dfa.alphabet)")
    print("States of DFA: \(dfa.accessibleStates)")
    XCTAssert(acceptedDFA)
    
    let dfa2re = regularExpression(of: dfa)
    print(dfa2re.description)
    
    
    let enfa_ = transform(re: dfa2re)
    let accepted_ = process(input: input, on: enfa_)
    print(accepted_)
    print("Alphabet of ENFA_: \(enfa_.alphabet)")
    print("States of ENFA_: \(enfa_.accessibleStates)")
    XCTAssert(accepted_)
    
    let dfa__ = transform(enfa: enfa_)
    let dfa___ = renamedStates(of: dfa__, start: 1)
    let acceptedDFA_ = process(input: input, on: dfa___)
    print(acceptedDFA_)
    print("Alphabet of DFA_: \(dfa___.alphabet)")
    print("States of DFA_: \(dfa___.accessibleStates)")
    XCTAssert(acceptedDFA_)
  }
  
  func testRES() {
    let x = RegularExpression.primitives(">")
    let y = RegularExpression.primitives("<")
    
    let enfa = transform(re: x + y)
    
    let input = ["a"]
    let accepted = process(input: input, on: enfa)
    print(accepted)
  }
  
  
  
}
