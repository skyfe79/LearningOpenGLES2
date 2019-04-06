//
//  ParserResult.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/27.
//  Copyright © 2018 Keith. All rights reserved.
//


/**
 ParserResult should lazinize its wrapped A to improve efficient.
 
 An LL(1) choice combinator only looks at its second alternative
 if the first hasn’t consumed any input – regardless of the final
 reply value! Now that the (>>=) combinator immediately returns a
 Consumed constructor as soon as some input has been consumed,
 the choice combinator can choose an alternative as soon as some
 input has been consumed. It no longer holds on to the original input,
 fixing the space leak of the previous combinators.
 */

public enum ParserResult<A> {
  public typealias lazyA = () -> A
  case consumed(lazyA)
  case empty(lazyA)
}

public enum Reply<S, U, A> {
  case ok(A, ParserState<S, U>, ParserError)
  case error(ParserError)
}


extension Reply {
  /// fmap :: (a -> b) -> f a -> f b
  public func fmap<B>(_ f: (A) -> B) -> Reply<S, U, B> {
    switch self {
    case let .ok(a, s, e): return .ok(f(a), s, e)
    case let .error(e): return .error(e)
    }
  }
}

extension ParserResult {
  /// fmap :: (a -> b) -> f a -> f b
  public func fmap<B>(_ f: @escaping (A) -> B) -> ParserResult<B> {
    switch self {
    case let .consumed(a): return .consumed({f(a())})
    case let .empty(a): return .empty({f(a())})
    }
  }
}

extension ParserResult: CustomStringConvertible {
  public var description: String {
    switch self {
    case .consumed(let a):
      return """
      ParserResult: Consumed
      \(a())
      """
    case .empty(let a):
      return """
      ParserResult: Empty (Not consumed any input)
      \(a())
      """
    }
  }
}

extension Reply: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .ok(a, state, e):
      return """
      Parse OK
      Got: \(a):\(type(of: a))
      NextState:
      \(state)
      Message:
      \(e)
      """
    case let .error(e):
      return """
      Parse Failed
      Message:
      \(e)
      """
    }
  }
}
