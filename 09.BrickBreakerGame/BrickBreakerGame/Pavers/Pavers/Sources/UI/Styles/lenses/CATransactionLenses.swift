import PaversFRP
import UIKit

extension CATransaction {
  public enum classLens {
    public static let animationDuration =
      Lens<CATransaction.Type, CFTimeInterval> (
        view: {$0.animationDuration()},
        set: {$1.setAnimationDuration($0); return $1})

    public static let animationTimingFunction =
      Lens<CATransaction.Type, CAMediaTimingFunction?> (
        view: {$0.animationTimingFunction()},
        set: {$1.setAnimationTimingFunction($0); return $1})

    public static let disableActions =
      Lens<CATransaction.Type, Bool> (
        view: {$0.disableActions()},
        set: {$1.setDisableActions($0); return $1})

    public static let completionBlock =
      Lens<CATransaction.Type, (() -> Swift.Void)?> (
        view: {$0.completionBlock()},
        set: {$1.setCompletionBlock($0); return $1})

    public static func value(forKey key: String) -> Lens<CATransaction.Type, Any?> {
      return Lens<CATransaction.Type, Any?> (
        view: {$0.value(forKey:key)},
        set: {$1.setValue($0, forKey:key ); return $1})
    }
  }
}

































