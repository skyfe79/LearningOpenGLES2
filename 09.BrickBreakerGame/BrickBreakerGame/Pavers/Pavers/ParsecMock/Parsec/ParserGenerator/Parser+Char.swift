//
//  Parser+Char.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/2.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP


//oneOf :: (Stream s m Char) => [Char] -> ParsecT s u m Char
//oneOf cs            = satisfy (\c -> elem c cs)

public func oneOf<S, U>(_ cs: String)
  -> Parser<S, U, Character>
  where S: ParserStream, S.Element == Character {
    return oneOf(cs.chars)
}

public func oneOf<S, U>(_ cs: [Character])
  -> Parser<S, U, Character>
  where S: ParserStream, S.Element == Character {
  return satisfy(cs.contains)
}

//noneOf :: (Stream s m Char) => [Char] -> ParsecT s u m Char
//noneOf cs           = satisfy (\c -> not (elem c cs))
public func noneOf<S, U>(_ cs: String)
  -> Parser<S, U, Character> where S: ParserStream, S.Element == Character  {
    return noneOf(cs.chars)
}

public func noneOf<S, U>(_ cs: [Character])
  -> Parser<S, U, Character> where S: ParserStream, S.Element == Character  {
  return satisfy{ !cs.contains($0)}
}


//spaces :: (Stream s m Char) => ParsecT s u m ()
//spaces              = skipMany space        <?> "white space"
public func spaces<S, U> ()
  -> Parser<S, U, ()>
  where S: ParserStream, S.Element == Character {
  return skipMany(space()) <?> "white space"
}


//space :: (Stream s m Char) => ParsecT s u m Char
//space               = satisfy isSpace       <?> "space"
public func space<S,U> ()
  -> Parser<S,U,Character>
 where S: ParserStream, S.Element == Character{
  return satisfy(CharacterSet.whitespaces.contains) <?> "space"
}


//newline :: (Stream s m Char) => ParsecT s u m Char
//newline             = char '\n'             <?> "lf new-line"
public func newline<S, U>() -> Parser<S, U, Character>
  where S: ParserStream, S.Element == Character{
  return char("\n") <?> "lf new-line"
}

//crlf :: (Stream s m Char) => ParsecT s u m Char
//crlf                = char '\r' *> char '\n' <?> "crlf new-line"
public func crlf<S, U>() -> Parser<S, U, Character>
  where S: ParserStream, S.Element == Character {
  return (char("\r") >>- char("\n")) <?> "crlf new-line"
}

//endOfLine :: (Stream s m Char) => ParsecT s u m Char
//endOfLine           = newline <|> crlf       <?> "new-line"
public func endOfLine<S, U> () -> Parser<S, U, Character>
  where S: ParserStream, S.Element == Character {
    return newline() <|> crlf() <?> "new-line"
}


//tab :: (Stream s m Char) => ParsecT s u m Char
//tab                 = char '\t'             <?> "tab"
public func tab<S, U> () -> Parser<S, U, Character>
  where S: ParserStream, S.Element == Character {
    return char("\t") <?> "tab"
}

//upper :: (Stream s m Char) => ParsecT s u m Char
//upper               = satisfy isUpper       <?> "uppercase letter"
public func upper<S,U> ()
  -> Parser<S,U,Character>
  where S: ParserStream, S.Element == Character{
    return satisfy(CharacterSet.uppercaseLetters.contains) <?> "uppercase letter"
}


//lower :: (Stream s m Char) => ParsecT s u m Char
//lower               = satisfy isLower       <?> "lowercase letter"
public func lower<S,U> ()
  -> Parser<S,U,Character>
  where S: ParserStream, S.Element == Character{
    return satisfy(CharacterSet.lowercaseLetters.contains) <?> "lowercase letter"
}

//alphaNum :: (Stream s m Char => ParsecT s u m Char)
//alphaNum            = satisfy isAlphaNum    <?> "letter or digit"
public func alphaNum<S,U> ()
  -> Parser<S,U,Character>
  where S: ParserStream, S.Element == Character{
    return satisfy(CharacterSet.alphanumerics.contains) <?> "letter or digit"
}

//letter :: (Stream s m Char) => ParsecT s u m Char
//letter              = satisfy isAlpha       <?> "letter"
public func letter<S,U> ()
  -> Parser<S,U,Character>
  where S: ParserStream, S.Element == Character{
    return satisfy(CharacterSet.letters.contains) <?> "letter"
}

//digit :: (Stream s m Char) => ParsecT s u m Char
//digit               = satisfy isDigit       <?> "digit"
public func digit <S,U> ()
  -> Parser<S,U,Character>
  where S: ParserStream, S.Element == Character{
    return satisfy(CharacterSet.decimalDigits.contains) <?> "digit"
}

//hexDigit :: (Stream s m Char) => ParsecT s u m Char
//hexDigit            = satisfy isHexDigit    <?> "hexadecimal digit"b

public func hexDigit <S,U> ()
  -> Parser<S,U,Character>
  where S: ParserStream, S.Element == Character{
    return satisfy(CharacterSet.asciiHexDigits.contains) <?> "hexadecimal Digit"
}

//octDigit :: (Stream s m Char) => ParsecT s u m Char
//octDigit            = satisfy isOctDigit    <?> "octal digit"
public func octDigit <S,U> ()
  -> Parser<S,U,Character>
  where S: ParserStream, S.Element == Character{
    return satisfy(CharacterSet.asciiOctalDigits.contains) <?> "octal Digit"
}

public func char<S, U>(_ c: Character) -> Parser<S, U, Character>
  where S: ParserStream, S.Element == Character {
    return satisfy(curry(==)(c))
}

//anyChar :: (Stream s m Char) => ParsecT s u m Char
//anyChar             = satisfy (const True)
public func anyChar <S,U> ()
  -> Parser<S,U,Character>
  where S: ParserStream, S.Element == Character{
    return satisfy(trueness)
}
