//: [Previous](@previous)

import Foundation

protocol P {}
struct S {}
class C {}
class D : P {}
class E : C, P {}
//let u: S & P // Compiler error: S is not of class type
//let v: C & P = D() // Compiler error: D is not a subtype of C
let w: C & P = E() // Compiles successfully

//: [Next](@next)
