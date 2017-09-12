import PaversFRP
import UIKit

private enum AssociationsNSObject {
  fileprivate static var accessibilityElementsHidden = 0
  fileprivate static var accessibilityHint = 1
  fileprivate static var accessibilityLabel = 2
  fileprivate static var accessibilityTraits = 3
  fileprivate static var accessibilityValue = 4
  fileprivate static var isAccessibilityElement = 5
}

public extension Rac where Object: NSObject {
  public var accessibilityElementsHidden: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &AssociationsNSObject.accessibilityElementsHidden,
        setter: { [weak object] in object?.accessibilityElementsHidden = $0 },
        getter: { [weak object] in object?.accessibilityElementsHidden ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var accessibilityHint: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &AssociationsNSObject.accessibilityHint,
        setter: { [weak object] in object?.accessibilityHint = $0 },
        getter: { [weak object] in object?.accessibilityHint ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var accessibilityLabel: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &AssociationsNSObject.accessibilityLabel,
        setter: { [weak object] in object?.accessibilityLabel = $0 },
        getter: { [weak object] in object?.accessibilityLabel ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var accessibilityTraits: Signal<UIAccessibilityTraits, NoError> {
    nonmutating set {
      let prop: MutableProperty<UIAccessibilityTraits> = lazyMutableProperty(
        object,
        key: &AssociationsNSObject.accessibilityTraits,
        setter: { [weak object] in object?.accessibilityTraits = $0 },
        getter: { [weak object] in object?.accessibilityTraits ?? UIAccessibilityTraitNone })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var accessibilityValue: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &AssociationsNSObject.accessibilityValue,
        setter: { [weak object] in object?.accessibilityValue = $0 },
        getter: { [weak object] in object?.accessibilityValue ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var isAccessibilityElement: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &AssociationsNSObject.isAccessibilityElement,
        setter: { [weak object] in object?.isAccessibilityElement = $0 },
        getter: { [weak object] in object?.isAccessibilityElement ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
