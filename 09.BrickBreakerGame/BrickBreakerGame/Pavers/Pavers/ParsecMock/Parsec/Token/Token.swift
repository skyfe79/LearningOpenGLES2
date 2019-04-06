//
//  Token.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/29.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

public func token<T, S, U, A>(
  showToken: @escaping (T) -> String,
  tokpos: @escaping (T) -> SourcePos,
  test: @escaping (T) -> A?)
  -> Parser<S, U, A> where S: ParserStream, S.Element == T{
    func nextPos(pos: SourcePos, tok: T, ts: S) -> SourcePos {
      switch uncons(ts) {
      case .none: return tokpos(tok)
      case .some(let (tok_, _)): return tokpos(tok_)
      }
    }
    return tokenPrim(showToken: showToken, nextPos:curry(nextPos), test: test)
}
