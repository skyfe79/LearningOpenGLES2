//
//  Paser+Monad.swift
//  ParsecMockTests
//
//  Created by Keith on 2018/7/5.
//  Copyright © 2018 Keith. All rights reserved.
//

import XCTest

class Paser_Monad: XCTestCase {
  
  /**
   m a -> (a -> m b) -> m b
   p          q           (p>>=q)
   Empty      Empty       Empty
   Empty      Consumed    Consumed
   Consumed   Empty       Consumed
   Consumed   Consumed    Consumed
   */
  
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  
  
}
