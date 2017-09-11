//
//  UIView+Facilitating.swift
//  Pavers
//
//  Created by Pi on 30/08/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import UIKit
import PaversFRP

extension UIView {
  public func constraints(named: String = NSLayoutConstraint.className, matching view: UIView? = nil)
    -> [NSLayoutConstraint] {
      guard let view = view else { return self.constraints.filter { $0.instanceName == named} }
      return self.constraints.filter {
        $0.instanceName == named
          && ($0.firstItem === view || $0.secondItem === view)}
  }
}

extension UIView {

  public var superviews: [UIView] {
    var views = [UIView]()

    var spv: UIView? = self.superview
    while let v = spv {
      views.append(v)
      spv = v.superview
    }

    return views
  }

  public var referencingConstraintsInSuperviews: [NSLayoutConstraint] {
    return self.superviews
      .flatMap{ $0.constraints }
      .filter{
        let t = type(of: $0)
        return t == NSLayoutConstraint.self && $0.refers(to: self)
    }
  }

  public var referencingConstraints: [NSLayoutConstraint] {
    return self.referencingConstraints
      + self.constraints.filter{
        let t = type(of: $0)
        return t == NSLayoutConstraint.self && $0.refers(to: self)
    }
  }
}
