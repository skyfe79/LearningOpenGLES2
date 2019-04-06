//
//  RunParsec.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/1.
//  Copyright © 2018 Keith. All rights reserved.
//

import Foundation

//-- | Low-level unpacking of the ParsecT type. To run your parser, please look to
//-- runPT, runP, runParserT, runParser and other such functions.
//runParsecT :: Monad m => ParsecT s u m a -> State s u -> m (Consumed (m (Reply s u a)))
//runParsecT p s = parse s cok cerr eok eerr
//where
//parse = unParser p
//cok a s' err = return . Consumed . return $ Ok a s' err
//cerr err = return . Consumed . return $ Error err
//eok a s' err = return . Empty . return $ Ok a s' err
//eerr err = return . Empty . return $ Error err

//public func runParsecT <S, U, A, M:Monad>
//  (_ p: Parser<S, U, A>, _ s: ParserState<S, U>, _ dummy: M) ->
//  HKT_TypeParameter_Binder<M.HKTValueKeeper, ParserResult<HKT_TypeParameter_Binder<M.HKTValueKeeper, Reply<S, U, A>>>> {
//    switch p.unParser(s) {
//    case .consumed(let reply):
//      switch reply {
//      case let .ok(x, s_, e):
//        let ok: Reply<S, U, A> = Reply<S, U, A>.ok(x, s_, e)
//
//        // mok: HKT_TypeParameter_Binder<M.HKTValueKeeper, M.A>
//        // M.A == Reply<S, U, A>
//        let mok = M.return(ok as! M.A)
//
//        // cok : ParserResult<HKT_TypeParameter_Binder<M.HKTValueKeeper, M.A>>
//        let cok = ParserResult.consumed(mok)
//
//        // mcok: HKT_TypeParameter_Binder<M.HKTValueKeeper, M.A>
//        // M.A = ParserResult<HKT_TypeParameter_Binder<M.HKTValueKeeper, M.A>>
//        let mcok = M.return(cok as! M.A)
//
//        // Error: Cannot convert
//        // HKT_TypeParameter_Binder<M.HKTValueKeeper, M.A>
//        // into
//        // HKT_TypeParameter_Binder<M.HKTValueKeeper, ParserResult<HKT_TypeParameter_Binder<M.HKTValueKeeper, Reply<S, U, A>>>>
//        return mcok
//      case let .error(e): fatalError("left to implement")
//      }
//    case .empty(let reply): fatalError("left to implement")
//    }
//}
