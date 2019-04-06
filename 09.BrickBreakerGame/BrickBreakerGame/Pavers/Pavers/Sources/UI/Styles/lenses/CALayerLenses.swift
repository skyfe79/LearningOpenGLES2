// swiftlint:disable type_name
import PaversFRP
import UIKit

public protocol CALayerProtocol: KSObjectProtocol {
  var borderColor: CGColor? { get set }
  var borderWidth: CGFloat { get set }

  var cornerRadius: CGFloat { get set }

  var masksToBounds: Bool { get set }

  var shadowColor: CGColor? { get set }
  var shadowOffset: CGSize { get set }
  var shadowOpacity: Float { get set }
  var shadowRadius: CGFloat { get set }
  var shadowPath: CGPath? {get set}

  var shouldRasterize: Bool { get set }
  var rasterizationScale: CGFloat {get set}

  var contents: Any? {get set}
  var contentsRect: CGRect { get set }
  var contentsCenter: CGRect { get set }

  var mask: CALayer? {get set}

  var minificationFilter: String {get set}

  var magnificationFilter: String {get set}

  var transform: CATransform3D {get set}

}

extension CALayer: CALayerProtocol {}

extension LensHolder where Object: CALayerProtocol {
  public var borderColor: Lens<Object, CGColor?> {
    return Lens(
      view: { $0.borderColor },
      set: { $1.borderColor = $0; return $1 }
    )
  }

  public var borderWidth: Lens<Object, CGFloat> {
    return Lens(
      view: { $0.borderWidth },
      set: { $1.borderWidth = $0; return $1 }
    )
  }
  public var cornerRadius: Lens<Object, CGFloat> {
    return Lens(
      view: { $0.cornerRadius },
      set: { $1.cornerRadius = $0; return $1 }
    )
  }

  public var masksToBounds: Lens<Object, Bool> {
    return Lens(
      view: { $0.masksToBounds },
      set: { $1.masksToBounds = $0; return $1 }
    )
  }

  public var shadowColor: Lens<Object, CGColor?> {
    return Lens(
      view: { $0.shadowColor },
      set: { $1.shadowColor = $0; return $1 }
    )
  }

  public var shadowOffset: Lens<Object, CGSize> {
    return Lens(
      view: { $0.shadowOffset },
      set: { $1.shadowOffset = $0; return $1 }
    )
  }

  public var shadowOpacity: Lens<Object, Float> {
    return Lens(
      view: { $0.shadowOpacity },
      set: { $1.shadowOpacity = $0; return $1 }
    )
  }

  public var shadowRadius: Lens<Object, CGFloat> {
    return Lens(
      view: { $0.shadowRadius },
      set: { $1.shadowRadius = $0; return $1 }
    )
  }

  public var shadowPath: Lens<Object, CGPath?> {
    return Lens(
      view: { $0.shadowPath },
      set: { $1.shadowPath = $0; return $1 }
    )
  }

  public var shouldRasterize: Lens<Object, Bool> {
    return Lens(
      view: { $0.shouldRasterize },
      set: { $1.shouldRasterize = $0; return $1 }
    )
  }

  public var rasterizationScale: Lens<Object, CGFloat> {
    return Lens(
      view: { $0.rasterizationScale },
      set: { $1.rasterizationScale = $0; return $1 }
    )
  }



  public var contents: Lens<Object, Any?> {
    return Lens(
      view: { $0.contents },
      set: { $1.contents = $0; return $1 }
    )
  }

  public var contentsRect: Lens<Object, CGRect> {
    return Lens(
      view: {$0.contentsRect},
      set: { $1.contentsRect = $0; return $1 }
    )
  }

  public var contentsCenter: Lens<Object, CGRect> {
    return Lens(
      view: {$0.contentsCenter},
      set: { $1.contentsCenter = $0; return $1 }
    )
  }

  public var mask: Lens<Object, CALayer?> {
    return Lens(
      view: {$0.mask},
      set: { $1.mask = $0; return $1 }
    )
  }

  public var minificationFilter: Lens<Object, String> {
    return Lens(
      view: {$0.minificationFilter},
      set: { $1.minificationFilter = $0; return $1 }
    )
  }

  public var magnificationFilter: Lens<Object, String> {
    return Lens(
      view: {$0.magnificationFilter},
      set: { $1.magnificationFilter = $0; return $1 }
    )
  }

  public var transform: Lens<Object, CATransform3D> {
    return Lens(
      view: {$0.transform},
      set: { $1.transform = $0; return $1 }
    )
  }

}
