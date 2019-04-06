//
//  NFA2DFA.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/17.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

/**
 Transform
 NFA N = (Qn, Σ, 𝛅n, q0, Fn)
 to
 DFA D = (Qd, Σ, 𝛅d, {q0}, Fd)
 using subset construction.
 */
public func transform<State, Sym>(nfa: NFA<State, Sym>) -> DFA<Set<State>, Sym> {
  let alphabet = nfa.alphabet
  let initial: Set<State> = [nfa.initial]
  var transitionMap: [Pair<Set<State>, Sym>: Set<State>] = [:]
  let transition: (Set<State>, Sym) -> Set<State> = { (states, a) in
    if let exists = transitionMap[Pair(states, a)] {
      return exists
    } else {
      let new: Set<State> = states
        .reduce([]) { (acc, p) in
          acc <> nfa.transition(p, a)}
      transitionMap[Pair(states, a)] = new
      return new
    }
  }
  
  let states: Set<Set<State>> = {
    var preState: Set<Set<State>> = [initial]
    var currentStates: Set<Set<State>> = [initial]
    repeat {
      preState = currentStates
      currentStates = nextAccessibleStates(of: currentStates, with: transition, and: alphabet)
    } while currentStates != preState
    return currentStates
  }()
  
  let finals = states.filter{!$0.intersection(nfa.finals).isEmpty}
  
  
  return DFA(alphabet: alphabet,
             transition: transition,
             initial: initial,
             finals: finals)
}
