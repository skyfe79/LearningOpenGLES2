//
//  DFA2ENFA.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/17.
//  Copyright © 2018 Keith. All rights reserved.
//

public func transform<State, Sym>(dfa: DFA<State, Sym>) -> ENFA<State, Sym> {
  let transition: (State, Sym?) -> Set<State> = { state, input in
    if let sym = input {
      return [dfa.transition(state, sym)]
    } else {
      return []
    }
  }
  return ENFA(alphabet: dfa.alphabet,
              transition: transition,
              initial: dfa.initial,
              finals: dfa.finals)
}
