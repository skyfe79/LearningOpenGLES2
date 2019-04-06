//
//  Parser+Unpack.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/15.
//  Copyright © 2018 Keith. All rights reserved.
//
import PaversFRP

/// m a -> m b -> m (a, b)
public func >>> <S, U, A, B> (_ a: @escaping LazyParser<S, U, A>, _ b: @escaping LazyParser<S, U, B>)
  -> LazyParser<S, U, (A, B)> {
    return {a() >>- {a in b() >>- {b in pure((a, b))}}}
}

public func >>> <S, U, A, B> (_ a: @escaping LazyParser<S, U, A>, _ b:Parser<S, U, B>)
  -> LazyParser<S, U, (A, B)> {
    return a >>> {b}
}

public func >>> <S, U, A, B> (_ a: Parser<S, U, A>, _ b: @escaping LazyParser<S, U, B>)
  -> LazyParser<S, U, (A, B)> {
    return {a} >>> b
}

public func >>> <S, U, A, B> (_ a: Parser<S, U, A>, _ b: Parser<S, U, B>)
  -> Parser<S, U, (A, B)> {
    return ({a} >>> {b})()
}


public func >>> <S, U, A, B, C> (_ a: @escaping LazyParser<S, U, A>, _ b: @escaping LazyParser<S, U, (B,C) >)
  -> LazyParser<S, U, (A, B, C)> {
    return {a() >>- {(a: A) in b() >>- {(b: (B,C)) in pure(unpack(a, bc: b))}}}
}

public func >>> <S, U, A, B, C> (_ a: @escaping LazyParser<S, U, A>, _ b:Parser<S, U, (B,C)>)
  -> LazyParser<S, U, (A, B, C)> {
    return a >>> {b}
}

public func >>> <S, U, A, B, C> (_ a: Parser<S, U, A>, _ b: @escaping LazyParser<S, U, (B,C)>)
  -> LazyParser<S, U, (A, B, C)> {
    return {a} >>> b
}

public func >>> <S, U, A, B, C> (_ a: Parser<S, U, A>, _ b: Parser<S, U, (B,C)>)
  -> Parser<S, U, (A, B, C)> {
    return ({a} >>> {b})()
}



public func >>> <S, U, A, B, C, D> (_ a: @escaping LazyParser<S, U, A>, _ b: @escaping LazyParser<S, U, (B,C,D) >)
  -> LazyParser<S, U, (A, B, C, D)> {
    return {a() >>- {a in b() >>- {b in pure(unpack(a, bc: b))}}}
}

public func >>> <S, U, A, B, C, D> (_ a: @escaping LazyParser<S, U, A>, _ b:Parser<S, U, (B,C,D)>)
  -> LazyParser<S, U, (A, B, C, D)> {
    return a >>> {b}
}

public func >>> <S, U, A, B, C, D> (_ a: Parser<S, U, A>, _ b: @escaping LazyParser<S, U, (B,C, D)>)
  -> LazyParser<S, U, (A, B, C, D)> {
    return {a} >>> b
}

public func >>> <S, U, A, B, C, D> (_ a: Parser<S, U, A>, _ b: Parser<S, U, (B,C, D)>)
  -> Parser<S, U, (A, B, C, D)> {
    return ({a} >>> {b})()
}


public func >>> <S, U, A, B, C, D, E> (_ a: @escaping LazyParser<S, U, A>, _ b: @escaping LazyParser<S, U, (B,C,D, E) >)
  -> LazyParser<S, U, (A, B, C, D, E)> {
    return {a() >>- {a in b() >>- {b in pure(unpack(a, bc: b))}}}
}

public func >>> <S, U, A, B, C, D, E> (_ a: @escaping LazyParser<S, U, A>, _ b:Parser<S, U, (B,C,D, E)>)
  -> LazyParser<S, U, (A, B, C, D, E)> {
    return a >>> {b}
}

public func >>> <S, U, A, B, C, D, E> (_ a: Parser<S, U, A>, _ b: @escaping LazyParser<S, U, (B,C, D, E)>)
  -> LazyParser<S, U, (A, B, C, D, E)> {
    return {a} >>> b
}

public func >>> <S, U, A, B, C, D, E> (_ a: Parser<S, U, A>, _ b: Parser<S, U, (B,C, D, E)>)
  -> Parser<S, U, (A, B, C, D, E)> {
    return ({a} >>> {b})()
}


public func >>> <S, U, A, B, C, D, E, F> (_ a: @escaping LazyParser<S, U, A>, _ b: @escaping LazyParser<S, U, (B,C,D, E, F) >)
  -> LazyParser<S, U, (A, B, C, D, E, F)> {
    return {a() >>- {a in b() >>- {b in pure(unpack(a, bc: b))}}}
}

public func >>> <S, U, A, B, C, D, E, F> (_ a: @escaping LazyParser<S, U, A>, _ b:Parser<S, U, (B,C,D, E, F)>)
  -> LazyParser<S, U, (A, B, C, D, E, F)> {
    return a >>> {b}
}

public func >>> <S, U, A, B, C, D, E, F> (_ a: Parser<S, U, A>, _ b: @escaping LazyParser<S, U, (B,C, D, E, F)>)
  -> LazyParser<S, U, (A, B, C, D, E, F)> {
    return {a} >>> b
}

public func >>> <S, U, A, B, C, D, E, F> (_ a: Parser<S, U, A>, _ b: Parser<S, U, (B,C, D, E, F)>)
  -> Parser<S, U, (A, B, C, D, E, F)> {
    return ({a} >>> {b})()
}


public func >>> <S, U, A, B, C, D, E, F, G> (_ a: @escaping LazyParser<S, U, A>, _ b: @escaping LazyParser<S, U, (B,C,D, E, F, G) >)
  -> LazyParser<S, U, (A, B, C, D, E, F, G)> {
    return {a() >>- {a in b() >>- {b in pure(unpack(a, bc: b))}}}
}

public func >>> <S, U, A, B, C, D, E, F, G> (_ a: @escaping LazyParser<S, U, A>, _ b:Parser<S, U, (B,C,D, E, F, G)>)
  -> LazyParser<S, U, (A, B, C, D, E, F, G)> {
    return a >>> {b}
}

public func >>> <S, U, A, B, C, D, E, F, G> (_ a: Parser<S, U, A>, _ b: @escaping LazyParser<S, U, (B,C, D, E, F, G)>)
  -> LazyParser<S, U, (A, B, C, D, E, F, G)> {
    return {a} >>> b
}

public func >>> <S, U, A, B, C, D, E, F, G> (_ a: Parser<S, U, A>, _ b: Parser<S, U, (B,C, D, E, F, G)>)
  -> Parser<S, U, (A, B, C, D, E, F, G)> {
    return ({a} >>> {b})()
}
