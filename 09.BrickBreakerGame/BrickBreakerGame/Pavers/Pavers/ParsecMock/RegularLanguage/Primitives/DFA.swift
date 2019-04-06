//
//  DFA.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/10.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

public struct DFA<State, Sym>
where State: Hashable, Sym: Hashable {
  public let alphabet: Set<Sym>
  public let transition: (State, Sym) -> State
  public let initial: State
  public let finals: Set<State>
}

extension DFA {
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

extension DFA {
  public func extendedTransition<C>(_ state: State, _ symbols: C) -> State
    where C: BidirectionalCollection, C.Element == Sym {
      guard let a = symbols.last else { return state }
      return transition(extendedTransition(state, symbols.dropLast()), a)
  }
}
