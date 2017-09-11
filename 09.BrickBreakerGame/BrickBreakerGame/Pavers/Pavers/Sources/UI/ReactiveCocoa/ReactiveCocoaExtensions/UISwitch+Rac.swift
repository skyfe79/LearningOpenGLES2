#if os(iOS)
import PaversFRP
import UIKit

private enum AssociationsUISwitch {
  fileprivate static var on = 0
}

public extension Rac where Object: UISwitch {
  public var on: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object, key: &AssociationsUISwitch.on,
        setter: { [weak object] in object?.isOn = $0 },
        getter: { [weak object] in object?.isOn ?? false })

      prop <~ newValue.observeForUI()
    }
    get {
      return .empty
    }
  }
}
#endif
