//
//  RE+Operators.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/18.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP
extension RegularExpression {
  public static func + (_ lhs: RegularExpression, _ rhs: RegularExpression)
    -> RegularExpression {
      switch (lhs, rhs) {
      case (.empty, let rhs):
        return rhs
      case (let lhs, .empty):
        return lhs
      default:
        return .union(lhs, rhs)
      }
  }
  
  public static func * (_ lhs: RegularExpression, _ rhs: RegularExpression)
    -> RegularExpression {
      switch (lhs, rhs) {
      case (.empty, _), (_, .empty):
        return .empty
      case (.epsilon, let rhs):
        return rhs
      case (let lhs, .epsilon):
        return lhs
      default:
        return .concatenation(lhs, rhs)
      }
  }
  
  public static postfix func .* (_ re: RegularExpression)
    -> RegularExpression {
      switch re {
      case .empty:
        return .empty
      case .epsilon:
        return .epsilon
      case .union(let lhs, let rhs):
        if case .epsilon = lhs {
          return .kleeneClosure(rhs)
        } else if case .epsilon = rhs {
          return .kleeneClosure(lhs)
        } else {
          return .kleeneClosure(re)
        }
      default:
        return .kleeneClosure(re)
      }
  }
}
