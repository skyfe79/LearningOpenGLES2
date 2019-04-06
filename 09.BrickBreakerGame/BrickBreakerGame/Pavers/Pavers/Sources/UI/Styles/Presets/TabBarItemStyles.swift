import PaversFRP
import UIKit

public let tabBarDeselectedColor = UIColor.ksr_navy_500
public let tabBarSelectedColor = UIColor.ksr_navy_900
public let tabBarTintColor = UIColor.white
public let tabBarAvatarSize = CGSize(width: 25, height: 25)

private let paddingY: CGFloat = 6.0

private let baseTabBarItemStyle = UITabBarItem.lens.title .~ nil
  >>> UITabBarItem.lens.imageInsets .~ .init(top: paddingY, left: 0.0, bottom: -paddingY, right: 0.0)
  >>> UITabBarItem.lens.titlePositionAdjustment .~ UIOffset(horizontal: 0, vertical: 9_999_999)
