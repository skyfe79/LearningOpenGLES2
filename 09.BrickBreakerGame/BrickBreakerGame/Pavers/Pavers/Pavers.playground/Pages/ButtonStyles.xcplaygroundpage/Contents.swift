//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import Foundation
@testable import PaversFRP
@testable import PaversUI

let (parent, child) = playgroundControllers(device: .phone4_7inch, orientation: .portrait)

let rootStackView = UIStackView(frame: child.view.bounds)
rootStackView.alignment = .leading
rootStackView.axis = .vertical
rootStackView.distribution = .fillEqually
rootStackView.isLayoutMarginsRelativeArrangement = true
rootStackView.layoutMargins = .init(all: 16)


child.view.addSubview(rootStackView)

func disabled <C: UIControlProtocol> () -> ((C) -> C) {
  return C.lens.isEnabled .~ false
}

let baseButtonsStyles: [(UIButton) -> UIButton] = [
  greenButtonStyle       >>> UIButton.lens.title(forState: .normal) .~ "Green button",
  navyButtonStyle        >>> UIButton.lens.title(forState: .normal) .~ "Navy button",
  lightNavyButtonStyle   >>> UIButton.lens.title(forState: .normal) .~ "Light navy button",
  neutralButtonStyle     >>> UIButton.lens.title(forState: .normal) .~ "Neutral button",
  borderButtonStyle      >>> UIButton.lens.title(forState: .normal) .~ "Border button",
  blackButtonStyle       >>> UIButton.lens.title(forState: .normal) .~ "Black button",
  textOnlyButtonStyle    >>> UIButton.lens.title(forState: .normal) .~ "Text only button",
  greenBorderButtonStyle >>> UIButton.lens.title(forState: .normal) .~ "Green border button",
]

let buttonsStyles: [[(UIButton) -> UIButton]] = baseButtonsStyles.map { [$0, $0 >>> disabled()] }

buttonsStyles.forEach { styles in
  let rowStackView = UIStackView()
  rootStackView.addArrangedSubview(rowStackView)

  rowStackView.alignment = .top
  rowStackView.axis = .horizontal
  rowStackView.distribution = .equalSpacing
  rowStackView.spacing = 24

  styles.forEach { style in
    let button = UIButton()
    rowStackView.addArrangedSubview(button)
    button |> style
  }
}

PlaygroundPage.current.liveView = parent

