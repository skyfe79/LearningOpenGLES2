//
//  RE+PrettyPrint.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/18.
//  Copyright © 2018 Keith. All rights reserved.
//

extension RegularExpression: CustomStringConvertible {
  public var description: String {
    switch self {
    case .epsilon:
      return "ε"
    case .empty:
      return "∅"
    case .primitives(let s):
      return "\(s)"
    case .union(let lhs, let rhs):
      return "\(lhs.description) + \(rhs.description)"
    case .concatenation(let lhs, let rhs):
      return "(\(lhs.description))(\(rhs.description))"
    case .kleeneClosure(let re):
      return "(\(re.description))*"
    case .parenthesis(let re):
      return "(\(re.description)"
    }
  }
}
