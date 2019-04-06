//
//  Parser+Applicative.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/28.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

public func pure<S, U, A> (_ a: A) -> LazyParser<S, U, A>{
  return parserReturn(a)
}

public func pure<S, U, A> (_ a: A) -> Parser<S, U, A> {
  return pure(a)()
}

// f (a -> b) -> f a -> f b
public func apply<S, U, A, B>(_ fab: @escaping LazyParser<S, U, (A) -> B>,
                              _ fa: @escaping LazyParser<S, U, A>)
  -> LazyParser<S, U, B> {
    return fab >>- { f in fa >>- { a in pure(f(a)) as LazyParser<S, U, B> } }
}

