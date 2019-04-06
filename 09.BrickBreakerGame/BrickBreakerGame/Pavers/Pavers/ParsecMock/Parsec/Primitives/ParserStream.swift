//
//  ParserStream.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/4.
//  Copyright © 2018 Keith. All rights reserved.
//

/// Stream of elements
/// data Stream a = cons a (Stream a) | Nil
public protocol ParserStream {
  associatedtype Element
  func first() -> Element?
  func tail() -> Self
}

public func uncons<S>(_ s: S) -> (S.Element, S)?
  where S: ParserStream {
    guard let x = s.first() else {return nil}
    return (x, s.tail())
}

extension String: ParserStream {
  public func first() -> Character? {
    return self.first
  }
  
  public func tail() -> String {
    return String(self.dropFirst())
  }
}
