//
//  ENFA.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/12.
//  Copyright © 2018 Keith. All rights reserved.
//

import Foundation


import PaversFRP

public struct ENFA<State, Sym>
where State: Hashable, Sym: Hashable {
  public let alphabet: Set<Sym>
  public let transition: (State, Sym?) -> Set<State>
  public let initial: State
  public let finals: Set<State>
}

extension ENFA {
  public func extendedTransition<C>(_ state: State, _ symbols: C) -> Set<State>
    where C: BidirectionalCollection, C.Element == Sym {
      // base case: when input is empty,
      // return the e-closure of the state
      guard let a = symbols.last else { return self.eclosure(of: state) }
      
      // inductive case: when input is not empty,
      // hence the input can be represented as w = xa,
      // where the a is last symbol of the input.
      // Given the extendedTransition of state and x,
      // we can get the extendedTransition of w,
      let ps = extendedTransition(state, symbols.dropLast())
      
      // by calculating the set of state that can be reached with
      // a transition on a
      let rs = ps.reduce([])
      {(acc, p) -> Set<State> in acc <> transition(p, a)}
      
      // lastly, calculate the e-closure of a-transited set.
      let ers = rs.reduce([])
      {(acc, p) -> Set<State> in acc <> self.eclosure(of: p)}
      
      return ers
  }
}


extension ENFA {
  public var accessibleStates : Set<State> {
    var preAccessibleStates: Set<State> = [initial]
    var currentAccessibleStates: Set<State> = [initial]
    var newAddedStates: Set<State> = [initial]
    repeat {
      preAccessibleStates = currentAccessibleStates
      newAddedStates = nextAccessibleStates(of: newAddedStates, with: transition, and: alphabet)
      currentAccessibleStates = newAddedStates <> currentAccessibleStates
    } while currentAccessibleStates != preAccessibleStates
    return currentAccessibleStates
  }
}

extension ENFA {
  public func eTransition(from state: State) -> Set<State> {
    return self.transition(state, nil)
  }
  
  public func eclosure(of state: State) -> Set<State> {
    var preStates: Set<State> = [state]
    var curStates: Set<State> = [state]
    var newStates: Set<State> = [state]
    repeat {
      newStates = Set(newStates.flatMap(self.eTransition))
      preStates = curStates
      curStates = curStates <> newStates
    } while preStates != curStates
    return curStates
  }
}



