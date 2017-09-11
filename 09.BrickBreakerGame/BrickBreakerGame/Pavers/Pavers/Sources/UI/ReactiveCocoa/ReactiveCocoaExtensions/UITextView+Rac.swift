import PaversFRP
import UIKit

private enum AssociationsUITextView {
  fileprivate static var text = 0
}

public extension Rac where Object: UITextView {
  public var text: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &AssociationsUITextView.text,
        setter: { [weak object] in object?.text = $0 },
        getter: { [weak object] in object?.text ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
