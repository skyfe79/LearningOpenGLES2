//
//  DispatchQueueExtension.swift
//  PaversFRP
//
//  Created by Keith on 06/11/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import Foundation

public extension DispatchQueue {
  private static var onceToken = [String]()
  
  /**
   Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
   only execute the code once even in the presence of multithreaded calls.
   
   - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
   - parameter block: Block to execute once
   */
  public static func once(token: String, block:()->Void) {
    objc_sync_enter(self); defer { objc_sync_exit(self) }
    guard onceToken.contains(token) == false else { return }
    onceToken.append(token)
    block()
  }
}
