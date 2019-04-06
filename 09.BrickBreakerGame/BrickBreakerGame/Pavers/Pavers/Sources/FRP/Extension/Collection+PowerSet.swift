//
//  Collection+PowerSet.swift
//  PaversFRP
//
//  Created by Keith on 2018/7/12.
//  Copyright © 2018 Keith. All rights reserved.
//

extension Collection {
  public var powerSet: [[Element]] {
    guard let fisrt = self.first else {return [[]]}
    return self.dropFirst().powerSet.flatMap{[$0, [fisrt] + $0]}
  }
}
