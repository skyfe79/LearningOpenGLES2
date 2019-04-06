//
//  nextAccessibleStates.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/17.
//  Copyright © 2018 Keith. All rights reserved.
//
import PaversFRP

public func nextAccessibleStates<State, Sym>
  (of states: Set<State>,
   with transition: (State, Sym?) -> Set<State>,
   and alphabet: Set<Sym>) -> Set<State> {
  return
    Set(states.flatMap { (state) -> Set<State> in
      let x: [State] =  alphabet.flatMap{ (sym) in transition(state, sym)}
      let x_: [State] =  x.flatMap{ (s) in transition(s, nil)}
      let y: Set<State> = transition(state, nil)
      return Set(x) <> Set(x_) <> y
    })
}

public func nextAccessibleStates<State, Sym>
  (of states: Set<State>,
   with transition: (State, Sym?) -> State,
   and alphabet: Set<Sym>) -> Set<State> {
  return
    Set(states.flatMap { (state) in
      alphabet.map{ (sym) in
        transition(state, sym)}
    })
}

public func nextAccessibleStates<State, Sym>
  (of states: Set<State>,
   with transition: (State, Sym) -> Set<State>,
   and alphabet: Set<Sym>) -> Set<State> {
  return
    Set(states.flatMap { (state) in
      alphabet.flatMap{ (sym) in
        transition(state, sym)}
    })
}

public func nextAccessibleStates<State, Sym>
  (of states: Set<State>,
   with transition: (State, Sym) -> State,
   and alphabet: Set<Sym>) -> Set<State> {
  return
    Set(states.flatMap { (state) in
      alphabet.map{ (sym) in
        transition(state, sym)}
    })
}
