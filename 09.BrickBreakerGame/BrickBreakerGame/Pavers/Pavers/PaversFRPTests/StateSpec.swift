//
//  StateSpec.swift
//  Runes
//
//  Created by Pi on 27/07/2017.
//  Copyright © 2017 thoughtbot. All rights reserved.
//

import XCTest
import PaversFRP

typealias Counter = Int
typealias LogState<A> = State<Counter, A>

func toString(a: Int, c: Counter) -> (String, Counter) {
  return ("\(a)", c + 1)
}

func getLength(s: String, c: Counter) -> (Int, Counter) {
  return (s.characters.count, c + 1)
}

class StateSpec: XCTestCase {
    func testExample() {

      let f = curry(toString)
      let g = curry(getLength)
      let h = f >>> g

      let h0 = h(100000)
      let h1 = h0(0)
      print("\(h1)")
    }
    
}










