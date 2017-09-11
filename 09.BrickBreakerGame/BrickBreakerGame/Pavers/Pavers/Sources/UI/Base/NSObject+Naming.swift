//
//  NSObject+Name.swift
//  Pavers
//
//  Created by Pi on 28/08/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import Foundation

extension NSObject {

  private static let instanceNameKey = "instanceName" as StaticString

  public class var superclassName: String? {return self.superclass()?.description()}

  public class var className: String {return self.description()}

  public var superclassName: String? {return type(of: self).superclassName }

  public var className: String { return type(of: self).className }

  public var instanceName: String {
    get {
      let key = AssociationKey<String>(NSObject.instanceNameKey, default: self.className)
      return self.associations.value(forKey: key)
    }
    set {
      self.associations.setValue(newValue, forKey: AssociationKey<String>(NSObject.instanceNameKey))
    }
  }

  public var memoryAddress: UInt {
    return unsafeBitCast(self, to: UInt.self)
  }

  public var memoryAddressStr: String {
    return String(format: "%p", self.memoryAddress)
  }

  public var identification: String {
    return "\(self.instanceName):\(self.memoryAddressStr)"
  }
}
