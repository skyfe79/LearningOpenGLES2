//
//  Parser+Monoid.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/5.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

extension Parser: Semigroup where A: Semigroup {
  public func op(_ other: Parser<S, U, A>) -> Parser<S, U, A> {
    return self.op({other})()
  }
  
  public func op(_ other: @escaping LazyParser<S, U, A>) -> LazyParser<S, U, A> {
    return self <> other
  }
}

extension Parser: Monoid where A: Monoid {
  public static func identity() -> Parser<S, U, A> {
    return pure(A.identity())
  }
}

/// (Monoid a) => m a -> m a -> m a
public func <> <S, U, A> (_ a: @escaping LazyParser<S, U, A>,
                           _ b: @escaping LazyParser<S, U, A>)
  -> LazyParser<S, U, A> where A: Semigroup {
    return
      a >>- { a_ in
        b >>- { b_ in
          pure(a_.op(b_)) as LazyParser<S, U, A>
        }
    }
}

public func <> <S, U, A> (_ a: @escaping LazyParser<S, U, A>, _ b:Parser<S, U, A>)
  -> LazyParser<S, U, A> where A: Semigroup {
    return a <> {b}
}

public func <> <S, U, A> (_ a: Parser<S, U, A>, _ b: @escaping LazyParser<S, U, A>)
  -> LazyParser<S, U, A> where A: Semigroup  {
    return {a} <> b
}

public func <> <S, U, A> (_ a: Parser<S, U, A>, _ b: Parser<S, U, A>)
  -> Parser<S, U, A> where A: Semigroup {
    return ({a} <> {b})()
}
