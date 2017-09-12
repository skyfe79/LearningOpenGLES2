//
//  NSLayoutConstraint+Composible.swift
//  Pavers
//
//  Created by Pi on 30/08/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import UIKit
import PaversFRP

public struct VisualConstraintParameter {
  public let metrics: [String: CGFloat]?
  public let views: [String: UIView]

  public init(metrics: [String: CGFloat]? = nil, views: [String: UIView]) {
    self.metrics = metrics
    self.views = views
  }
}

public func constraintGeneratorIdentity(_ parameter: VisualConstraintParameter) -> [NSLayoutConstraint] {
  return []
}

public struct VisualConstraintCollector {
  public let parameter: VisualConstraintParameter
  public let constraintGenerator: (VisualConstraintParameter) -> [NSLayoutConstraint]


  public init(parameter: VisualConstraintParameter,
              constraintGenerator: @escaping (VisualConstraintParameter) -> [NSLayoutConstraint] = constraintGeneratorIdentity) {
    self.parameter = parameter
    self.constraintGenerator = constraintGenerator
  }

}

extension VisualConstraintCollector {
  public var constraints: [NSLayoutConstraint] {
    return self.constraintGenerator(self.parameter)
  }
}


extension VisualConstraintCollector {
  public init(metrics: [String: CGFloat]? = nil, views: [String: UIView]) {
    let vcp = VisualConstraintParameter(metrics: metrics, views: views)
    self = VisualConstraintCollector(parameter: vcp)
  }
}

extension VisualConstraintCollector {
  public func accumulate (_ f: @escaping (VisualConstraintParameter) -> [NSLayoutConstraint])
    -> VisualConstraintCollector {
      return VisualConstraintCollector(parameter: self.parameter,
                                       constraintGenerator: self.constraintGenerator >>> f)
  }
  public func apply() {
    let views = Array(self.parameter.views.values)
    NSLayoutConstraint.preconstraint(views: views)
    NSLayoutConstraint.activate(self.constraints)
  }
}

public func visualConstraintGenerator(_ visualFormat: String,
                                      _ options: NSLayoutFormatOptions = [])
  -> (VisualConstraintParameter) -> [NSLayoutConstraint] {
    return {
      NSLayoutConstraint.constraints(withVisualFormat: visualFormat,
                                     options: options,
                                     metrics: $0.metrics,
                                     views: $0.views)
    }
}

public func |> ( vcc: VisualConstraintCollector,
                 f: @escaping (VisualConstraintParameter) -> [NSLayoutConstraint])
  -> VisualConstraintCollector {
    return vcc.accumulate(f)
}

//public func >>> (f: @escaping (VisualConstraintParameter) -> [NSLayoutConstraint],
//                 g: @escaping (VisualConstraintParameter) -> [NSLayoutConstraint] )
//  -> (VisualConstraintParameter) -> [NSLayoutConstraint] {
//    return { f($0) + g($0) }
//}


public func >>> <T, G: Semigroup> (f: @escaping (T) -> G, g: @escaping (T) -> G) -> (T) -> G {
  return { f($0) >>> g($0) }
}


