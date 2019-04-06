//
//  StringExtension.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/3.
//  Copyright © 2018 Keith. All rights reserved.
//

extension String {
  public var chars: [Character] {
    return self.map{$0}
  }
}
