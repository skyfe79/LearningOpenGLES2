//
//  DFA2NFA.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/17.
//  Copyright © 2018 Keith. All rights reserved.
//

public func transform<State, Sym>(dfa: DFA<State, Sym>) -> NFA<State, Sym> {
  let transition: (State, Sym) -> Set<State> = { state, input in
    [dfa.transition(state, input)]
  }
  return NFA(alphabet: dfa.alphabet,
             transition: transition,
             initial: dfa.initial,
             finals: dfa.finals)
}
