//
//  NFA.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/12.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

public struct NFA<State, Sym>
where State: Hashable, Sym: Hashable {
  public let alphabet: Set<Sym>
  public let transition: (State, Sym) -> Set<State>
  public let initial: State
  public let finals: Set<State>
}

extension NFA {
  public func extendedTransition<C>(_ state: State, _ symbols: C) -> Set<State>
    where C: BidirectionalCollection, C.Element == Sym {
      guard let a = symbols.last else { return [state] }
      return extendedTransition(state, symbols.dropLast())
        .reduce([])
        { (acc, ps) -> Set<State> in acc <> transition(ps, a) }
  }
}


extension NFA {
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




