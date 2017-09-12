#if os(iOS)
import PaversFRP
import UIKit

private enum AssociationsUIRefreshControl {
  fileprivate static var isRefreshing = 0
}

public extension Rac where Object: UIRefreshControl {
  public var refreshing: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &AssociationsUIRefreshControl.isRefreshing,
        setter: { [weak object] in $0 ? object?.beginRefreshing() : object?.endRefreshing() },
        getter: { [weak object] in object?.isRefreshing ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
#endif
