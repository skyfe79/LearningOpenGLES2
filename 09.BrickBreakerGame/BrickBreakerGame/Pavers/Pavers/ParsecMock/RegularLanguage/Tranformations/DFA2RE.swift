//
//  DFA2RE.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/17.
//  Copyright © 2018 Keith. All rights reserved.
//
import PaversFRP

public func regularExpression<State, Symbol>(of dfa: DFA<State, Symbol>)
  -> RegularExpression<Symbol> {
    let renamedDFA: DFA<Int, Symbol> = renamedStates(of: dfa, start: 1)
    return regularExpression(of: renamedDFA)
}


public func regularExpression<Symbol>(of dfa: DFA<Int, Symbol>)
  -> RegularExpression<Symbol> {
    let transitionMap: [Int : [Symbol : Int]] = dfa.transitionMap()
    let states = dfa.accessibleStates
    let finals = dfa.finals
    let f: (Int, Int, Int) -> RegularExpression<Symbol> = regularExpressionMaster(with: transitionMap)
    return finals.reduce(RegularExpression<Symbol>.empty) { (acc, finalState) in
      acc + f(1, finalState, states.count)
    }
}

public typealias TransitionMap<Symbol: Hashable> = [Int : [Symbol : Int]]


public func regularExpressionMaster<Symbol>(with transitionMap: TransitionMap<Symbol>)
  -> (Int, Int, Int) -> RegularExpression<Symbol> {
    
    var memo: [Pair<Pair<Int, Int>, Int>: RegularExpression<Symbol>] = [:]
    
    func re(_ i: Int, _ j: Int, _ k: Int) -> RegularExpression<Symbol> {
      
      if let result = memo[Pair(Pair(i, j), k)] { return result }
      
      let ret: RegularExpression<Symbol>
      
      /// basic part
      if k == 0 {
        if i != j {
          let r = Array(transitionMap[i]!.filter{$0.value == j}.keys)
          if r.isEmpty {
            ret = RegularExpression.empty
          } else if r.count == 1 {
            ret = RegularExpression.primitives(r[0])
          } else {
            ret = r.reduce(RegularExpression.empty) { (acc, s) -> RegularExpression<Symbol> in
              acc + RegularExpression.primitives(s)
            }
          }
        } else {
          let r = Array(transitionMap[i]!.filter{$0.value == i}.keys)
          if r.isEmpty {
            ret =  RegularExpression.epsilon
          } else if r.count == 1 {
            ret =  RegularExpression.primitives(r[0]) + RegularExpression.epsilon
          } else {
            ret =  r.reduce(RegularExpression.epsilon) { (acc, s) -> RegularExpression<Symbol> in
              acc + RegularExpression.primitives(s)
            }
          }
        }
      }
        /// Inductive part
      else {
        let first = re(i, j, k - 1)
        let second = re(i, k, k - 1)
        let three = re(k, k, k - 1)
        let four = re(k, j, k - 1)
        ret =  first + (second * (three.*) * four)
      }
      
      memo[Pair(Pair(i, j), k)] = ret
      return ret
    }
    
    return re
}

