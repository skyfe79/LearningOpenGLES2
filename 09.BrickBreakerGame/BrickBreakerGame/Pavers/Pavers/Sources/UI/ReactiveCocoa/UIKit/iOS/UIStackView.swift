import PaversFRP
import UIKit

//private enum UIStackViewAssociations {
//  fileprivate static var alignment = 0
//  fileprivate static var axis = 1
//}
//
//public extension Reactive where Base: UIStackView {
//  public var axis: Signal<UILayoutConstraintAxis, NoError> {
//    nonmutating set {
//      let prop: MutableProperty<UILayoutConstraintAxis> = lazyMutableProperty(
//        base, key: &UIStackViewAssociations.axis,
//        setter: { [weak base] in base?.axis = $0 },
//        getter: { [weak base] in base?.axis ?? .horizontal })
//
//      prop <~ newValue.observeForUI()
//    }
//    get {
//      return .empty
//    }
//  }
//
//  public var alignment: Signal<UIStackViewAlignment, NoError> {
//    nonmutating set {
//      let prop: MutableProperty<UIStackViewAlignment> = lazyMutableProperty(
//        base, key: &UIStackViewAssociations.alignment,
//        setter: { [weak base] in base?.alignment = $0 },
//        getter: { [weak base] in base?.alignment ?? .fill })
//
//      prop <~ newValue.observeForUI()
//    }
//    get {
//      return .empty
//    }
//  }
//}

