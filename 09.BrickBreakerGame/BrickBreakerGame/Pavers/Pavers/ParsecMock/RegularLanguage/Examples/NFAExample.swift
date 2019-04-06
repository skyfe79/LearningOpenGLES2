//
//  NFAExample.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/12.
//  Copyright © 2018 Keith. All rights reserved.
//

public enum BinaryDigit: CaseIterable {
  case zero
  case one
}


public func endedWith01() -> NFA<Int, BinaryDigit> {
  let state1 = 0

  let inputSymbols: Set<BinaryDigit> = Set(BinaryDigit.allCases)
  let transitionMap: [Dictionary<BinaryDigit, Set<Int>>] = [
    [.zero: [0, 1], .one: [0]],
    [.zero: [], .one: [2]],
    [.zero: [], .one: []],
  ]
  let transition: (Int, BinaryDigit) -> Set<Int> = { state, input in
    transitionMap[state][input]!
  }
  let initialState = state1
  let finalStates: Set<Int> = [2]
  return NFA(alphabet: inputSymbols,
             transition: transition,
             initial: initialState,
             finals: finalStates)
}

public func keywords() -> NFA<Int, Character> {
  let state1 = 0
  
  let alphebet: Set<Character> = Set(CharacterSet.asciiPrintables.characters)
  
  let transitionMap: [Dictionary<Set<Character>, Int>] = [
    [alphebet: 0, ["w"]:1, ["e"]:4],
    [["e"]:2],
    [["b"]:3],
    [:],
    [["b"]:5],
    [["a"]:6],
    [["y"]:7],
    [:]
    ]
  
  let transition: (Int, Character) -> Set<Int> = { state, input in
    let stateMap: [Set<Character> : Int] = transitionMap[state]
    let filteredKeys = stateMap.keys.filter{$0.contains(input)}
    return Set(filteredKeys.map{stateMap[$0]!})
  }
  let initialState = state1
  let finalStates: Set<Int> = [3, 7]
  return NFA(alphabet: alphebet,
             transition: transition,
             initial: initialState,
             finals: finalStates)
}
