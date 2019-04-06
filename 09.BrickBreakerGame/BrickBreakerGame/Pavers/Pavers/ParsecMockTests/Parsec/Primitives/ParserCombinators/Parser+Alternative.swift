//
//  Parser+Alternative.swift
//  ParsecMockTests
//
//  Created by Keith on 2018/7/5.
//  Copyright © 2018 Keith. All rights reserved.
//

import XCTest

class Parser_Alternative: XCTestCase {

  /**
   The alternative combinator is left-biased
   and will return the first succeeding parse tree.
   a. That means the parser p <|> q never tries parser q
   whenever parser p has consumed any input.
   b. If p success without consuming input the second alternative
   is favored if it consumes input.
   c. If p success without consuming input and the second alternative
   consumes nothing as well, the p empty okay result would be returned.
   d. If p failed without consuming input, the second alternative is favored.
   p          q         p<|>q
   Consumed   _         p.Consumed      (a)
   EmptyOkay  Consumed  q.Consumed      (b)
   EmptyOkay  Empty_    p.EmptyOkay     (c)
   EmptyError _         q.result        (d)
   */
  
  
  func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
