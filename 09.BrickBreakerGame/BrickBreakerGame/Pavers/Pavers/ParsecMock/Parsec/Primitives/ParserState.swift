//
//  State.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/27.
//  Copyright © 2018 Keith. All rights reserved.
//


public struct ParserState<S, U> {
  public let stateInput: S
  public let statePos: SourcePos
  public let stateUser: U
}
extension ParserState where S == String, U == () {
  public init(_ input: String) {
    self.stateInput = input
    self.statePos = SourcePos(sourceName: #function)
    self.stateUser = ()
  }
}

public typealias ParserStateS = ParserState<String, ()>
public func makeParserState(_ input: String) -> ParserStateS {
  return ParserStateS(input)
}

extension ParserState: CustomStringConvertible {
  public var description: String {
    return """
    remaining input: \(self.stateInput)
    current cursor: {\(self.statePos)}
    user info: \(self.stateUser)
    """
  }
}

