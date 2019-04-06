//
//  UIButtonStyles.swift
//  QWSDKUI
//
//  Created by Keith on 21/10/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import PaversUI
import PaversFRP

internal func qwColorTitleBorderButtonStyle(titleColor: UIColor,
                                          borderColor: UIColor,
                                          borderWidth: CGFloat = 1,
                                          radius: CGFloat) -> (UIButton) -> UIButton {
  return baseButtonStyle
    >>> UIButton.lens.titleColor(forState: .normal) .~ titleColor
    >>> UIButton.lens.backgroundColor(forState: .normal) .~ .clear
    >>> UIButton.lens.titleColor(forState: .highlighted) .~ titleColor
    >>> UIButton.lens.backgroundColor(forState: .highlighted) .~ .clear
    >>> UIButton.lens.titleColor(forState: .disabled) .~ titleColor.withAlphaComponent(0.5)
    >>> UIButton.lens.layer.borderColor .~ borderColor.cgColor
    >>> UIButton.lens.layer.borderWidth .~ borderWidth
    >>> roundedStyle(cornerRadius: radius)
}

internal let qwOrangeRedBorderButtonStyle = qwColorTitleBorderButtonStyle(titleColor: .qw_orange_red_100,
                                                                        borderColor: .qw_orange_red_100,
                                                                        borderWidth: 1,
                                                                        radius: 10)

internal let qwGrayBorderButtonStyle = qwColorTitleBorderButtonStyle(titleColor: .qw_gray_100,
                                                                   borderColor: .qw_gray_100,
                                                                   borderWidth: 1,
                                                                   radius: 10)

fileprivate let _orangeRedBackgroundWhiteTitleButtonStyle = baseButtonStyle
  >>> UIButton.lens.titleColor(forState: .normal) .~ UIColor.white
  >>> UIButton.lens.backgroundColor(forState: .normal) .~ UIColor.qw_orange_red_100
  >>> UIButton.lens.titleColor(forState: .highlighted) .~ UIColor.init(white: 1.0, alpha: 0.5)
  >>> UIButton.lens.backgroundColor(forState: .highlighted) .~ .qw_orange_red_100
  >>> UIButton.lens.titleColor(forState: .disabled) .~ UIColor.white
  >>> UIButton.lens.backgroundColor(forState: .disabled) .~ UIColor.qw_orange_red_100.withAlphaComponent(0.5)

internal let orangeRedBackgroundWhiteTitleButtonStyle = _orangeRedBackgroundWhiteTitleButtonStyle
  >>> UIButton.lens.layer.borderColor .~ UIColor.qw_orange_red_100.cgColor
  >>> UIButton.lens.layer.borderWidth .~ 1.0
  >>> roundedStyle(cornerRadius: 4)

















