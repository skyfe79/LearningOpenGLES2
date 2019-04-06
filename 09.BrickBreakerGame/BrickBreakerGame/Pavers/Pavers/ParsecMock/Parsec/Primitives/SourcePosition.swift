//
//  Position.swift
//  PaversParsec2
//
//  Created by Keith on 2018/6/27.
//  Copyright © 2018 Keith. All rights reserved.
//

import Foundation

public typealias SourceName = String
public typealias Line = Int
public typealias Column = Int

public struct SourcePos {
  let sourceName: SourceName
  let line: Line
  let column: Column
}

extension SourcePos: Equatable {}

extension SourcePos: Comparable {
  public static func < (lhs: SourcePos, rhs: SourcePos) -> Bool {
    if lhs.sourceName != rhs.sourceName {
      return lhs.sourceName < rhs.sourceName
    } else if lhs.line != rhs.line {
      return lhs.line < rhs.line
    } else {
      return lhs.column < rhs.column
    }
  }
}

extension SourcePos {
  /// Create a new 'SourcePos' with the given source name,
  /// and line number and column number set to 1, the upper left.
  init(sourceName: String) {
    self.sourceName = sourceName
    self.line = 1
    self.column = 1
  }
  
  /// Increments the line number of a source position.
  func inc(sourceLineBy n: Line) -> SourcePos {
    return SourcePos(sourceName: self.sourceName,
                     line: self.line + n,
                     column: self.column)
  }
  
  
  /// Increments the column number of a source position.
  func inc(sourceColumnBy n: Column) -> SourcePos {
    return SourcePos(sourceName: self.sourceName,
                     line: self.line,
                     column: self.column + n)
  }
  
  /// Set the name of the source.
  func set(sourceName: SourceName) -> SourcePos {
    return SourcePos(sourceName: sourceName,
                     line: self.line,
                     column: self.column)
  }
  
  /// Set the line number of a source position.
  func set(sourceLine: Line) -> SourcePos {
    return SourcePos(sourceName: self.sourceName,
                     line: sourceLine,
                     column: self.column)
  }
  
  /// Set the column number of a source position.
  func set(sourceColumn: Column) -> SourcePos {
    return SourcePos(sourceName: self.sourceName,
                     line: self.line,
                     column: sourceColumn)
  }
  
  /// The expression @updatePosString pos s@ updates the source position
  /// @pos@ by calling 'updatePosChar' on every character in @s@, ie.
  /// @foldl updatePosChar pos string@.
  func update(PosBy s: String) -> SourcePos {
    return s.reduce(self) { $0.update(PosBy: $1) }
  }
  
  /// Update a source position given a character. If the character is a
  /// newline (\'\\n\') or carriage return (\'\\r\') the line number is
  /// incremented by 1. If the character is a tab (\'\t\') the column
  /// number is incremented to the nearest 8'th column, ie. @column + 8 -
  /// ((column-1) \`mod\` 8)@. In all other cases, the column is
  /// incremented by 1.
  func update(PosBy c: Character) -> SourcePos {
    switch c {
    case "\n":
      return SourcePos(sourceName: self.sourceName,
                       line: self.line + 1,
                       column: 1)
    case "\t":
      return SourcePos(sourceName: self.sourceName,
                       line: self.line,
                       column: self.column + 8  - (self.column - 1) % 8)
    default:
      return SourcePos(sourceName: self.sourceName,
                       line: self.line,
                       column: self.column + 1)
    }
  }
  
  func incPos() -> SourcePos {
    return SourcePos(sourceName: self.sourceName,
                     line: self.line,
                     column: self.column + 1)
  }
}

extension SourcePos: CustomStringConvertible {
  public var description: String {
    return """
    {file: \(self.sourceName), line: \(self.line), column: \(self.column)}
    """
  }
}
