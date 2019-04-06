//
//  Sequence.swift
//  PaversFRP
//
//  Created by Keith on 2018/6/27.
//  Copyright © 2018 Keith. All rights reserved.
//

extension Sequence {
  public func span(_ isIncluded: (Self.Element) throws -> Bool) rethrows -> ([Self.Element], [Self.Element]) {
    var result1 = ContiguousArray<Element>()
    var result2 = ContiguousArray<Element>()
    
    var iterator = self.makeIterator()
    
    while let element = iterator.next() {
      if try isIncluded(element) {
        result1.append(element)
      } else {
        result2.append(element)
      }
    }
    
    return (Array(result1), Array(result2))
  }
}
