import PaversFRP

#if os(macOS)
import AppKit
public typealias ViewClass = NSView
#else
import UIKit
public typealias ViewClass = UIView
#endif

// Mark: - Convenient Initializers
extension NSLayoutConstraint {
  public convenience init(_ item: ViewClass,
                          _ attribute: NSLayoutAttribute,
                          relatedBy r: NSLayoutRelation = .equal,
                          toItem secondItem: ViewClass? = nil,
                          attribute secondAttribute: NSLayoutAttribute = .notAnAttribute,
                          multiplier m: CGFloat = 1,
                          constant c: CGFloat = 0) {
    self.init(item: item,
              attribute: attribute,
              relatedBy: r,
              toItem: secondItem,
              attribute: secondAttribute,
              multiplier: m,
              constant: c)
  }
}


// MARK: - falsify translate autoresizing into constraints
extension NSLayoutConstraint {
  public static func preconstraint(view: ViewClass) {
    view.translatesAutoresizingMaskIntoConstraints = false
  }

  public static func preconstraint(views: [ViewClass]) {
    views.forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }

}

//extension NSLayoutConstraint {
//  public var fisrtView: ViewClass {
//    return self.firstItem as! ViewClass
//  }
//  public var secondView: ViewClass? {
//    return self.secondItem.flatMap { $0 as? ViewClass }
//  }
//
//  public var isUnary: Bool {
//    return self.secondItem == nil
//  }
//}

extension NSLayoutConstraint {
  public func remove() {
    NSLayoutConstraint.deactivate([self])
  }
}


extension NSLayoutConstraint {
  public func refers(to view: UIView) -> Bool {
    if self.firstItem === view {
      return true
    } else if self.secondItem === view {
      return true
    } else {
      return false
    }
  }
}















