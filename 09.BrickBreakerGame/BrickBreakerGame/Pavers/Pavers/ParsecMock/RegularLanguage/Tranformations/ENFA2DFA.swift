//
//  ENFA2DFA.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/17.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

/**
 Transform
 ENFA N = (Qn, Σ, 𝛅n, q0, Fn)
 to
 DFA D = (Qd, Σ, 𝛅d, {q0}, Fd)
 using subset construction.
 */
public func transform<State, Sym>(enfa: ENFA<State, Sym>) -> DFA<Set<State>, Sym> {
  let alphabet = enfa.alphabet
  
  let initial: Set<State> = enfa.eclosure(of: enfa.initial)
  
  
  var transitionMap: [Pair<Set<State>, Sym>: Set<State>] = [:]
  let transition: (Set<State>, Sym) -> Set<State> = { (states, a) in
    if let exists = transitionMap[Pair(states, a)] {
      return exists
    } else {
      
      let rs: Set<State> = states
        .reduce([]) { (acc, p) in
          acc <> enfa.transition(p, a)}
      
      let new = rs.reduce([])
      {(acc, p) -> Set<State> in acc <> enfa.eclosure(of: p)}
      
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
  
  let finals = states.filter{!$0.intersection(enfa.finals).isEmpty}
  
  
  return DFA(alphabet: alphabet,
             transition: transition,
             initial: initial,
             finals: finals)
}
