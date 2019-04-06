import PaversFRP
import UIKit

public let baseButtonStyle =
  roundedStyle(cornerRadius: 2)
    >>> UIButton.lens.titleLabel.font %~~ { _, button in
      button.traitCollection.verticalSizeClass == .compact
        ? .ksr_callout(size: 9)
        : .ksr_callout(size: 10)
    }
    >>> UIButton.lens.contentEdgeInsets %~~ { _, button in
      button.traitCollection.verticalSizeClass == .compact
        ? .init(topBottom: 5, leftRight: 6)
        : .init(topBottom: 6.5, leftRight: 8)
    }
    >>> UIButton.lens.adjustsImageWhenDisabled .~ false
    >>> UIButton.lens.adjustsImageWhenHighlighted .~ false

public let blackButtonStyle = baseButtonStyle
  >>> UIButton.lens.titleColor(forState: .normal) .~ .white
  >>> UIButton.lens.backgroundColor(forState: .normal) .~ .black
  >>> UIButton.lens.titleColor(forState: .highlighted) .~ .white
  >>> UIButton.lens.backgroundColor(forState: .highlighted) .~ .ksr_green_400
  >>> UIButton.lens.titleColor(forState: .disabled) .~ .init(white: 1.0, alpha: 0.75)
  >>> UIButton.lens.backgroundColor(forState: .disabled) .~ .ksr_grey_500

public let borderButtonStyle = baseButtonStyle
  >>> UIButton.lens.titleColor(forState: .normal) .~ .ksr_navy_600
  >>> UIButton.lens.backgroundColor(forState: .normal) .~ .clear
  >>> UIButton.lens.titleColor(forState: .highlighted) .~ .ksr_navy_900
  >>> UIButton.lens.backgroundColor(forState: .highlighted) .~ .ksr_grey_500
  >>> UIButton.lens.titleColor(forState: .disabled) .~ .ksr_grey_500
  >>> UIButton.lens.layer.borderColor .~ UIColor.ksr_navy_600.cgColor
  >>> UIButton.lens.layer.borderWidth .~ 1.0

public let greenBorderButtonStyle = baseButtonStyle
  >>> UIButton.lens.titleColor(forState: .normal) .~ .ksr_green_700
  >>> UIButton.lens.backgroundColor(forState: .normal) .~ .white
  >>> UIButton.lens.titleColor(forState: .highlighted) .~ .white
  >>> UIButton.lens.backgroundColor(forState: .highlighted) .~ .ksr_green_400
  >>> UIButton.lens.titleColor(forState: .disabled) .~ UIColor.ksr_green_700.withAlphaComponent(0.5)
  >>> UIButton.lens.layer.borderColor .~ UIColor.ksr_green_700.cgColor
  >>> UIButton.lens.layer.borderWidth .~ 1.0


public let neutralButtonStyle = baseButtonStyle
  >>> UIButton.lens.titleColor(forState: .normal) .~ .white
  >>> UIButton.lens.backgroundColor(forState: .normal) .~ .ksr_navy_500
  >>> UIButton.lens.titleColor(forState: .highlighted) .~ .init(white: 1.0, alpha: 0.5)
  >>> UIButton.lens.backgroundColor(forState: .highlighted) .~ .ksr_navy_600
  >>> UIButton.lens.titleColor(forState: .disabled) .~ .init(white: 1.0, alpha: 0.75)
  >>> UIButton.lens.backgroundColor(forState: .disabled) .~ .ksr_navy_400

fileprivate let _greenButtonStyle = baseButtonStyle
  >>> UIButton.lens.titleColor(forState: .normal) .~ .white
  >>> UIButton.lens.backgroundColor(forState: .normal) .~ .ksr_green_500
  >>> UIButton.lens.titleColor(forState: .highlighted) .~ .init(white: 1.0, alpha: 0.5)
  >>> UIButton.lens.backgroundColor(forState: .highlighted) .~ .ksr_green_700
  >>> UIButton.lens.titleColor(forState: .disabled) .~ .white
  >>> UIButton.lens.backgroundColor(forState: .disabled) .~ UIColor.ksr_green_400.withAlphaComponent(0.5)

public let greenButtonStyle = _greenButtonStyle
    >>> UIButton.lens.layer.borderColor .~ UIColor.ksr_green_700.cgColor
    >>> UIButton.lens.layer.borderWidth .~ 1.0




fileprivate let _lightNavyButtonStyle = baseButtonStyle
  >>> UIButton.lens.titleColor(forState: .normal) .~ .ksr_text_navy_700
  >>> UIButton.lens.backgroundColor(forState: .normal) .~ .ksr_navy_200
  >>> UIButton.lens.titleColor(forState: .highlighted) .~ .ksr_text_navy_900
  >>> UIButton.lens.backgroundColor(forState: .highlighted) .~ .ksr_navy_400
  >>> UIButton.lens.titleColor(forState: .disabled) .~ .init(white: 0.0, alpha: 0.4)

public let lightNavyButtonStyle = _lightNavyButtonStyle
    >>> UIButton.lens.backgroundColor(forState: .disabled) .~ .ksr_navy_600
    >>> UIButton.lens.layer.borderColor .~ UIColor.ksr_navy_300.cgColor
    >>> UIButton.lens.layer.borderWidth .~ 1.0


fileprivate let _navyButtonStyle =  baseButtonStyle
  >>> UIButton.lens.titleColor(forState: .normal) .~ .white
  >>> UIButton.lens.backgroundColor(forState: .normal) .~ .ksr_navy_700
  >>> UIButton.lens.titleColor(forState: .highlighted) .~ .init(white: 1.0, alpha: 0.5)
  >>> UIButton.lens.backgroundColor(forState: .highlighted) .~ .ksr_navy_600
  >>> UIButton.lens.titleColor(forState: .disabled) .~ .init(white: 0.0, alpha: 0.4)

public let navyButtonStyle = _navyButtonStyle
    >>> UIButton.lens.backgroundColor(forState: .disabled) .~ .ksr_navy_600
    >>> UIButton.lens.layer.borderColor .~ UIColor.ksr_navy_900.cgColor
    >>> UIButton.lens.layer.borderWidth .~ 1.0

public let textOnlyButtonStyle = baseButtonStyle
  >>> UIButton.lens.titleColor(forState: .normal) .~ .ksr_navy_900
  >>> UIButton.lens.backgroundColor(forState: .normal) .~ .clear
  >>> UIButton.lens.titleColor(forState: .highlighted) .~ .ksr_green_400
  >>> UIButton.lens.titleColor(forState: .disabled) .~ .ksr_navy_500

fileprivate let _whiteBorderButtonStyle = baseButtonStyle
  >>> UIButton.lens.titleColor(forState: .normal) .~ .white
  >>> UIButton.lens.backgroundColor(forState: .normal) .~ .clear
  >>> UIButton.lens.titleColor(forState: .highlighted) .~ .white
  >>> UIButton.lens.backgroundColor(forState: .highlighted) .~ UIColor.white.withAlphaComponent(0.5)
  >>> UIButton.lens.titleColor(forState: .disabled) .~ UIColor.white.withAlphaComponent(0.5)

public let whiteBorderButtonStyle = _whiteBorderButtonStyle
  >>> UIButton.lens.layer.borderColor .~ UIColor.white.cgColor
  >>> UIButton.lens.layer.borderWidth .~ 1.0
  >>> UIButton.lens.contentEdgeInsets .~ .init(topBottom: Styles.gridHalf(3), leftRight: Styles.gridHalf(6))
