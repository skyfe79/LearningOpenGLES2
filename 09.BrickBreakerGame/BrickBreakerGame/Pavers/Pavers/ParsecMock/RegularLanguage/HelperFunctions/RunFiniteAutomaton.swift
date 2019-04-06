//
//  RunFiniteAutomaton.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/18.
//  Copyright © 2018 Keith. All rights reserved.
//

public func process<State, Sym, Seq>(input: Seq,
                                     on dfa: DFA<State, Sym>)
  -> Bool
  where Seq: Sequence, Seq.Element == Sym {
    var currentState = dfa.initial
    for e in input {
      currentState = dfa.transition(currentState, e)
    }
    return dfa.finals.contains(currentState)
}

public func process<State, Sym, C>(input: C,
                                   on nfa: NFA<State, Sym>)
  -> Bool
  where C: BidirectionalCollection, C.Element == Sym {
    let state = nfa.extendedTransition(nfa.initial, input)
    return !nfa.finals.intersection(state).isEmpty
}


public func process<State, Sym, C>(input: C,
                                   on enfa: ENFA<State, Sym>)
  -> Bool
  where C: BidirectionalCollection, C.Element == Sym {
    let state = enfa.extendedTransition(enfa.initial, input)
    return !enfa.finals.intersection(state).isEmpty
}
