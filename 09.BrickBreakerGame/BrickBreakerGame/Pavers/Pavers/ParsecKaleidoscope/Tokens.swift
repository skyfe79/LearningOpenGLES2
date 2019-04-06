//
//  Tokens.swift
//  ParsecKaleidoscope
//
//  Created by Keith on 2018/7/18.
//  Copyright © 2018 Keith. All rights reserved.
//

// MARK: Tokens
enum BinaryOperator: Character {
  case plus = "+"
  case minus = "-"
  case times = "*"
  case divide = "/"
  case mod = "%"
  case equals = "="
}

enum Token: Equatable {
  case leftParen, rightParen, def, extern, comma, semicolon, `if`, then, `else`
  case identifier(String)
  case number(Double)
  case `operator`(BinaryOperator)
  
  static func ==(lhs: Token, rhs: Token) -> Bool {
    switch (lhs, rhs) {
    case (.leftParen, .leftParen), (.rightParen, .rightParen),
         (.def, .def), (.extern, .extern), (.comma, .comma),
         (.semicolon, .semicolon), (.if, .if), (.then, .then),
         (.else, .else):
      return true
    case let (.identifier(id1), .identifier(id2)):
      return id1 == id2
    case let (.number(n1), .number(n2)):
      return n1 == n2
    case let (.operator(op1), .operator(op2)):
      return op1 == op2
    default:
      return false
    }
  }
}

extension Character {
  var value: Int32 {
    return Int32(String(self).unicodeScalars.first!.value)
  }
  var isSpace: Bool {
    return isspace(value) != 0
  }
  var isAlphanumeric: Bool {
    return isalnum(value) != 0 || self == "_"
  }
}

// MARK: Lexer
class Lexer {
  let input: String
  var index: String.Index
  
  init(input: String) {
    self.input = input
    self.index = input.startIndex
  }
  
  var currentChar: Character? {
    return index < input.endIndex ? input[index] : nil
  }
  
  func advanceIndex() {
    input.characters.formIndex(after: &index)
  }
  
  func readIdentifierOrNumber() -> String {
    var str = ""
    while let char = currentChar, char.isAlphanumeric || char == "." {
      str.characters.append(char)
      advanceIndex()
    }
    return str
  }
  
  func advanceToNextToken() -> Token? {
    // Skip all spaces until a non-space token
    while let char = currentChar, char.isSpace {
      advanceIndex()
    }
    // If we hit the end of the input, then we're done
    guard let char = currentChar else {
      return nil
    }
    
    // Handle single-scalar tokens, like comma,
    // leftParen, rightParen, and the operators
    let singleTokMapping: [Character: Token] = [
      ",": .comma, "(": .leftParen, ")": .rightParen,
      ";": .semicolon, "+": .operator(.plus), "-": .operator(.minus),
      "*": .operator(.times), "/": .operator(.divide),
      "%": .operator(.mod), "=": .operator(.equals)
    ]
    
    if let tok = singleTokMapping[char] {
      advanceIndex()
      return tok
    }
    
    // This is where we parse identifiers or numbers
    // We're going to use Swift's built-in double parsing
    // logic here.
    if char.isAlphanumeric {
      var str = readIdentifierOrNumber()
      if let dblVal = Double(str) {
        return .number(dblVal)
      }
      
      // Look for known tokens, otherwise fall back to
      // the identifier token
      switch str {
      case "def": return .def
      case "extern": return .extern
      case "if": return .if
      case "then": return .then
      case "else": return .else
      default: return .identifier(str)
      }
    }
    return nil
  }
  
  func lex() -> [Token] {
    var toks = [Token]()
    while let tok = advanceToNextToken() {
      toks.append(tok)
    }
    return toks
  }
}

// MARK: AST
indirect enum Expr {
  case number(Double)
  case variable(String)
  case binary(Expr, BinaryOperator, Expr)
  case call(String, [Expr])
  case ifelse(Expr, Expr, Expr)
}

struct Prototype {
  let name: String
  let params: [String]
}

struct Definition {
  let prototype: Prototype
  let expr: Expr
}

class File {
  private(set) var externs = [Prototype]()
  private(set) var definitions = [Definition]()
  private(set) var expressions = [Expr]()
  private(set) var prototypeMap = [String: Prototype]()
  
  func prototype(name: String) -> Prototype? {
    return prototypeMap[name]
  }
  
  func addExpression(_ expression: Expr) {
    expressions.append(expression)
  }
  
  func addExtern(_ prototype: Prototype) {
    externs.append(prototype)
    prototypeMap[prototype.name] = prototype
  }
  
  func addDefinition(_ definition: Definition) {
    definitions.append(definition)
    prototypeMap[definition.prototype.name] = definition.prototype
  }
}

// MARK: Parser
enum ParseError: Error {
  case unexpectedToken(Token)
  case unexpectedEOF
}

class Parser {
  let tokens: [Token]
  var index = 0
  
  init(tokens: [Token]) {
    self.tokens = tokens
  }
  
  var currentToken: Token? {
    return index < tokens.count ? tokens[index] : nil
  }
  
  func consumeToken(n: Int = 1) {
    index += n
  }
  
  func parseFile() throws -> File {
    let file = File()
    while let tok = currentToken {
      switch tok {
      case .extern:
        file.addExtern(try parseExtern())
      case .def:
        file.addDefinition(try parseDefinition())
      default:
        let expr = try parseExpr()
        try consume(.semicolon)
        file.addExpression(expr)
      }
    }
    return file
  }
  
  func parseExpr() throws -> Expr {
    guard let token = currentToken else {
      throw ParseError.unexpectedEOF
    }
    var expr: Expr
    switch token {
    case .leftParen: // ( <expr> )
      consumeToken()
      expr = try parseExpr()
      try consume(.rightParen)
    case .number(let value):
      consumeToken()
      expr = .number(value)
    case .identifier(let value):
      consumeToken()
      if case .leftParen? = currentToken {
        let params = try parseCommaSeparated(parseExpr)
        expr = .call(value, params)
      } else {
        expr = .variable(value)
      }
    case .if: // if <expr> then <expr> else <expr>
      consumeToken()
      let cond = try parseExpr()
      try consume(.then)
      let thenVal = try parseExpr()
      try consume(.else)
      let elseVal = try parseExpr()
      expr = .ifelse(cond, thenVal, elseVal)
    default:
      throw ParseError.unexpectedToken(token)
    }
    
    if case .operator(let op)? = currentToken {
      consumeToken()
      let rhs = try parseExpr()
      expr = .binary(expr, op, rhs)
    }
    
    return expr
  }
  
  func consume(_ token: Token) throws {
    guard let tok = currentToken else {
      throw ParseError.unexpectedEOF
    }
    guard token == tok else {
      throw ParseError.unexpectedToken(token)
    }
    consumeToken()
  }
  
  func parseIdentifier() throws -> String {
    guard let token = currentToken else {
      throw ParseError.unexpectedEOF
    }
    guard case .identifier(let name) = token else {
      throw ParseError.unexpectedToken(token)
    }
    consumeToken()
    return name
  }
  
  func parsePrototype() throws -> Prototype {
    let name = try parseIdentifier()
    let params = try parseCommaSeparated(parseIdentifier)
    return Prototype(name: name, params: params)
  }
  
  func parseCommaSeparated<TermType>(_ parseFn: () throws -> TermType) throws -> [TermType] {
    try consume(.leftParen)
    var vals = [TermType]()
    while let tok = currentToken, tok != .rightParen {
      let val = try parseFn()
      if case .comma? = currentToken {
        try consume(.comma)
      }
      vals.append(val)
    }
    try consume(.rightParen)
    return vals
  }
  
  func parseExtern() throws -> Prototype {
    try consume(.extern)
    let proto = try parsePrototype()
    try consume(.semicolon)
    return proto
  }
  
  func parseDefinition() throws -> Definition {
    try consume(.def)
    let prototype = try parsePrototype()
    let expr = try parseExpr()
    let def = Definition(prototype: prototype, expr: expr)
    try consume(.semicolon)
    return def
  }
}
