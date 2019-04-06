//
//  Set+CartesianProduct.swift
//  PaversFRP
//
//  Created by Keith on 2018/7/17.
//  Copyright © 2018 Keith. All rights reserved.
//

public func cartesian<A, B>(_ a: Set<A>, _ b: Set<B>) -> Set<Pair<A, B>>
  where A: Hashable, B: Hashable {
    return Set( a.flatMap{ a_ in b.map{b_ in Pair(a_, b_)}})
}
