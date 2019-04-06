//
//  Pair.swift
//  PaversFRP
//
//  Created by Keith on 2018/7/11.
//  Copyright © 2018 Keith. All rights reserved.
//

public struct Pair<A, B> {
  public let first: A
  public let second: B
}

extension Pair {
  public init(_ a: A, _ b: B) {
    self.first = a
    self.second = b
  }
}

extension Pair {
  public func map<C, D>(f: (A) -> C, g: (B) -> D) -> Pair<C, D> {
    return fmap(fa: self, f: f, g: g)
  }
  
  public func mapFirst<C> (f: (A) -> C) -> Pair<C, B> {
    return self.map(f: f, g: id)
  }
  
  public func mapSecond<D> (g: (B) -> D) -> Pair<A, D> {
    return self.map(f: id, g: g)
  }
}

extension Pair: Equatable where A: Equatable, B: Equatable {}
extension Pair: Hashable where A: Hashable, B: Hashable {}

public func fmap<A, B, C, D>(fa: Pair<A, B>, f: (A) -> C, g: (B) -> D) -> Pair<C, D> {
  return Pair(f(fa.first), g(fa.second))
}

extension Pair {
  public func tuple() -> (A, B) {
    return (self.first, self.second)
  }
}

public func unpack<A, B, C>(_ a: Pair<Pair<A, B>, C>) -> (A, B, C) {
  return (a.first.first, a.first.second, a.second)
}

public func unpack<A, B, C>(_ a: Pair<A, Pair<B, C>>) -> (A, B, C) {
  return (a.first, a.second.first, a.second.second)
}
