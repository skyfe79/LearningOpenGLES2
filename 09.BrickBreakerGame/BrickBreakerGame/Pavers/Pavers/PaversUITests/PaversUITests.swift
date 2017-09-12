//
//  PaversUITests.swift
//  PaversUITests
//
//  Created by Pi on 21/08/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import XCTest
@testable import PaversUI

class PaversUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      let v = UIView()
      v.nametag = "v"
      let c = NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: v, attribute: .top, multiplier: 3, constant: 2.23)

      XCTAssert(c.description == "<NSLayoutConstraint:\(c.memoryAddressStr) v:\(v.memoryAddressStr).bottom == v:\(v.memoryAddressStr).top * 3.0 + 2.23 (Inactive)>")

      //print(v)
//      print(c)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
