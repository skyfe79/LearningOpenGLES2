import PaversFRP
import UIKit

public protocol CAGradientLayerProtocol: CALayerProtocol {
  var colors: [Any]? {get set}
  var locations: [NSNumber]? {get set}
  var startPoint: CGPoint {get set}
  var endPoint: CGPoint {get set}
}

extension CAGradientLayer: CAGradientLayerProtocol {}

extension LensHolder where Object: CAGradientLayerProtocol {
  public var colors: Lens<Object, [Any]?> {
    return Lens(
      view: { $0.colors },
      set: { $1.colors = $0; return $1 }
    )
  }

  public var locations: Lens<Object, [NSNumber]?> {
    return Lens(
      view: { $0.locations },
      set: { $1.locations = $0; return $1 }
    )
  }

  public var startPoint: Lens<Object, CGPoint> {
    return Lens(
      view: { $0.startPoint },
      set: { $1.startPoint = $0; return $1 }
    )
  }

  public var endPoint: Lens<Object, CGPoint> {
    return Lens(
      view: { $0.endPoint },
      set: { $1.endPoint = $0; return $1 }
    )
  }
}

