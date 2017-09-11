import PaversFRP
import UIKit

private enum AssociationsUIBarButtonItem {
  fileprivate static var enabled = 0
}

public extension Rac where Object: UIBarButtonItem {
  public var enabled: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &AssociationsUIBarButtonItem.enabled,
        setter: { [weak object] in object?.isEnabled = $0 },
        getter: { [weak object] in object?.isEnabled ?? true })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
