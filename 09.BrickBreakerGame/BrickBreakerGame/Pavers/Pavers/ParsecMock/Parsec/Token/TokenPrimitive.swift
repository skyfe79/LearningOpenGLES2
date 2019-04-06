//
//  TokenPrimitive.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/29.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

//private func testChar<U>(c: Character) -> Parser<String, U, Character> {
//  func showChar(x: Character) -> String {
//    return "'\(x)'"
//  }
//  func charTest(x: Character) -> Character? {
//    return x == c ? x : nil
//  }
//  func nextPos(pos: SourcePos, x: Character, xs: String) -> SourcePos {
//    return pos.update(PosBy: x)
//  }
//  return tokenPrim(showToken: showChar, nextPos: curry(nextPos), test: charTest)
//}


public func tokenPrim<T, S, U, A>(
  showToken: @escaping (T) -> String,
  nextPos: @escaping (SourcePos) -> (T) -> (S) -> SourcePos,
  test: @escaping (T) -> A?)
  -> Parser<S, U, A> where S: ParserStream, S.Element == T{
    return tokenPrimEx(showToken: showToken, nextPos: nextPos, nextState: nil, test: test)
}


public func tokenPrimEx<T, S, U, A>(
  showToken: @escaping (T) -> String,
  nextPos: @escaping (SourcePos) -> (T) -> (S) -> SourcePos,
  nextState: ((SourcePos) -> (T) -> (S) -> (U) -> U)?,
  test: @escaping (T) -> A?)
  -> Parser<S, U, A> where S: ParserStream, S.Element == T{
    guard let ns = nextState
      else {return tokenPrimEx_(showToken: showToken, nextPos: nextPos, test: test)}
    return tokenPrimEx__(showToken: showToken, nextPos: nextPos, nextState: ns, test: test)
}

public func tokenPrimEx_<T, S, U, A>(
  showToken: @escaping (T) -> String,
  nextPos: @escaping (SourcePos) -> (T) -> (S) -> SourcePos,
  test: @escaping (T) -> A?)
  -> Parser<S, U, A> where S: ParserStream, S.Element == T {
    return Parser<S, U, A> { state in
      let r = uncons(state.stateInput)
      switch r {
      case .none: return
        ParserResult<Reply<S, U, A>>.empty({
          Reply<S, U, A>.error(
            unexpectError(s: "", pos: state.statePos))})
      case .some(let (c, cs)):
        switch test(c) {
        case .none: return
          ParserResult<Reply<S, U, A>>.empty({
            Reply<S, U, A>.error(
              unexpectError(s: showToken(c), pos: state.statePos))})
        case .some(let x):
          let newPos = nextPos(state.statePos)(c)(cs)
          let newState = ParserState<S, U>(stateInput: cs, statePos: newPos, stateUser: state.stateUser)
          return ParserResult<Reply<S, U, A>>.consumed({
            Reply<S, U, A>.ok(x, newState, ParserError.init(newErrorWith: Message.message(""), pos: newPos))})
          
        }
      }
    }
}


public func tokenPrimEx__<T, S, U, A>(
  showToken: @escaping (T) -> String,
  nextPos: @escaping (SourcePos) -> (T) -> (S) -> SourcePos,
  nextState: @escaping (SourcePos) -> (T) -> (S) -> (U) -> U,
  test: @escaping (T) -> A?)
  -> Parser<S, U, A> where S: ParserStream, S.Element == T {
    return Parser<S, U, A> { state in
      let r = uncons(state.stateInput)
      switch r {
      case .none: return
        ParserResult<Reply<S, U, A>>.empty({
          Reply<S, U, A>.error(
            unexpectError(s: "", pos: state.statePos))})
      case .some(let (c, cs)):
        switch test(c) {
        case .none: return
          ParserResult<Reply<S, U, A>>.empty({
            Reply<S, U, A>.error(
              unexpectError(s: showToken(c), pos: state.statePos))})
        case .some(let x):
          let newPos = nextPos(state.statePos)(c)(cs)
          let newUser = nextState(state.statePos)(c)(cs)(state.stateUser)
          let newState = ParserState<S, U>(stateInput: cs, statePos: newPos, stateUser: newUser)
          return ParserResult<Reply<S, U, A>>.consumed({
            Reply<S, U, A>.ok(x, newState, ParserError.init(newErrorWith: Message.message(""), pos: newPos))})
          
        }
      }
    }
}
