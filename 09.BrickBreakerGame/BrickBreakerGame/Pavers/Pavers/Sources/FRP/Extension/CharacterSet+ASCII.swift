//
//  CharacterSet+ASCII.swift
//  PaversFRP
//
//  Created by Keith on 2018/7/10.
//  Copyright © 2018 Keith. All rights reserved.
//

extension CharacterSet {
  public init?(lower: UInt32, upper: UInt32) {
    guard upper >= lower,
      let lowerCodepoint = Unicode.Scalar.init(lower),
      let upperCodepoint = Unicode.Scalar.init(upper) else {return nil}
    self = CharacterSet(charactersIn: ClosedRange<Unicode.Scalar>(uncheckedBounds: (lowerCodepoint, upperCodepoint)))
  }
  
  public static var asciiBinaryDigits: CharacterSet {
    return CharacterSet(lower: 48, upper: 48+1)!
  }
  
  public static var asciiOctalDigits: CharacterSet {
    return CharacterSet(lower: 48, upper: 48+7)!
  }
  
  public static var asciiDecimalDigits: CharacterSet {
    return CharacterSet(lower: 48, upper: 48+9)!
  }
  
  public static var asciiLowercaseHexLetters: CharacterSet {
    return CharacterSet(lower: 97, upper: 97+5)!
  }
  public static var asciiUppercaseHexLetters: CharacterSet {
    return CharacterSet(lower: 65, upper: 65+5)!
  }
  
  public static var asciiHexDigits: CharacterSet {
    return .asciiDecimalDigits
      <> .asciiLowercaseHexLetters
      <> .asciiUppercaseHexLetters
  }
  
  public static var ascii: CharacterSet {
    return CharacterSet(lower: 0, upper: 127)!
  }
  
  public static var asciiLowercaseLetters: CharacterSet {
    return CharacterSet(lower: 97, upper: 97+25)!
  }
  
  public static var asciiUppercaseLetters: CharacterSet {
    return CharacterSet(lower: 65, upper: 65+25)!
  }
  
  public static var asciiLetters: CharacterSet {
    return .asciiLowercaseLetters <> .asciiUppercaseLetters
  }
  
  public static var asciiControls: CharacterSet {
    return CharacterSet(lower: 0, upper: 31)! <> CharacterSet(lower: 127, upper: 127)!
  }
  
  public static var asciiPrintables: CharacterSet {
    return CharacterSet(lower: 32, upper: 126)!
  }
  
  public static var asciiPunctuations: CharacterSet {
    return CharacterSet(lower: 32, upper: 47)!
      <> CharacterSet(lower: 58, upper: 64)!
      <> CharacterSet(lower: 91, upper: 96)!
      <> CharacterSet(lower: 123, upper: 126)!
  }
}
