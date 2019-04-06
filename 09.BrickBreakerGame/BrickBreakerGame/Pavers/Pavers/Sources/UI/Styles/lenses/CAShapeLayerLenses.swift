import PaversFRP
import UIKit

public protocol CAShapeLayerProtocol: CALayerProtocol {
  /* The path defining the shape to be rendered. If the path extends
   * outside the layer bounds it will not automatically be clipped to the
   * layer, only if the normal layer masking rules cause that. Upon
   * assignment the path is copied. Defaults to null. Animatable.
   * (Note that although the path property is animatable, no implicit
   * animation will be created when the property is changed.) */

  var path: CGPath? {get set}


  /* The color to fill the path, or nil for no fill. Defaults to opaque
   * black. Animatable. */

  var fillColor: CGColor? {get set}


  /* The fill rule used when filling the path. Options are `non-zero' and
   * `even-odd'. Defaults to `non-zero'. */

  var fillRule: String {get set}


  /* The color to fill the path's stroked outline, or nil for no stroking.
   * Defaults to nil. Animatable. */

  var strokeColor: CGColor? {get set}


  /* These values define the subregion of the path used to draw the
   * stroked outline. The values must be in the range [0,1] with zero
   * representing the start of the path and one the end. Values in
   * between zero and one are interpolated linearly along the path
   * length. strokeStart defaults to zero and strokeEnd to one. Both are
   * animatable. */

  var strokeStart: CGFloat {get set}

  var strokeEnd: CGFloat {get set}


  /* The line width used when stroking the path. Defaults to one.
   * Animatable. */

  var lineWidth: CGFloat {get set}


  /* The miter limit used when stroking the path. Defaults to ten.
   * Animatable. */

  var miterLimit: CGFloat {get set}


  /* The cap style used when stroking the path. Options are `butt', `round'
   * and `square'. Defaults to `butt'. */

  var lineCap: String {get set}


  /* The join style used when stroking the path. Options are `miter', `round'
   * and `bevel'. Defaults to `miter'. */

  var lineJoin: String {get set}


  /* The phase of the dashing pattern applied when creating the stroke.
   * Defaults to zero. Animatable. */

  var lineDashPhase: CGFloat {get set}


  /* The dash pattern (an array of NSNumbers) applied when creating the
   * stroked version of the path. Defaults to nil. */

  var lineDashPattern: [NSNumber]? {get set}

}

extension CAShapeLayer: CAShapeLayerProtocol {}

extension LensHolder where Object: CAShapeLayerProtocol {
  public var path: Lens<Object, CGPath?> {
    return Lens(
      view: { $0.path },
      set: { $1.path = $0; return $1 }
    )
  }
  public var fillColor: Lens<Object, CGColor?> {
    return Lens(
      view: { $0.fillColor },
      set: { $1.fillColor = $0; return $1 }
    )
  }
  public var fillRule: Lens<Object, String> {
    return Lens(
      view: { $0.fillRule },
      set: { $1.fillRule = $0; return $1 }
    )
  }
  public var strokeColor: Lens<Object, CGColor?> {
    return Lens(
      view: { $0.strokeColor },
      set: { $1.strokeColor = $0; return $1 }
    )
  }
  public var strokeStart: Lens<Object, CGFloat> {
    return Lens(
      view: { $0.strokeStart },
      set: { $1.strokeStart = $0; return $1 }
    )
  }
  public var strokeEnd: Lens<Object, CGFloat> {
    return Lens(
      view: { $0.strokeEnd },
      set: { $1.strokeEnd = $0; return $1 }
    )
  }
  public var lineWidth: Lens<Object, CGFloat> {
    return Lens(
      view: { $0.lineWidth },
      set: { $1.lineWidth = $0; return $1 }
    )
  }
  public var miterLimit: Lens<Object, CGFloat> {
    return Lens(
      view: { $0.miterLimit },
      set: { $1.miterLimit = $0; return $1 }
    )
  }
  public var lineCap: Lens<Object, String> {
    return Lens(
      view: { $0.lineCap },
      set: { $1.lineCap = $0; return $1 }
    )
  }
  public var lineJoin: Lens<Object, String> {
    return Lens(
      view: { $0.lineJoin },
      set: { $1.lineJoin = $0; return $1 }
    )
  }
  public var lineDashPhase: Lens<Object, CGFloat> {
    return Lens(
      view: { $0.lineDashPhase },
      set: { $1.lineDashPhase = $0; return $1 }
    )
  }
  public var lineDashPattern: Lens<Object, [NSNumber]?> {
    return Lens(
      view: { $0.lineDashPattern },
      set: { $1.lineDashPattern = $0; return $1 }
    )
  }
}




























