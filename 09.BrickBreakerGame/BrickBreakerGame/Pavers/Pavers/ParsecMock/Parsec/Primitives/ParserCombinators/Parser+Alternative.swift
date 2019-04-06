//
//  Parser+Alternative.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/28.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

public func empty<S, U, A>() -> LazyParser<S, U, A> {
  return parserZero()
}

public func empty<S, U, A>() -> Parser<S, U, A> {
  return empty()()
}

/**
 The alternative combinator is left-biased
 and will return the first succeeding parse tree.
 a. That means the parser p <|> q never tries parser q
 whenever parser p has consumed any input.
 b. If p success without consuming input the second alternative
 is favored if it consumes input.
 c. If p success without consuming input and the second alternative
 consumes nothing as well, the p empty okay result would be returned.
 d. If p failed without consuming input, the second alternative is favored.
 p          q         p<|>q
 Consumed   _         p.Consumed      (a)
 EmptyOkay  Consumed  q.Consumed      (b)
 EmptyOkay  Empty_    p.EmptyOkay     (c)
 EmptyError _         q.result        (d)
 */
public func <|> <S, U, A> (_ a: @escaping LazyParser<S, U, A>, _ b: @escaping LazyParser<S, U, A>)
  -> LazyParser<S, U, A> {
    return parserPlus(a, b)
}

public func <|> <S, U, A>
  (_ a: Parser<S, U, A>, _ b: Parser<S, U, A>)
  -> Parser<S, U, A> {
    return ({a} <|> {b})()
}

public func <|> <S, U, A> (_ a: Parser<S, U, A>, _ b: @escaping LazyParser<S, U, A>)
  -> LazyParser<S, U, A> {
    return {a} <|> b
}

public func <|> <S, U, A> (_ a: @escaping LazyParser<S, U, A>, _ b:Parser<S, U, A>)
  -> LazyParser<S, U, A> {
    return a <|> {b}
}


public func <||> <S, U, A> (_ a:@escaping LazyParser<S, U, A>,
                            _ b:@escaping LazyParser<S, U, A>)
  -> LazyParser<S, U, A> {
    return parserPrioritizedLongestMatch(a, b)
}

public func <||> <S, U, A> (_ a:@escaping LazyParser<S, U, A>,
                            _ b: Parser<S, U, A>)
  -> LazyParser<S, U, A> {
    return  a <||> {b}
}


public func <||> <S, U, A> (_ a:Parser<S, U, A>,
                            _ b: @escaping LazyParser<S, U, A>)
  -> LazyParser<S, U, A> {
    return  {a} <||> b
}

public func <||> <S, U, A> (_ a: Parser<S, U, A>,
                            _ b: Parser<S, U, A>)
  -> Parser<S, U, A> {
    return  ({a} <||> {b})()
}
