//: [Previous](@previous)

import PaversFRP
import ParsecMock

let a: ParserS<Character> = satisfy(CharacterSet.alphanumerics.contains)

let manyA: ParserS<[Character]> = many(a)

/// parse with empty input, should return empty okay
let emptyInputMany = ParserStateS("")
print(manyA.unParser(emptyInputMany))

print()

/// parse with a valid string, should return consumed ok with cursor moved next
let validInputMany = ParserStateS("a###")
print(manyA.unParser(validInputMany))

print()

/// parser with invalid string, should return empty okay
let invalidInputMany = ParserStateS("###")
print(manyA.unParser(invalidInputMany))

print()

/// parse with a valid string, should return consumed ok with cursor moved next
let validInputMany_ = ParserStateS("aaaa###")
print(manyA.unParser(validInputMany_))

print()

let many1A: ParserS<[Character]> = many1(a)

/// parse with empty input, should return empty error
let emptyInputMany1 = ParserStateS("")
print(many1A.unParser(emptyInputMany1))

print()

/// parse with a valid string, should return consumed ok with cursor moved next
let validInputMany1 = ParserStateS("a###")
print(many1A.unParser(validInputMany1))

print()

/// parse with a valid string, should return consumed ok with cursor moved next
let validInputMany1_ = ParserStateS("aaaa###")
print(many1A.unParser(validInputMany1_))

print()

/// parser with invalid string, should return empty error
let invalidInputMany1 = ParserStateS("###")
print(many1A.unParser(invalidInputMany1))

//: [Next](@next)
