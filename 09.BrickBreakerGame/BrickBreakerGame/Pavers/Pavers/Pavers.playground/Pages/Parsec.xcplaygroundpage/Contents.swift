import PaversFRP
import PaversParsec


let digit = character { CharacterSet.decimalDigits.contains($0)}
let char = character {CharacterSet.lowercaseLetters.contains($0)}
//let one = character {$0 == "1"}
//one.run("123")
//
//
//digit.run("456")
//
//digit.many.run("456")
//
//let integer = digit.many.map {Int(String($0))}
//
//integer.run("123")
//
//integer.run("123abc")
//
//integer.run("abc")
//
//let integerPlus = digit.zeroOrMany.map{Int(String($0))}
//
//integerPlus.run("abc")

//let digit2 = digit.times(2)
//let char2 = char.times(2)
//let d2c2 = digit2.followed(by: char2)
//
//digit2.run("12")
//digit2.run("ab")
//digit2.run("123")
//digit2.run("1")
//
//char2.run("1")
//char2.run("a")
//char2.run("ab")
//char2.run("abc")
//
//d2c2.run("12ab")
//d2c2.run("123abc")
//d2c2.run("12c")

let integer = digit.many.map {Int(String($0))!}
let multiplicationSign = character{$0 == "*"}
let multiplicatin = integer.followed(by: multiplicationSign).followed(by: integer)

let x = multiplicatin.run("1*2")

func multiply(_ x: Int, _ op: Character, _ y: Int) -> Int {
  return x * y
}

let curriedMultiply = curry(multiply)

let p1 = integer.map(curriedMultiply)
let p2 = p1.followed(by: multiplicationSign)
let p3 = p2.map{f, x in f(x)}
let p4 = p3.followed(by: integer)
let p5 = p4.map{f, x in f(x)}

p5.run("1*2")
