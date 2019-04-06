import PaversFRP
import UIKit

public class UIGradientView: UIView {

  public var gradientLayer: CAGradientLayer {return self.layer as! CAGradientLayer}

  override public class var layerClass: Swift.AnyClass {
    return CAGradientLayer.self
  }

  override public func action(for layer: CALayer, forKey event: String) -> CAAction? {

    if event == "colors" {
      if let acts = layer.actions, let act = acts[event]  {
        return act
      }
      if let style = layer.style, let act = style[event] {
        return act as? CAAction
      }
      return CAGradientLayer.defaultAction(forKey:event)
    }

    return super.action(for: layer, forKey: event)
  }
}

public protocol UIGradientViewProtocol: UIViewProtocol {
  var gradientLayer: CAGradientLayer { get }
}

extension UIGradientView: UIGradientViewProtocol {}

extension LensHolder where Object: UIGradientViewProtocol {
  public var gradientLayer: Lens<Object, CAGradientLayer> {
    return Lens(
      view: { $0.gradientLayer },
      set: { $1 }
    )
  }
}

extension Lens where Whole: UIGradientViewProtocol, Part == CAGradientLayer {
  public var colors: Lens<Whole, [Any]?> {
    return Whole.lens.gradientLayer>>>CAGradientLayer.lens.colors
  }

  public var locations: Lens<Whole, [NSNumber]?> {
    return Whole.lens.gradientLayer >>> CAGradientLayer.lens.locations
  }

  public var startPoint: Lens<Whole, CGPoint> {
    return Whole.lens.gradientLayer >>> CAGradientLayer.lens.startPoint
  }

  public var endPoint: Lens<Whole, CGPoint> {
    return Whole.lens.gradientLayer >>> CAGradientLayer.lens.endPoint
  }
}

