//
//  GenTokenParser.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/2.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

public typealias LanguageDef<U> = GenLanguageDef<String, U>

public struct GenLanguageDef<S, U> {
  public let commentStart: String
  public let commentEnd: String
  public let commentLine: String
  public let nestedComments: Bool
  public let identStart: Parser<S, U, Character>
  public let identLetter: Parser<S, U, Character>
  public let opStart: Parser<S, U, Character>
  public let opLetter: Parser<S, U, Character>
  public let reservedNames: [String]
  public let reservedOpNames: [String]
  public let caseSensitive: Bool
}


public typealias TokenParser<U> = GenTokenParser<String, U>

public struct GenTokenParser<S, U> {
  public typealias _Parser<T> = Parser<S, U, T>
  public let identifier: _Parser<String>
  public let reserved: (String) -> _Parser<()>
  public let `operator`: _Parser<String>
  public let reservedOp: (String) -> _Parser<()>
  public let charLiteral: _Parser<Character>
  public let stringLiteral: _Parser<String>
  public let natural: _Parser<Int>
  public let integer: _Parser<Int>
  public let `float`: _Parser<Double>
  public let naturalOrFloat: _Parser<Either<Int, Double>>
  public let decimal: _Parser<Int>
  public let hexadecimal: _Parser<Int>
  public let octal: _Parser<Int>
  public let symbol:(String) -> _Parser<String>
  public let lexeme: (_Parser<Any>) -> _Parser<Any>
  public let whiteSpace: _Parser<()>
  public let parens: (_Parser<Any>) -> _Parser<Any>
  public let braces: (_Parser<Any>) -> _Parser<Any>
  public let angles: (_Parser<Any>) -> _Parser<Any>
  public let brackets: (_Parser<Any>) -> _Parser<Any>
  public let squares: (_Parser<Any>) -> _Parser<Any>
  public let semi: _Parser<String>
  public let comma: _Parser<String>
  public let colon: _Parser<String>
  public let dot: _Parser<String>
  public let semiSep: (_Parser<Any>) -> _Parser<[Any]>
  public let semiSep1: (_Parser<Any>) -> _Parser<[Any]>
  public let commaSep: (_Parser<Any>) -> _Parser<[Any]>
  public let commaSep1: (_Parser<Any>) -> _Parser<[Any]>
}
