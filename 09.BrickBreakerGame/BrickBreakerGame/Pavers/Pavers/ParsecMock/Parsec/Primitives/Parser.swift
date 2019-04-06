//
//  Primitive.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/27.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

/**
 Monadic Parser which can parse language both context free and context sensitive.
 Monadic Parser are unable to deal with left-recursion.
 The first thing a left-recursive parser would do is to call itself, resulting in an infinite
 
 `expr ::= expr "+" factor`
 
 `factor ::= number | "(" expr ")"`
 
 LL Parsing algorithm.
 
 predictive parser with limited look ahead.
 */
public struct Parser<S, U, A> {
  public let unParser: (ParserState<S, U>) -> ParserResult<Reply<S, U, A>>
}

public typealias ParserS<A> = Parser<String, (), A>
public typealias LazyParser<S, U, A> = () -> Parser<S, U, A>
public typealias LazyParserS<A> = LazyParser<String, (), A>
