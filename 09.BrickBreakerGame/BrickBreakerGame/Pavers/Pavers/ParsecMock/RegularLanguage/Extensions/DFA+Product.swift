//
//  DFA+Product.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/18.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

public func * <StateA, StateB, Sym>(_ lhs: DFA<StateA, Sym>,
                                    _ rhs: DFA<StateB, Sym>)
  -> DFA<Pair<StateA, StateB>, Sym> {
    let alphabet = lhs.alphabet <> rhs.alphabet
    let transition: (Pair<StateA, StateB>, Sym) -> Pair<StateA, StateB> = { (pairState, sym) in
      let s1 = lhs.transition(pairState.first, sym)
      let s2 = rhs.transition(pairState.second, sym)
      return Pair(s1, s2)
    }
    let initialState: Pair<StateA, StateB> = Pair(lhs.initial, rhs.initial)
    let finalStates = cartesian(lhs.finals, rhs.finals)
    return DFA(alphabet: alphabet,
               transition: transition,
               initial: initialState,
               finals: finalStates)
}
