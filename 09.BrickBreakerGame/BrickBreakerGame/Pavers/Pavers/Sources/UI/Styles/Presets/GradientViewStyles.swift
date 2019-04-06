//
//  GradientViewStyles.swift
//  Pavers
//
//  Created by Pi on 23/08/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import PaversFRP


public func gradientViewStyleRandomColor<V: UIGradientViewProtocol>(numberOfColors: Int,
                                         start: CGPoint = .init(0,0),
                                         end: CGPoint = .init(1,1))
  -> (V) -> (V) {

  let colors = (0 ..< numberOfColors).map{_ in UIColor.random.cgColor}

  let rate: Double = pow(0.5, Double(numberOfColors - 1))
  let locations = (0 ..< numberOfColors).map{i in NSNumber(value: (Double(i) * rate) )}

  return V.lens.gradientLayer.colors .~ colors
        >>> V.lens.gradientLayer.locations .~ locations
        >>> V.lens.gradientLayer.startPoint .~ start
        >>> V.lens.gradientLayer.endPoint .~ end
}
