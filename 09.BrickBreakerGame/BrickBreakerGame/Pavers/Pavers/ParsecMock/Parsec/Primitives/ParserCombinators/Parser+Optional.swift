//
//  Parser+Optional.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/28.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP


public func optionalize<S, U, A>(_ a: @escaping LazyParser<S, U, A>) -> LazyParser<S, U, A?> {
  return {try_(a().fmap(Optional.init)) <|> pure(nil)}
}

postfix func .? <S,U,A> (_ a: @escaping LazyParser<S,U,A>)
  -> LazyParser<S,U,A?> {
    return optionalize(a)
}


public func optionalize<S, U, A>(_ a: Parser<S, U, A>) -> Parser<S, U, A?> {
  return optionalize({a})()
}

postfix func .? <S,U,A> (_ a: Parser<S,U,A>)
  -> Parser<S,U,A?> {
    return optionalize(a)
}




