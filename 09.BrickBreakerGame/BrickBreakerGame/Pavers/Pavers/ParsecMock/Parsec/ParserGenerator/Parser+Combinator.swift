//
//  Parser+Combinator.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/2.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

//choice :: (Stream s m t) => [ParsecT s u m a] -> ParsecT s u m a
//choice ps           = foldr (<|>) mzero ps

public func choice<S, U, A>(_ ps: [Parser<S, U, A>]) -> Parser<S, U, A> {
  return ps.reduce(parserZero(), (<|>))
}


//option :: (Stream s m t) => a -> ParsecT s u m a -> ParsecT s u m a
//option x p          = p <|> return x
public func option<S, U, A> (_ x: A, _ p: Parser<S, U, A>) -> Parser<S, U, A> {
  return p <|> pure(x)
}

//optionMaybe :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m (Maybe a)
//optionMaybe p       = option Nothing (liftM Just p)
public func optionMaybe<S, U, A> (_ p: Parser<S, U, A>) -> Parser<S, U, A?> {
  return option(nil, p.fmap{$0})
}

//optional :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m ()
//optional p          = do{ _ <- p; return ()} <|> return ()
public func optional<S, U, A> (_ p: Parser<S, U, A>) -> Parser<S, U, ()> {
  return p >>- {_ in pure(())}
}

//between :: (Stream s m t) => ParsecT s u m open -> ParsecT s u m close
//-> ParsecT s u m a -> ParsecT s u m a
//between open close p
//= do{ _ <- open; x <- p; _ <- close; return x }
public func between<S, U, A, O, C> (_ open: Parser<S, U, O>, _ close: Parser<S, U, C>, _ p: Parser<S, U, A>)
  -> Parser<S, U, A> {
    return open >>- {_ in  p >>- {a in close >>- {_ in pure(a) } } }
}

//skipMany1 :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m ()
//skipMany1 p         = do{ _ <- p; skipMany p }
public func skipMany1<S, U, A> (_ p: Parser<S, U, A>) -> Parser<S, U, ()> {
  return p >>- {_ in skipMany(p)}
}

//sepBy :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m sep -> ParsecT s u m [a]
//sepBy p sep         = sepBy1 p sep <|> return []

public func sepBy<S, U, A, SEP> (_ p: Parser<S, U, A>, _ sep: Parser<S, U, SEP>) -> Parser<S, U, [A]> {
  return sepBy1(p, sep) <|> pure([])
}


//sepBy1 :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m sep -> ParsecT s u m [a]
//sepBy1 p sep        = do{ x <- p
//  ; xs <- many (sep >> p)
//  ; return (x:xs)
//}
public func sepBy1<S, U, A, SEP> (_ p: Parser<S, U, A>, _ sep: Parser<S, U, SEP>) -> Parser<S, U, [A]> {
  return p >>- {x in many(sep >>- p) >>- {xs in pure([x]+xs)}}
}


//sepEndBy1 :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m sep -> ParsecT s u m [a]
//sepEndBy1 p sep     = do{ x <- p
//  ; do{ _ <- sep
//    ; xs <- sepEndBy p sep
//    ; return (x:xs)
//  }
//  <|> return [x]
//}

public func sepEndBy1<S, U, A, SEP> (_ p: Parser<S, U, A>, _ sep: Parser<S,U,SEP>) -> Parser<S, U, [A]> {
  //  let xs: Parser<S, U, [A]> =
  return p >>- {x in (sep >>- {_ in sepEndBy(p, sep) >>- {xs in pure([x] + xs)}}) <|> pure([]) }
}

//
//sepEndBy :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m sep -> ParsecT s u m [a]
//sepEndBy p sep      = sepEndBy1 p sep <|> return []
public func sepEndBy<S, U, A, SEP> (_ p: Parser<S, U, A>, _ sep: Parser<S,U,SEP>) -> Parser<S, U, [A]> {
  return sepEndBy1(p, sep) <|> pure([])
}

//endBy1 :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m sep -> ParsecT s u m [a]
//endBy1 p sep        = many1 (do{ x <- p; _ <- sep; return x })
public func endBy1<S, U, A, SEP> (_ p: Parser<S, U, A>, _ sep: Parser<S,U,SEP>) -> Parser<S, U, [A]> {
  return many1(p >>- {a in sep >>- {_ in pure(a)}})
}

//endBy :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m sep -> ParsecT s u m [a]
//endBy p sep         = many (do{ x <- p; _ <- sep; return x })
public func endBy<S, U, A, SEP> (_ p: Parser<S, U, A>, _ sep: Parser<S,U,SEP>) -> Parser<S, U, [A]> {
  return many(p >>- {a in sep >>- {_ in pure(a)}})
}

//count :: (Stream s m t) => Int -> ParsecT s u m a -> ParsecT s u m [a]
//count n p           | n <= 0    = return []
//  | otherwise = sequence (replicate n p)
public func count<S, U, A> (_ n: Int, _ p: Parser<S, U, A>) -> Parser<S, U, [A]> {
  guard n > 0 else { return pure([])}
  return sequence(Array(repeating: p, count: n))
}

public func sequence<S, U, A>(_ ps: [Parser<S, U, A>]) -> Parser<S, U, [A]> {
  guard let fp = ps.first else {return pure([])}
  return fp >>- {x in sequence(Array(ps.dropFirst())) >>- {xs in pure([x] + xs)} }
}


//chainr :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m (a -> a -> a) -> a -> ParsecT s u m a
//chainr p op x       = chainr1 p op <|> return x
public func chainr<S, U, A>(_ p: Parser<S, U, A>, _ op: Parser<S, U, (A) -> (A) -> A>, _ x: A) -> Parser<S, U, A> {
  return chainr1(p, op) <|> pure(x)
}

//chainr1 :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m (a -> a -> a) -> ParsecT s u m a
//chainr1 p op        = scan
//where
//scan      = do{ x <- p; rest x }
//
//rest x    = do{ f <- op
//  ; y <- scan
//  ; return (f x y)
//}
//<|> return x
public func chainr1<S, U, A>(_ p: Parser<S, U, A>, _ op: Parser<S, U, (A) -> (A) -> A>) -> Parser<S, U, A> {
  func scan() -> Parser<S, U, A> {
    return p >>- { x in rest(x) }
  }
  func rest(_ x: A) -> Parser<S, U, A> {
    return op >>- { f in scan() >>- {y in pure(f(x)(y))}}
  }
  return scan()
}

//chainl :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m (a -> a -> a) -> a -> ParsecT s u m a
//chainl p op x       = chainl1 p op <|> return x

public func chainl<S, U, A>(_ p: Parser<S, U, A>, _ op: Parser<S, U, (A) -> (A) -> A>, _ x: A) -> Parser<S, U, A> {
  return chainl1(p, op) <|> pure(x)
}

//chainl1 :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m (a -> a -> a) -> ParsecT s u m a
//chainl1 p op        = do{ x <- p; rest x }
//where
//rest x    = do{ f <- op
//  ; y <- p
//  ; rest (f x y)
//}
//<|> return x
public func chainl1<S, U, A>(_ p: Parser<S, U, A>, _ op: Parser<S, U, (A) -> (A) -> A>) -> Parser<S, U, A> {
  func rest(x: A) -> Parser<S, U, A> {
    return (op >>- {f in p >>- {y in rest(x: f(x)(y))}}) <|> pure(x)
  }
  return p >>- {x in rest(x: x)}
}


//anyToken :: (Stream s m t, Show t) => ParsecT s u m t
//anyToken            = tokenPrim show (\pos _tok _toks -> pos) Just
public func anyToken<S, U, A>() -> Parser<S, U, A> where S: ParserStream, S.Element == A {
  return tokenPrim(showToken: {"\($0)"},
                   nextPos: {pos in {_ in {_ in pos}}},
                   test: {$0})
}


//eof :: (Stream s m t, Show t) => ParsecT s u m ()
//eof                 = notFollowedBy anyToken <?> "end of input"
public func eof<S, U> () -> Parser<S, U, ()> where S: ParserStream {
  return notFollowedBy(anyToken()) <?> "end of input"
}

//notFollowedBy :: (Stream s m t, Show a) => ParsecT s u m a -> ParsecT s u m ()
//notFollowedBy p     = try (do{ c <- try p; unexpected (show c) }
//<|> return ()
//)
public func notFollowedBy<S, U, A>(_ p: Parser<S, U, A>) -> Parser<S,U,()> {
  let q: Parser<S, U, A> = try_(p)
  let x: Parser<S, U, ()>  = q >>- {c in unexpected("\(c)")}
  let y: Parser<S, U, ()> = x <|> pure(())
  return try_(y)
}

//manyTill :: (Stream s m t) => ParsecT s u m a -> ParsecT s u m end -> ParsecT s u m [a]
//manyTill p end      = scan
//where
//scan  = do{ _ <- end; return [] }
//<|>
//do{ x <- p; xs <- scan; return (x:xs) }

public func manyTill<S, U, A, End> (_ p: Parser<S,U,A>, _ end: Parser<S, U, End>) -> Parser<S, U, [A]> {
  func scan() -> Parser<S, U, [A]> {
    let m: Parser<S, U, [A]> = end >>- {_ in pure([])}
    let n: Parser<S, U, [A]> = p >>- {(x: A) in scan() >>- {(xs: [A]) in pure([x] + xs)}}
    return m <|> n
  }
  return scan()
}

//parserTrace :: (Show t, Stream s m t) => String -> ParsecT s u m ()
//parserTrace s = pt <|> return ()
//where
//pt = try $ do
//x <- try $ many1 anyToken
//trace (s++": " ++ show x) $ try $ eof
//fail (show x)
public func parserTrace<S,U>(_ s: String) -> Parser<S, U, ()>
  where S: ParserStream, S.Element == Any{
    let a: Parser<S, U, [Any]> = many1(anyToken() as Parser<S, U, Any>)
    let b: Parser<S, U, [Any]> = try_(a)
    let pt = b >>- { (x) -> Parser<S, U, ()> in
      let d: Parser<S, U, ()> = try_(eof())
      let c: Parser<S, U, ()> = trace("s: \(x)", d)
      return c >>- (parserFail("\(x)") as Parser<S, U, ()>)
    }
    return pt <|> pure(())
}


//parserTraced :: (Stream s m t, Show t) => String -> ParsecT s u m b -> ParsecT s u m b
//parserTraced s p = do
//parserTrace s
//p <|> trace (s ++ " backtracked") (fail s)
public func parserTraced<S, U>(_ s: String, _ p: Parser<S, U, Any>) -> Parser<S, U, Any>
  where S: ParserStream, S.Element == Any {
    let a: Parser<S, U, ()> = parserTrace(s)
    let b = p <|> trace("\(s) backtracked", (parserFail(s) as Parser<S, U, Any>))
    return a >>- b
}

public func trace<A>(_ msg: String, _ a: A) -> A {
  print(msg)
  return a
}
