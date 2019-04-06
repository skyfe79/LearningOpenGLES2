//
//  RenameStates.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/17.
//  Copyright © 2018 Keith. All rights reserved.
//

public func renamedStates<State, Symbol>(of dfa: DFA<State, Symbol>, start: Int) -> DFA<Int, Symbol> {
  let states = dfa.accessibleStates
  let initialMap = [dfa.initial : 1]
  let restStates = states.subtracting([dfa.initial])
  let restMap = Dictionary.init(uniqueKeysWithValues: restStates.enumerated().map{(i, e) -> (State, Int) in (e, i + 2)})
  let stateMap = initialMap.withAllValuesFrom(restMap)
  let transition: (Int, Symbol) -> Int = { (stateInt, sym) in
    let s = stateMap.findFirst{(_, v) in v == stateInt}!.key
    let s_ = dfa.transition(s, sym)
    return stateMap[s_]!
  }
  let initialState = 1
  let finalStates: Set<Int> = Set(dfa.finals.map{stateMap[$0]!})
  return DFA(
    alphabet: dfa.alphabet,
    transition: transition,
    initial: initialState,
    finals: finalStates)
}

public func renamedStates<State, Symbol>(of enfa: NFA<State, Symbol>, start: Int) -> NFA<Int, Symbol> {
  let states = enfa.accessibleStates
  let initialState = start
  let initialMap = [enfa.initial : initialState]
  let restStates = states.subtracting([enfa.initial])
  let restMap = Dictionary.init(uniqueKeysWithValues: restStates.enumerated().map{(i, e) -> (State, Int) in (e, i + 1 + initialState)})
  
  let stateMap = initialMap.withAllValuesFrom(restMap)
  
  let transition: (Int, Symbol) -> Set<Int> = { (stateInt, sym) in
    let s = stateMap.findFirst{(_, v) in v == stateInt}?.key
    guard let ss = s else {
      return []
    }
    let s_ = enfa.transition(ss, sym).map{stateMap[$0]!}
    return Set(s_)
  }
  
  let finalStates: Set<Int> = Set(enfa.finals.map{stateMap[$0]!})
  return NFA(
    alphabet: enfa.alphabet,
    transition: transition,
    initial: initialState,
    finals: finalStates)
}

public func renamedStates<State, Symbol>(of enfa: ENFA<State, Symbol>, start: Int) -> ENFA<Int, Symbol> {
  let states = enfa.accessibleStates
  let initialState = start
  let initialMap = [enfa.initial : initialState]
  let restStates = states.subtracting([enfa.initial])
  let restMap = Dictionary.init(uniqueKeysWithValues: restStates.enumerated().map{(i, e) -> (State, Int) in (e, i + 1 + initialState)})
  
  let stateMap = initialMap.withAllValuesFrom(restMap)
  
  let transition: (Int, Symbol?) -> Set<Int> = { (stateInt, sym) in
    let s = stateMap.findFirst{(_, v) in v == stateInt}?.key
    guard let ss = s else {
      return []
    }
    let s_ = enfa.transition(ss, sym).map{stateMap[$0]!}
    return Set(s_)
  }
  
  let finalStates: Set<Int> = Set(enfa.finals.map{stateMap[$0]!})
  return ENFA(
    alphabet: enfa.alphabet,
    transition: transition,
    initial: initialState,
    finals: finalStates)
}
