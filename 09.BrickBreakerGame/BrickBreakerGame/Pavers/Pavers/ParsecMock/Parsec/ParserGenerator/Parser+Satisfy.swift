//
//  Parser+Satisfy.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/28.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

/// (a -> Bool) -> Parser a
public func satisfy<S,U,A>(_ test: @escaping (A) -> Bool)
  -> LazyParser<S, U, A> where S: ParserStream, S.Element == A {
    func showToken(_ c: A) -> String { return "\(c)"}
    func nextPos(_ pos: SourcePos, _ c: A, _ s: S) -> SourcePos {
      if let cc = c as? Character {
        return pos.update(PosBy: cc)
      } else {
        return pos.incPos()
      }
    }
    return {tokenPrim(showToken: showToken,
                     nextPos: curry(nextPos),
                     test: { (test($0) ? $0 : nil) })}
}

/// (a -> Bool) -> Parser a
public func satisfy<S,U,A>(_ test: @escaping (A) -> Bool)
  -> Parser<S, U, A> where S: ParserStream, S.Element == A {
    return satisfy(test)()
}



