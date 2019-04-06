import PaversFRP
import PaversParsec

let digit = character(CharacterSet.decimalDigits.contains)
let decimals = digit.many
let decimalPoint = character{$0 == "."}

let number = (decimals >>> (decimalPoint >>> decimals).optional).map { (args) -> Double in
  let (first, second) = args
  var values: [Character] = first
  if let s = second {
    values += [s.0] + s.1
  }
  let str = String(values)
  return Double(str)!
}

let muls = character{$0 == "*"}
let divs = character{$0 == "/"}
let adds = character{$0 == "+"}
let mins = character{$0 == "-"}

//    Expression = ['-'] Term { ( '+' | '-' ) Term }.
//    Term = number | { ( '*' | '/' ) number }.

//    Term1 = Factor | { ( powerroot | power ) Factor | production | percentage }.
//    Factor = number | preanser | '(' Expression ')' | Function | variable .
//    Function = functionIdentifier [ '(' ParameterList ')' ].
//    ParameterList = Expression { ',' | Expression } | Null.

//let term = number
//  >>> ((muls <|> divs) >>> number).zeroOrMany
//
//print(term.run("2*3/2"))
//
//let expression = mins.optional
//  >>> term
//  >>> ((adds <|> mins) >>> term).zeroOrMany
////
//print(expression.run("0-2.4*2.1-2/3.2+2"))

//let x = (character{$0 == "*"} *> number).zeroOrMany

let multiplication = curry({$0 * $1.reduce(1) { $0 * $1}})
  <^> number
  <*> (muls *> number).zeroOrMany

multiplication.run("1*2*3")

let division = curry({ $0 / $1.reduce(1) { $0 * $1} })
  <^> multiplication
  <*> (divs *> multiplication).zeroOrMany

division.run("10/5*2")

let addition = curry({ $0 + $1.reduce(0) { $0 + $1} })
  <^> division
  <*> (adds *> division).zeroOrMany

let minus = curry({ $0 - $1.reduce(0) { $0 + $1} })
  <^> addition
  <*> (mins *> addition).zeroOrMany

let expression = minus

expression.run("2.4*2.1/3+1-10.0/2.0+5")

