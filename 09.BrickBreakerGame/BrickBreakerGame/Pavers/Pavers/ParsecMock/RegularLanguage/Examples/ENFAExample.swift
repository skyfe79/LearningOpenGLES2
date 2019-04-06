//
//  ENFAExample.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/13.
//  Copyright © 2018 Keith. All rights reserved.
//

public func number() -> ENFA<Int, Character> {
  let state1 = 0
  
  let alphebet: Set<Character> = Set("+-.0123456789".chars)
  
  let transitionMap: [Dictionary<Set<Character>, Set<Int>>] = [
    [[]:[1], ["+","-"]:[1], ["."]:[], ["0", "1", "2","3","4","5","6", "7", "8", "9"]:[]],
    [[]:[], ["+","-"]:[], ["."]:[2], ["0", "1", "2","3","4","5","6", "7", "8", "9"]:[1, 4]],
    [[]:[], ["+","-"]:[], ["."]:[], ["0", "1", "2","3","4","5","6", "7", "8", "9"]:[3]],
    [[]:[5], ["+","-"]:[], ["."]:[], ["0", "1", "2","3","4","5","6", "7", "8", "9"]:[3]],
    [[]:[], ["+","-"]:[], ["."]:[3], ["0", "1", "2","3","4","5","6", "7", "8", "9"]:[]],
    [[]:[], ["+","-"]:[], ["."]:[], ["0", "1", "2","3","4","5","6", "7", "8", "9"]:[]],
  ]
  
  let transition: (Int, Character?) -> Set<Int> = { state, input in
    let stateMap: [Set<Character> : Set<Int>] = transitionMap[state]
    if let nonNilInput = input {
      let filteredKeys = stateMap.first{ (key, _) -> Bool in key.contains(nonNilInput)}!
      return filteredKeys.value
    } else {
      return stateMap[[]]!
    }
  }
  let initialState = state1
  let finalStates: Set<Int> = [3, 7]
  return ENFA(alphabet: alphebet,
             transition: transition,
             initial: initialState,
             finals: finalStates)
}
