//: [Previous](@previous)

import Foundation

public func curry<A, B>(_ function: @escaping (A) -> B) -> (A) -> B {
    return { (a: A) -> B in function(a) }
}

//public func curry<A, B, C>(_ function: @escaping (A, B) -> C) -> (A) -> (B) -> C {
//    return { (a: A) -> (B) -> C in { (b: B) -> C in function(a, b) } }
//}
//
//public func curry<A, B, C, D>(_ function: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
//    return { (a: A) -> (B) -> (C) -> D in { (b: B) -> (C) -> D in { (c: C) -> D in function(a, b, c) } } }
//}

struct A {
  let a: String
  let b: String
}

let x = A.init
let cx = curry(x)
//let a = cx("")("")
//: [Next](@next)
