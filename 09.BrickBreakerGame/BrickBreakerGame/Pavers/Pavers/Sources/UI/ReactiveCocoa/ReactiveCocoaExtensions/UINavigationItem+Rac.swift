import PaversFRP
import UIKit

private enum AssociationsUINavigationItem {
  fileprivate static var title = 0
}

public extension Rac where Object: UINavigationItem {
  public var title: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &AssociationsUINavigationItem.title,
        setter: { [weak object] in object?.title = $0 },
        getter: { [weak object] in object?.title ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
