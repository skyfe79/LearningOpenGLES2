//
//  Tokens.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/29.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

//tokens :: (Stream s m t, Eq t)
//=> ([t] -> String)      -- Pretty print a list of tokens
//-> (SourcePos -> [t] -> SourcePos)
//-> [t]                  -- List of tokens to parse
//-> ParsecT s u m [t]
//{-# INLINE tokens #-}
//tokens _ _ []
//  = ParsecT $ \s _ _ eok _ ->
//    eok [] s $ unknownError s
//tokens showTokens nextposs tts@(tok:toks)
//= ParsecT $ \(State input pos u) cok cerr _eok eerr ->


public func tokens <S, U, T>
  (_ showTokens: @escaping ([T]) -> String,
   _ nextPoss: @escaping (SourcePos) -> ([T]) -> SourcePos,
   _ tts:[T])
  -> Parser<S, U, [T]>
  where S: ParserStream, T: Equatable, S.Element == T{
    guard let t = tts.first else {
      return Parser<S, U, [T]> { state in
        ParserResult.empty({Reply.ok([], state, unknownError(state))})
      }
    }
    return Parser<S, U, [T]> { state in
      let _errEof = ParserError(newErrorWith: Message.sysUnExpect(""),
                                pos: state.statePos)
      let _errEofMsg = Message.expect(showTokens(tts))
      let  errEof = _errEof.set(errorMessages: [_errEofMsg])
      
      func errExpect(_ x: T) -> ParserError {
        let _err = ParserError(newErrorWith: Message.sysUnExpect(showTokens([x])),
                               pos: state.statePos)
        let _errMsg = Message.expect(showTokens(tts))
        let  err = _err.set(errorMessages: [_errMsg])
        return err
      }
      
      func walk(_ ts: [T], _ rs: S) -> ParserResult<Reply<S, U, [T]>> {
        guard let t = ts.first else {return ok(rs)}
        let sr = uncons(rs)
        switch sr {
        case .none: return ParserResult.consumed({Reply.error(errEof)})
        case .some(let (x, xs)):
          if t == x {return walk(Array(ts.dropFirst()), xs)}
          else { return ParserResult.consumed({Reply.error(errExpect(x))})}
        }
      }
      
      func ok(_ rs: S) -> ParserResult<Reply<S, U, [T]>> {
        let pos_ = nextPoss(state.statePos)(tts)
        let s_ = ParserState(stateInput: rs, statePos: pos_, stateUser: state.stateUser)
        return ParserResult.consumed(
          {Reply.ok(
            tts, s_, ParserError(unknownErrorWith: pos_))})
      }
      
      let sr = uncons(state.stateInput)
      switch sr {
      case .none: return ParserResult.empty({Reply.error(errEof)})
      case .some(let (x, xs)):
        if t == x {return walk(Array(tts.dropFirst()), xs)}
        else { return ParserResult.empty({Reply.error(errExpect(x))})}
      }
    }
}


