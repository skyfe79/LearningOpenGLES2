//
//  NSLayoutConstraint+Reporting.swift
//  Pavers
//
//  Created by Pi on 28/08/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import Foundation
import PaversFRP


extension NSLayoutConstraint {
//  public var equation: String {
//
//    let fstViewName = self.fisrtView.identification
//    let fstAttr = self.firstAttribute.stringValue
//    let fstStr = "\(fstViewName).\(fstAttr)"
//
//    let relStr = self.relation.stringValue
//
//    guard let sndView = self.secondView else { return "\(fstStr) \(relStr) \(self.constant)" }
//
//    let sndViewName = sndView.identification
//    let sndAttr = self.secondAttribute.stringValue
//    let sndStr = "\(sndViewName).\(sndAttr)"
//
//    let rhsVariablePart = self.multiplier == 1
//      ? sndStr
//      : "\(sndStr) * \(self.multiplier)"
//
//    let constantString = "\((self.constant.sign as NumericSign).symbol) \(self.constant.abs())"
//
//    let rhs = self.constant == 0 ? rhsVariablePart : "\(rhsVariablePart) \(constantString)"
//
//    return "\(fstStr) \(relStr) \(rhs)"
//  }

//  open override var description: String {
//    let active = self.isActive ? "Active" : "Inactive"
//    return "<\(self.identification) \(self.equation) (\(active))>"
//  }

}



extension NSLayoutAttribute {
  public var stringValue: String {
    switch self {
    case .left: return "left"
    case .right: return "right"
    case .top: return "top"
    case .bottom: return "bottom"
    case .leading: return "leading"
    case .trailing: return "trailing"
    case .width: return "width"
    case .height: return "height"
    case .centerX: return "centerX"
    case .centerY: return "centerY"
    case .lastBaseline: return "lastBaseline"
    case .firstBaseline: return "firstBaseline"
    case .leftMargin: return "leftMargin"
    case .rightMargin: return "rightMargin"
    case .topMargin: return "topMargin"
    case .bottomMargin: return "bottomMargin"
    case .leadingMargin: return "leadingMargin"
    case .trailingMargin: return "trailingMargin"
    case .centerXWithinMargins: return "centerXWithinMargins"
    case .centerYWithinMargins: return "centerYWithinMargins"
    case .notAnAttribute: return "notAnAttribute"
    }
  }
}

extension NSLayoutRelation {
  public var stringValue: String {
    switch self {
    case .lessThanOrEqual: return "<="
    case .equal: return "=="
    case .greaterThanOrEqual: return ">="
    }
  }
}
