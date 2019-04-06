//
//  Parser+Try.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/28.
//  Copyright © 2018 Keith. All rights reserved.
//

/**
 The (try_(a)) parser behaves exactly like parser p
 but pretends it hasn't consumed any input when p fails.
 */
public func try_ <S, U, A> (_ a: @escaping LazyParser<S, U, A>) -> LazyParser<S, U, A> {
  return {Parser {
    switch a().unParser($0) {
    case .consumed(let r):
      switch r() {
      case .error(let e):
        return .empty({.error(e)})
      case .ok(_, _, _):
        return .consumed(r)
      }
    case let otherwise:
      return otherwise
    }
    }}
}

public func try_ <S, U, A> (_ a: Parser<S, U, A>) -> Parser<S, U, A> {
  return try_({a})()
}



