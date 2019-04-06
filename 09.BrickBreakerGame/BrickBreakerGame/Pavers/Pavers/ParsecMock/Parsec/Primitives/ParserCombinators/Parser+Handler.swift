//
//  Parser+Handler.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/9.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

public typealias ParserResultHandler<S, U, A> = (ParserResult<Reply<S, U, A>>) -> ()
public func attach<S, U, A>(_ p: @escaping LazyParser<S, U, A>, with handler: @escaping ParserResultHandler<S, U, A>)
  -> LazyParser<S, U, A> {
    return {Parser<S, U, A> { state in
      let x = p().unParser(state)
      handler(x)
      return x
      }
    }
}

public func attach<S, U, A>(_ p: Parser<S, U, A>, with handler: @escaping ParserResultHandler<S, U, A>)
  -> Parser<S, U, A> {
    return attach({p}, with: handler)()
}

public func <?> <S,U,A>(_ p: Parser<S, U, A>, handler: @escaping ParserResultHandler<S, U, A>)
  -> Parser<S, U, A> {
    return attach(p, with: handler)
}

public func <?> <S,U,A>(_ p: @escaping LazyParser<S, U, A>, handler: @escaping ParserResultHandler<S, U, A>)
  -> LazyParser<S, U, A> {
    return attach(p, with: handler)
}
