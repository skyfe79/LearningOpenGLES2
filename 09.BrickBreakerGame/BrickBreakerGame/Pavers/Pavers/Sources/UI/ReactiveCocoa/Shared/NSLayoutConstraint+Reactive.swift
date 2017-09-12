import PaversFRP

#if os(macOS)
import AppKit
public typealias ViewClass = NSView
#else
import UIKit
#endif

extension Reactive where Base: NSLayoutConstraint {

	/// Sets the constant.
	public var constant: BindingTarget<CGFloat> {
		return makeBindingTarget { $0.constant = $1 }
	}

}
