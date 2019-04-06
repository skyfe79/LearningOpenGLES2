//
//  CharacterExtension.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/3.
//  Copyright © 2018 Keith. All rights reserved.
//

extension Character {
  public var fromEnum: Int {
    return Int(self.unicodeScalars.first!.value)
  }
  
  public static func toEnum(_ n: Int) -> Character {
    return Character.init(UnicodeScalar.init(n)!)
  }
}


extension Character {
  public var unicodeCodepoint: UInt32? {
    guard self.unicodeScalars.count == 1 else {return nil}
    return self.unicodeScalars[self.unicodeScalars.startIndex].value
  }
  public var isAscii: Bool {
    guard let codepoint = self.unicodeCodepoint else {return false}
    return codepoint < 128
  }
}
