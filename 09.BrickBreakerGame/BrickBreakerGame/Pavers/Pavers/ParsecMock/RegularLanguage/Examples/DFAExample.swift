//
//  DFAExample.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/11.
//  Copyright © 2018 Keith. All rights reserved.
//

public enum ElectronicMoneyEvents: CaseIterable {
  case pay
  case ship
  case cancel
  case redeem
  case transfer
}


public func customerDFA() -> DFA<Int, ElectronicMoneyEvents> {
  let state1 = 1
  let inputSymbols: Set<ElectronicMoneyEvents> = Set(ElectronicMoneyEvents.allCases)
  let transition: (Int, ElectronicMoneyEvents) -> Int = { _,_ in state1 }
  let initialState = state1
  let finalStates: Set<Int> = [state1]
  return DFA(//states: states,
             alphabet: inputSymbols,
             transition: transition,
             initial: initialState,
             finals: finalStates)
}

public func bankDFA() -> DFA<Int, ElectronicMoneyEvents> {
  let state1 = 1
  let inputSymbols: Set<ElectronicMoneyEvents> = Set(ElectronicMoneyEvents.allCases)
  let transitionMap: [Dictionary<ElectronicMoneyEvents, Int>] = [
    [.pay: 0, .ship: 0, .cancel: 0, .redeem: 0, .transfer: 0],
    [.pay: 1, .ship: 1, .cancel: 2, .redeem: 3, .transfer: 0],
    [.pay: 2, .ship: 2, .cancel: 0, .redeem: 0, .transfer: 0],
    [.pay: 3, .ship: 3, .cancel: 3, .redeem: 3, .transfer: 4],
    [.pay: 3, .ship: 3, .cancel: 3, .redeem: 3, .transfer: 0]
  ]
  let transition: (Int, ElectronicMoneyEvents) -> Int = { state, input in
    transitionMap[state][input]!
  }
  let initialState = state1
  let finalStates: Set<Int> = [2, 4]
  return DFA(alphabet: inputSymbols,
             transition: transition,
             initial: initialState,
             finals: finalStates)
}

public func storeDFA() -> DFA<Int, ElectronicMoneyEvents> {
  let state1 = 1
  let inputSymbols: Set<ElectronicMoneyEvents> = Set(ElectronicMoneyEvents.allCases)
  let transitionMap: [Dictionary<ElectronicMoneyEvents, Int>] = [
    [.pay: 0, .ship: 0, .cancel: 0, .redeem: 0, .transfer: 0],
    [.pay: 2, .ship: 0, .cancel: 1, .redeem: 0, .transfer: 0],
    [.pay: 2, .ship: 3, .cancel: 2, .redeem: 4, .transfer: 0],
    [.pay: 3, .ship: 0, .cancel: 3, .redeem: 5, .transfer: 0],
    [.pay: 4, .ship: 5, .cancel: 4, .redeem: 0, .transfer: 6],
    [.pay: 5, .ship: 0, .cancel: 5, .redeem: 0, .transfer: 7],
    [.pay: 6, .ship: 7, .cancel: 6, .redeem: 0, .transfer: 0],
    [.pay: 7, .ship: 0, .cancel: 7, .redeem: 0, .transfer: 0],
    ]
  let transition: (Int, ElectronicMoneyEvents) -> Int = { state, input in
    transitionMap[state][input]!
  }
  let initialState = state1
  let finalStates: Set<Int> = [7]
  return DFA(alphabet: inputSymbols,
             transition: transition,
             initial: initialState,
             finals: finalStates)
}
