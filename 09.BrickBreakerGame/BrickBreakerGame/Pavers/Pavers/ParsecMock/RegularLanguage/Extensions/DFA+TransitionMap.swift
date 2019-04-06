//
//  DFA+TransitionMap.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/18.
//  Copyright © 2018 Keith. All rights reserved.
//

extension DFA {
  public func transitionMap() -> [State:[Sym: State]] {
    return Dictionary(uniqueKeysWithValues:
      self.accessibleStates.map { (state) -> (State, [Sym: State]) in
        (state,
         Dictionary(uniqueKeysWithValues:
          self.alphabet
            .map{ (sym) -> (Sym, State) in
              (sym,
               transition(state, sym)
              )
          }
          )
        )
      }
    )
  }
}
