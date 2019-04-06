//
//  Parser+Many.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/28.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

/// one or more, a+
public func manyAccum<S, U, A>(_ acc: @escaping ([A], A) -> [A], _ p : @escaping LazyParser<S, U, A>)
  -> LazyParser<S, U, [A]> {
    return p >>- {x in
      (manyAccum(acc, p) <|> (pure([]) as LazyParser<S, U, [A]>)) >>- {xs in
        pure(acc(xs, x)) as LazyParser<S, U, [A]> }}
}

public func manyAccum<S, U, A>(_ acc: @escaping ([A], A) -> [A], _ p : Parser<S, U, A>) -> Parser<S, U, [A]> {
  return manyAccum(acc, {p})()
}

/// one or more, a+
public func many1<S,U,A> (_ a: @escaping LazyParser<S,U,A>) -> LazyParser<S,U,[A]> {
  return manyAccum({ [$1] + $0}, a)
}

public func many1<S,U,A> (_ a: Parser<S,U,A>) -> Parser<S,U,[A]> {
  return many1({a})()
}

public postfix func .+<S, U, A>(_ a: @escaping LazyParser<S,U,A>) -> LazyParser<S,U,[A]> {
  return  many1(a)
}

public postfix func .+<S, U, A>(_ a: Parser<S,U,A>) -> Parser<S,U,[A]> {
  return  many1(a)
}

/// zero or more, a* = a+ | empty
public func many<S,U,A> (_ a: @escaping LazyParser<S,U,A>) -> LazyParser<S,U,[A]> {
  return  many1(a) <|> (pure([]) as LazyParser<S,U,[A]>)
}

public func many<S,U,A> (_ a: Parser<S,U,A>) -> Parser<S,U,[A]> {
  return many({a})()
}

public postfix func .*<S, U, A>(_ a: @escaping LazyParser<S,U,A>) -> LazyParser<S,U,[A]> {
  return  many(a)
}

public postfix func .*<S, U, A>(_ a: Parser<S,U,A>) -> Parser<S,U,[A]> {
  return  many(a)
}

public func skipMany<S,U,A>(_ p: @escaping LazyParser<S, U, A>) -> LazyParser<S, U, ()> {
  return fmap(many(p), {_ in ()})
}

public func skipMany<S,U,A>(_ p: Parser<S, U, A>) -> Parser<S, U, ()> {
  return skipMany({p})()
}

