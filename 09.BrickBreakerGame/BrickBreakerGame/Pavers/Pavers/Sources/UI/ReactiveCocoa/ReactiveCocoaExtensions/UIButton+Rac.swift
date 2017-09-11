import PaversFRP
import UIKit

private enum AssociationsUIButton {
  fileprivate static var title = 0
  fileprivate static var attributedTitle = 1
}

public extension Rac where Object: UIButton {
  public var title: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &AssociationsUIButton.title,
        setter: { [weak object] in object?.setTitle($0, for: .normal) },
        getter: { [weak object] in object?.titleLabel?.text ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var attributedTitle: Signal<NSAttributedString, NoError> {
    nonmutating set {
      let prop: MutableProperty<NSAttributedString> = lazyMutableProperty(
        object,
        key: &AssociationsUIButton.attributedTitle,
        setter: { [weak object] in object?.setAttributedTitle($0, for: .normal) },
        getter: { [weak object] in object?.titleLabel?.attributedText ?? NSAttributedString(string: "") })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
