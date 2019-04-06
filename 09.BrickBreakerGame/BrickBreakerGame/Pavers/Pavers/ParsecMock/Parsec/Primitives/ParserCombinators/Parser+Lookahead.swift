//
//  Parser+Lookahead.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/4.
//  Copyright © 2018 Keith. All rights reserved.
//


//lookAhead :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m a
//lookAhead p =
//ParsecT $ \s _ cerr eok eerr -> do
//let eok' a _ _ = eok a s (newErrorUnknown (statePos s))
//unParser p s eok' cerr eok' eerr
public func lookAhead<S, U, A>(_ p: @escaping LazyParser<S, U, A>) -> LazyParser<S, U, A> {
  return {Parser<S, U, A> { state in
    switch p().unParser(state) {
    case .consumed(let reply):
      switch reply() {
      case let .ok(a, _, _):
        return .empty({.ok(a, state, ParserError(unknownErrorWith: state.statePos))})
      case let otherwise: return .consumed({otherwise})
      }
    case .empty(let reply):
      switch reply() {
      case let .ok(a, _, _):
        return .empty({.ok(a, state, ParserError(unknownErrorWith: state.statePos))})
      case let otherwise: return .empty({otherwise})
      }
    }
    }}
}

public func lookAhead<S, U, A>(_ p: Parser<S, U, A>) -> Parser<S, U, A> {
  return lookAhead({p})()
}
