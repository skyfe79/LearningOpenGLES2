//
//  Parser+Labeling.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/28.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

public func <?> <S,U,A> (_ a: @escaping LazyParser<S,U,A>, _ labels: [String]) -> LazyParser<S,U,A> {
  return {Parser {
    switch a().unParser($0) {
    case .empty(let r):
      switch r() {
      case .error(let e):
        return .empty({.error(expect(e, labels))})
      case let .ok(x, state, e):
        return .empty({.ok(x, state, expect(e, labels))})
      }
    case let otherwise: return otherwise
    }
    }}
}

public func <?> <S,U,A> (_ a: @escaping LazyParser<S,U,A>, _ label: String) -> LazyParser<S,U,A> {
  return a <?> [label]
}

public func <?> <S,U,A> (_ a: Parser<S,U,A>, _ labels: [String]) -> Parser<S,U,A> {
  return ({a} <?> labels)()
}

public func <?> <S,U,A> (_ a: Parser<S,U,A>, _ label: String) -> Parser<S,U,A> {
  return a <?> [label]
}


private func expect (_ e: ParserError, _ exp: String) -> ParserError {
  return expect(e, [exp])
}

private func expect (_ e: ParserError, _ exps: [String]) -> ParserError {
  return exps.reduce(e) { acc, msg in
    acc.add(error: Message.expect(msg))
  }
}
