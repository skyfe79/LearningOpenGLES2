//
//  Parser+Monad.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/28.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP


/**
 m a -> (a -> m b) -> m b
 p          q           (p>>=q)
 Empty      Empty       Empty
 Empty      Consumed    Consumed
 Consumed   Empty       Consumed
 Consumed   Consumed    Consumed
 */
public func >>- <S, U, A, B> (_ a: @escaping LazyParser<S, U, A>, _ f: @escaping (A) -> LazyParser<S, U, B>)
  -> LazyParser<S, U, B> {
    return parserBind(a, f)
}

public func >>- <S, U, A, B> (_ a: @escaping LazyParser<S, U, A>, _ f: @escaping (A) -> Parser<S, U, B>)
  -> LazyParser<S, U, B> {
    return a >>- {a in {f(a)}}
}

public func >>- <S, U, A, B> (_ a: Parser<S, U, A>, _ f: @escaping (A) -> LazyParser<S, U, B>)
  -> LazyParser<S, U, B> {
    return {a} >>- f
}


public func >>- <S, U, A, B> (_ a: Parser<S, U, A>, _ f: @escaping (A) -> Parser<S, U, B>) -> Parser<S, U, B> {
  return ({a} >>- f)()
}


/// m a -> m b -> m b
public func >>- <S, U, A, B> (_ a: @escaping LazyParser<S, U, A>, _ b: @escaping LazyParser<S, U, B>)
  -> LazyParser<S, U, B> {
    return a >>- {_ in b}
}


public func >>- <S, U, A, B> (_ a: Parser<S, U, A>, _ b: @escaping LazyParser<S, U, B>)
  -> LazyParser<S, U, B> {
    return a >>- {_ in b}
}

public func >>- <S, U, A, B> (_ a: @escaping LazyParser<S, U, A>, _ b: Parser<S, U, B>)
  -> LazyParser<S, U, B> {
    return a >>- {_ in b}
}

public func >>- <S, U, A, B> (_ a: Parser<S, U, A>, _ b: Parser<S, U, B>) -> Parser<S, U, B> {
  return a >>- {_ in b}
}
