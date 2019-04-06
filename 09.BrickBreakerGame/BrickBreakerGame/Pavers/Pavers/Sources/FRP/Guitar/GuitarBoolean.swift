//
//  GuitarBoolean.swift
//  GuitarExample
//
//  Created by Sabintsev, Arthur on 3/9/17.
//  Copyright © 2017 Arthur Ariel Sabintsev. All rights reserved.
//

import Foundation

// MARK: - Boolean Operations

public extension String {
  
  func isCJK() -> Bool {
    return containsCharactersFound(in: .CJK)
  }
  
  /// A Boolean value indicating if all the characters are letters.
  ///
  /// - Returns: `true`, if all characters are letters. Otherwise, `false`.
  func isAlpha() -> Bool {
    return containsCharactersFound(in: .letters)
  }
  
  /// A Boolean value indicating if all the characters are alphanumeric.
  ///
  /// - Returns: `true`, if all characters are alphanumeric. Otherwise, `false`.
  func isAlphanumeric() -> Bool {
    return containsCharactersFound(in: .alphanumerics)
  }
  
  /// A Boolean value indicating if the first characters in all of the words in the string are uppercased.
  ///
  /// - Returns: `true`, if the string is capitalized. Otherwise, `false`.
  func isCapitalized() -> Bool {
    return self == capitalized()
  }
  
  /// A Boolean value indicating if the first characters in all of the words in the string are lowercased.
  ///
  /// - Returns: `true`, if first character is lowercased. Otherwise, `false`.
  func isDecapitalized() -> Bool {
    return self == decapitalized()
  }
  
  /// A Boolean value indicating if all the characters are lowercased.
  ///
  /// - Returns: `true`, if the string is not capitalized. Otherwise, `false`.
  func isLowercased() -> Bool {
    return self == lowercased()
  }
  
  /// A Boolean value indicating if all the characters are numbers.
  ///
  /// - Returns: `true`, if all characters are numbers. Otherwise, `false`.
  func isNumeric() -> Bool {
    return containsCharactersFound(in: .decimalDigits)
  }
  
  /// A Boolean value indicating if all the characters are uppercased.
  ///
  /// - Returns: `true`, if all characters are uppercased. Otherwise, `false`.
  func isUppercased() -> Bool {
    return self == uppercased()
  }
  
}

// MARK: - Helpers

public extension String {
  
  /// A Boolean value indicating if all the characters in the string belong to a specific `CharacterSet`.
  ///
  /// - Parameter characterSet: The `CharacterSet` used to test the string.
  /// - Returns: True, if all the characters in the string belong to the `CharacterSet`. Otherwise, false.
  public func containsCharactersFound(in characterSet: CharacterSet) -> Bool {
    for scalar in unicodeScalars {
      guard characterSet.contains(scalar) else {
        return false
      }
    }
    return true
  }
}

extension CharacterSet {
  internal static let CJK: CharacterSet = {
    let rangeA = CharacterSet(charactersIn: UnicodeScalar(0x4E00 as UInt32)!...UnicodeScalar(0x9FFF as UInt32)!)
    let rangeB = CharacterSet(charactersIn: UnicodeScalar(0x3400 as UInt32)!...UnicodeScalar(0x4DBF as UInt32)!)
    let rangeC = CharacterSet(charactersIn: UnicodeScalar(0x20000 as UInt32)!...UnicodeScalar(0x2A6DF as UInt32)!)
    let rangeD = CharacterSet(charactersIn: UnicodeScalar(0x2A700 as UInt32)!...UnicodeScalar(0x2B73F as UInt32)!)
    let rangeE = CharacterSet(charactersIn: UnicodeScalar(0x2B740 as UInt32)!...UnicodeScalar(0x2B81F as UInt32)!)
    let rangeF = CharacterSet(charactersIn: UnicodeScalar(0xF900 as UInt32)!...UnicodeScalar(0xFAFF as UInt32)!)
    let rangeG = CharacterSet(charactersIn: UnicodeScalar(0x2F800 as UInt32)!...UnicodeScalar(0x2FA1F as UInt32)!)
    return rangeA <> rangeB <> rangeC <> rangeD <> rangeE <> rangeF <> rangeG
  }()
}
