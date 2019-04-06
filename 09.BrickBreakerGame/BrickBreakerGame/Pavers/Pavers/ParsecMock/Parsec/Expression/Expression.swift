//
//  Expression.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/4.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

public enum Assoc {
  case assocNone
  case assocLeft
  case assocRight
}

public enum Operator<S, U, A> {
  case infix(Parser<S, U, (A) -> (A) -> A>, Assoc)
  case prefix(Parser<S, U, (A) -> A>)
  case postfix(Parser<S, U, (A) -> A>)
}

public typealias OperatorTable<S, U, A> = [[Operator<S, U, A>]]

/**
 -----------------------------------------------------------
 -- Convert an OperatorTable and basic term parser into
 -- a full fledged expression parser
 -----------------------------------------------------------
 
 -- | @buildExpressionParser table term@ builds an expression parser for
 -- terms @term@ with operators from @table@, taking the associativity
 -- and precedence specified in @table@ into account. Prefix and postfix
 -- operators of the same precedence can only occur once (i.e. @--2@ is
 -- not allowed if @-@ is prefix negate). Prefix and postfix operators
 -- of the same precedence associate to the left (i.e. if @++@ is
 -- postfix increment, than @-2++@ equals @-1@, not @-3@).
 --
 -- The @buildExpressionParser@ takes care of all the complexity
 -- involved in building expression parser. Here is an example of an
 -- expression parser that handles prefix signs, postfix increment and
 -- basic arithmetic.
 --
 -- >  expr    = buildExpressionParser table term
 -- >          <?> "expression"
 -- >
 -- >  term    =  parens expr
 -- >          <|> natural
 -- >          <?> "simple expression"
 -- >
 -- >  table   = [ [prefix "-" negate, prefix "+" id ]
 -- >            , [postfix "++" (+1)]
 -- >            , [binary "*" (*) AssocLeft, binary "/" (div) AssocLeft ]
 -- >            , [binary "+" (+) AssocLeft, binary "-" (-)   AssocLeft ]
 -- >            ]
 -- >
 -- >  binary  name fun assoc = Infix (do{ reservedOp name; return fun }) assoc
 -- >  prefix  name fun       = Prefix (do{ reservedOp name; return fun })
 -- >  postfix name fun       = Postfix (do{ reservedOp name; return fun })
 */

//buildExpressionParser :: (Stream s m t)
//=> OperatorTable s u m a
//-> ParsecT s u m a
//-> ParsecT s u m a
//buildExpressionParser operators simpleExpr
public func buildExpressionParser<S, U, A>
  (_ operators: OperatorTable<S, U, A>, _ simplerExpr: Parser<S, U, A>)
  -> Parser<S, U, A> {
    
    func makeParser(_ term: Parser<S,U,A>, _ ops: [Operator<S, U, A>]) -> Parser<S,U,A> {
      func splitOp(_ assoc: ([Parser<S, U, (A) -> (A) -> A>],
        [Parser<S, U, (A) -> (A) -> A>],
        [Parser<S, U, (A) -> (A) -> A>],
        [Parser<S, U, (A) -> A>],
        [Parser<S, U, (A) -> A>]),
                   _ op: Operator<S, U, A>)
        -> ([Parser<S, U, (A) -> (A) -> A>],
        [Parser<S, U, (A) -> (A) -> A>],
        [Parser<S, U, (A) -> (A) -> A>],
        [Parser<S, U, (A) -> A>],
        [Parser<S, U, (A) -> A>]) {
          let (rassoc,lassoc,nassoc,prefix,postfix) = assoc
          switch op {
          case .prefix(let op_): return (rassoc,lassoc,nassoc,[op_] + prefix,postfix)
          case .postfix(let op_): return (rassoc,lassoc,nassoc,prefix,[op_] + postfix)
          case .infix(let op_, let assoc_):
            switch assoc_ {
            case .assocNone: return (rassoc,lassoc,[op_] + nassoc,prefix,postfix)
            case .assocLeft: return (rassoc,[op_] + lassoc,nassoc,prefix,postfix)
            case .assocRight: return ([op_] + rassoc,lassoc,nassoc,prefix,postfix)
            }
          }
      }
      
      let (rassoc,lassoc,nassoc,prefix,postfix) = ops.reduce(([],[],[],[],[]), splitOp)
      let rassocOp: Parser<S, U, (A) -> (A) -> A>   = choice(rassoc)
      let lassocOp: Parser<S, U, (A) -> (A) -> A>   = choice(lassoc)
      let nassocOp: Parser<S, U, (A) -> (A) -> A>   = choice(nassoc)
      let prefixOp: Parser<S, U, (A) -> A>   = choice(prefix)  <?> ""
      let postfixOp: Parser<S, U, (A) -> A>  = choice(postfix) <?> ""
      
      func ambiguous(_ assoc: String, _ op: Parser<S, U, (A) -> (A) -> A>)
        -> Parser<S, U, A> {
          let a: Parser<S, U, A>
            = op >>- {_ in parserFail("ambiguous use of a \(assoc) associative operator")}
          return  try_(a)
      }
      
      let ambiguousRight    = ambiguous("right", rassocOp)
      let ambiguousLeft     = ambiguous ("left", lassocOp)
      let ambiguousNon      = ambiguous ("non", nassocOp)
      
      let postfixP: Parser<S, U, (A) -> A>   = postfixOp <|> pure(id)
      let prefixP: Parser<S, U, (A) -> A>    = prefixOp <|> pure(id)
      
      let termP: Parser<S, U, A> =
        prefixP >>- { pre in
          term >>- { x in
            postfixP >>- { post in
              pure(post(pre(x)))
            }
          }
      }

      func rassocP(_ x: A) -> Parser<S, U, A> {
        let my: Parser<S, U, A> = termP >>- { z in rassocP1(z)}
        let fxy: Parser<S, U, A> = rassocOp >>- { f in
          my >>- { y in
            pure(f(x)(y))
          }
        }
        return fxy <|> ambiguousLeft <|> ambiguousNon
      }
      
      func rassocP1(_ x: A) -> Parser<S, U, A> {
        return rassocP(x) <|> pure(x)
      }
      
      func lassocP(_ x: A) -> Parser<S, U, A> {
        let fxy: Parser<S, U, A> = lassocOp >>- { f in
          termP >>- { y in
            lassocP1(f(x)(y))
          }
        }
        return fxy <|> ambiguousRight <|> ambiguousNon
      }
      
      func lassocP1(_ x: A) -> Parser<S, U, A> {
        return lassocP(x) <|> pure(x)
      }
      
      func nassocP(_ x: A) -> Parser<S, U, A> {
        let fxy: Parser<S, U, A> = nassocOp >>- { f in
          termP >>- { y in
            let ret: Parser<S, U, A> = pure(f(x)(y))
            return ambiguousRight <|> ambiguousLeft <|> ambiguousNon <|> ret
          }
        }
        return fxy
      }
    
      return termP >>- { x in
        (rassocP(x) <|> lassocP(x) <|> nassocP(x) <|> pure(x)) <?> "operator"
      }
    }
    
    return operators.reduce(simplerExpr, makeParser)
}
