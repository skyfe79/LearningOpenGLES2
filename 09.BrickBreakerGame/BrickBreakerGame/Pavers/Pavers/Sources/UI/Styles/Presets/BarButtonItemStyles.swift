import PaversFRP
import UIKit

public let baseBarButtonItemStyle =
  UIBarButtonItem.lens.tintColor .~ .ksr_navy_700

public let plainBarButtonItemStyle = baseBarButtonItemStyle
  >>> UIBarButtonItem.lens.style .~ .plain
  >>> UIBarButtonItem.lens.titleTextAttributes(forState: .normal) .~ [
    NSAttributedStringKey.font.rawValue: UIFont.ksr_subhead(size: 15)
]

public let iconBarButtonItemStyle = baseBarButtonItemStyle
  >>> UIBarButtonItem.lens.title .~ nil
