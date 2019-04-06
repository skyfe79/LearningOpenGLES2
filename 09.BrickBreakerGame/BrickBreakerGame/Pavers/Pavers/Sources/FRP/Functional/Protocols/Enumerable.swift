//
//  Enumerable.swift
//  PaversFRP
//
//  Created by Keith on 2018/7/10.
//  Copyright © 2018 Keith. All rights reserved.
//

//class Enum a where
//succ :: a -> a
//pred :: a -> a
//toEnum :: Int -> a
//fromEnum :: a -> Int
//enumFrom :: a -> [a]
//enumFromThen :: a -> a -> [a]
//enumFromTo :: a -> a -> [a]
//enumFromThenTo :: a -> a -> a -> [a]
//{-# MINIMAL toEnum, fromEnum #-}
public protocol Enumerable {
  static func succ(_ a: Self) -> Self
  static func pred(_ a: Self) -> Self
  
  static func toEnum(_ n: Int) -> Self
  static func fromEnum(_ a: Self) -> Int

  static func enumFrom(_ a: Self, to b: Self) -> [Self]
  static func enumFrom(_ a: Self, then b: Self, to c: Self) -> [Self]
}

extension Enumerable {
  static func succ(_ a: Self) -> Self {
    return toEnum(fromEnum(a) + 1)
  }
  
  static func pred(_ a: Self) -> Self {
    return toEnum(fromEnum(a) - 1)
  }
  
  static func enumFrom(_ a: Self, to b: Self) -> [Self] {
    let start = fromEnum(a)
    let end = fromEnum(b)
    guard end >= start else {return []}
    return (start ... end).map(toEnum)
  }
  
  static func enumFrom(_ a: Self, then b: Self, to c: Self) -> [Self] {
    let start = fromEnum(a)
    let step = fromEnum(b) - start
    let end = fromEnum(c)
    guard end >= start else {return []}
    var ret: [Self] = []
    ret.reserveCapacity((end - start) / step + 1)
    var counter = start
    while counter < end {
      ret.append(toEnum(counter))
      counter += step
    }
    return ret
  }
}
