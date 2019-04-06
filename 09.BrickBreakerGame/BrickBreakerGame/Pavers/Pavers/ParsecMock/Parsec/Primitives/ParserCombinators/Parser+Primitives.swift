//
//  Primitives.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/9.
//  Copyright © 2018 Keith. All rights reserved.
//


//parserMap fmap
//parserReturn pure
//parserBind >>-
//parserFail Empty.Error
//parserZero Empty.Error
//parserPlus <|> choice

/// With the bind and choice combinator we can define almost any parser


/// fmap :: (a -> b) -> f a -> f b
public func parserMap<S, U, A, B>
  (_ fa: @escaping LazyParser<S, U, A>, _ f: @escaping (A) -> B)
  -> LazyParser<S, U, B> {
    return { Parser<S, U, B> { fa().unParser($0).fmap{ $0.fmap(f) } } }
}

//parserReturn :: a -> ParsecT s u m a
//parserReturn x
//= ParsecT $ \s _ _ eok _ ->
//eok x s (unknownError s)
public func parserReturn<S, U, A>(_ a: A) -> LazyParser<S, U, A> {
  return {Parser<S, U, A>{ state in
    .empty({.ok(a, state, ParserError(pos: state.statePos, msgs: []))})
    }
  }
}

public func parserReturn<S, U, A>(_ a: A) -> Parser<S, U, A> {
  return parserReturn(a)()
}


public func parserBind <S, U, A, B> (_ a: @escaping LazyParser<S, U, A>,
                                     _ f: @escaping (A) -> LazyParser<S, U, B>)
  -> LazyParser<S, U, B> {
    return {Parser{
      switch a().unParser($0) {
      case .consumed (let reply):
        return .consumed {
          switch reply() {
          case .error(let e): return .error(e)
          case let .ok(x, input, _):
            switch f(x)().unParser(input) {
            case .consumed(let r): return r()
            case .empty(let r): return r()
            }
          }
        }
      case .empty(let reply):
        switch reply() {
        case .error(let e): return .empty({.error(e)})
        case let .ok(x, input, _): return f(x)().unParser(input)
        }
      }
      }
    }
}

//parserFail :: String -> ParsecT s u m a
//parserFail msg
//= ParsecT $ \s _ _ _ eerr ->
//eerr $ newErrorMessage (Message msg) (statePos s)
public func parserFail<S, U, A>(_ msg: String) -> LazyParser<S, U, A> {
  return {Parser<S, U, A> { state in
    return ParserResult.empty(
      {Reply.error(ParserError(newErrorWith: Message.message(msg), pos: state.statePos))})
    }}
}

public func parserFail<S, U, A>(_ msg: String) -> Parser<S, U, A> {
  return parserFail(msg)()
}


//parserZero :: ParsecT s u m a
//parserZero
//= ParsecT $ \s _ _ _ eerr ->
//eerr $ unknownError s

public func parserZero<S, U, A> () -> Parser<S, U, A> {
  return parserZero()()
}

public func parserZero<S, U, A> () -> LazyParser<S, U, A> {
  return {Parser{ state in
    .empty({.error( ParserError(unknownErrorWith: state.statePos) )})
    }}
}


public func parserPlus <S, U, A> (_ a: @escaping LazyParser<S, U, A>, _ b: @escaping LazyParser<S, U, A>)
  -> LazyParser<S, U, A> {
    return {Parser { state in
      switch a().unParser(state) {
      case .consumed(let r): return .consumed(r)
        
      case .empty(let r):
        switch r() {
          
        case .error(let e1):
          switch b().unParser(state) {
          case .consumed(let r): return .consumed(r)
          case .empty(let r):
            switch r() {
            case .error(let e2):
              return .empty({.error(e1.op(e2))})
            case let .ok(x, s, e2):
              return .empty({.ok(x, s, e1.op(e2))})
            }
          }
        case let .ok(x, s, e1):
          switch b().unParser(state) {
          case .consumed(let r): return .consumed(r)
          case .empty(let r):
            switch r() {
            case .error(let e2):
              return .empty({.ok(x, s, e1.op(e2))})
            case let .ok(_, _, e2):
              return .empty({.ok(x, s, e1.op(e2))})
            }
          }
          
        }
      }
      }
    }
}

public func parserPrioritizedLongestMatch<S, U, A>
  (_ a:@escaping LazyParser<S, U, A>,
   _ b:@escaping LazyParser<S, U, A>)
  -> LazyParser<S, U, A> {
    return {Parser { state in
      let aResult = a().unParser(state)
      let bResult = b().unParser(state)
      switch (aResult, bResult) {
      case (.consumed(let ar), .consumed(let br)):
        let aReply = ar()
        let bReply = br()
        switch (aReply, bReply) {
        case let (.ok(aValue, aState, aUser), .ok(bValue, bState, bUser)):
          return bState.statePos > aState.statePos
            ? .consumed({.ok(bValue, bState, bUser)})
            : .consumed({.ok(aValue, aState, aUser)})
          
        default: break
        }
      default: break
      }
      return (parserPlus(a, b))().unParser(state)
      
      }
    }
}
