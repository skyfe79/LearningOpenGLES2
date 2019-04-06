//
//  CGAffineTranslation+Composible.swift
//  Pavers
//
//  Created by Pi on 02/09/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import UIKit
import PaversFRP


public func affineTransformTranslatedBy(x: CGFloat, y: CGFloat) -> (CGAffineTransform) -> CGAffineTransform {
  return {
    $0.translatedBy(x: x, y: y)
  }
}

public func affineTransformRotated(by angle: CGFloat) -> (CGAffineTransform) -> CGAffineTransform {
  return {
    $0.rotated(by: angle)
  }
}

public func affineTransformScaledBy(x: CGFloat, y: CGFloat) -> (CGAffineTransform) -> CGAffineTransform {
  return {
    $0.scaledBy(x: x, y: y)
  }
}

public func affineTransformInversion() -> (CGAffineTransform) -> CGAffineTransform {
  return {
    $0.inverted()
  }
}

extension CGAffineTransform {
  public var xScale: CGFloat {
    return sqrt(self.a * self.a + self.c * self.c)
  }
  public var yScale: CGFloat {
    return sqrt(self.b * self.b + self.d * self.d)
  }

  public var rotation: CGFloat {
    return atan2(self.b, self.a)
  }
}

