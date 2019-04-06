//
//  RE2DFA.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/17.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

public func transform<Symbol>(re: RegularExpression<Symbol>) -> ENFA<Int, Symbol> {
  switch re {
  case .epsilon:
    let transition: (Int, Symbol?) -> Set<Int> = { state, input in
      state == 1 && input == nil ? [2] : []
    }
    return ENFA<Int, Symbol>(alphabet: [],
                             transition: transition,
                             initial: 1,
                             finals: [2])
  case .empty:
    let transition: (Int, Symbol?) -> Set<Int> = { state, input in [] }
    return ENFA<Int, Symbol>(alphabet: [],
                             transition: transition,
                             initial: 1,
                             finals: [2])
  case .primitives(let a):
    let transition: (Int, Symbol?) -> Set<Int> = { state, input in
      state == 1 && input == a ? [2] : []
    }
    return ENFA<Int, Symbol>(alphabet: [a],
                             transition: transition,
                             initial: 1,
                             finals: [2])
    
  case .union(let lhs, let rhs):
    let lhsENFA = transform(re: lhs)
    
    let lhsStateCount = lhsENFA.accessibleStates.count
    let renamedLHSENFA = renamedStates(of: lhsENFA, start: 2)
    let lhsStates = renamedLHSENFA.accessibleStates
//    print(lhsStates)
    
    let rhsENFA = transform(re: rhs)
    let rhsStateCount = rhsENFA.accessibleStates.count
    let renamedRHSENFA = renamedStates(of: rhsENFA, start: lhsStateCount + 2)
    let rhsStates = renamedRHSENFA.accessibleStates
//    print(rhsStates)
    
    let finals: Set<Int> = [1 + rhsStateCount + lhsStateCount + 1]
    
    let transition: (Int, Symbol?) -> Set<Int> = { state, input in
//      print("state: \(state), input:\(input)")
      
      if state == 1 && input == nil {
//        print("go to \([renamedLHSENFA.initial, renamedRHSENFA.initial])")
        return [renamedLHSENFA.initial, renamedRHSENFA.initial]
      } else if (renamedLHSENFA.finals <> renamedRHSENFA.finals).contains(state) && input == nil {
//        print("go to \(finals)")
        return finals
      } else if lhsStates.contains(state) {
//        print("go to \(renamedLHSENFA.transition(state,input))")
        return renamedLHSENFA.transition(state,input)
      } else if rhsStates.contains(state) {
//        print("go to \(renamedRHSENFA.transition(state,input))")
        return renamedRHSENFA.transition(state,input)
      } else {
//        print("go to \([])")
        return []
      }
    }
    let enfa = ENFA<Int, Symbol>(alphabet: lhsENFA.alphabet <> rhsENFA.alphabet,
                                 transition: transition,
                                 initial: 1,
                                 finals: finals)
//    print(enfa.accessibleStates)
    
    return enfa
    
  case .concatenation(let lhs, let rhs):
    
    let lhsENFA = transform(re: lhs)
    let lhsStateCount = lhsENFA.accessibleStates.count
    let renamedLHSENFA = lhsENFA
    let lhsStates = renamedLHSENFA.accessibleStates
//    print("concatenation lhsStates:\(lhsStates)")
    
    let rhsENFA = transform(re: rhs)
    let renamedRHSENFA = renamedStates(of: rhsENFA, start: lhsStateCount + 1)
    let rhsStates = renamedRHSENFA.accessibleStates
//    print("concatenation rhsStates:\(rhsStates)")
    
    
    let finals: Set<Int> = renamedRHSENFA.finals
    
    let transition: (Int, Symbol?) -> Set<Int> = { state, input in
      if renamedLHSENFA.finals.contains(state) {
        return [renamedRHSENFA.initial]
      } else if lhsStates.contains(state) {
        return renamedLHSENFA.transition(state,input)
      } else if rhsStates.contains(state) {
        return renamedRHSENFA.transition(state,input)
      } else {
        return []
      }
    }
    return ENFA<Int, Symbol>(alphabet: lhsENFA.alphabet <> rhsENFA.alphabet,
                             transition: transition,
                             initial: 1,
                             finals: finals)
    
  case .kleeneClosure(let re):
    let enfa = transform(re: re)
    let renamedENFA = renamedStates(of: enfa, start: 2)
    let renamedENFAStates = renamedENFA.accessibleStates
//    print(renamedENFAStates)
    
    let finals: Set<Int> = [renamedENFAStates.count + 2]
    
    let transition: (Int, Symbol?) -> Set<Int> = { state, input in
      if state == 1 && input == nil {
        return [renamedENFA.initial] <> finals
      } else if renamedENFA.finals.contains(state) && input == nil {
        return [renamedENFA.initial] <> finals
      } else if renamedENFAStates.contains(state){
        return renamedENFA.transition(state, input)
      } else {
        return []
      }
    }
    
    let enfa_ = ENFA<Int, Symbol>(alphabet: renamedENFA.alphabet,
                                  transition: transition,
                                  initial: 1,
                                  finals: finals)
    
//    print(enfa_.accessibleStates)
    
    return enfa_
    
  case .parenthesis(let re):
    return transform(re: re)
  }
}
