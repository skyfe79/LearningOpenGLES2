import UIKit

public extension UIImage {

  public convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: CGPoint.zero, size: size)
    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    self.init(cgImage: (image?.cgImage!)!)
  }

  public var hasContent: Bool { return cgImage != nil || ciImage != nil }
  
  public func scale(to size: CGSize) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    defer { UIGraphicsEndImageContext() }
    self.draw(in: CGRect(0, 0, size.width, size.height))
    return UIGraphicsGetImageFromCurrentImageContext()
  }
  
  public func drawing(in tintColor: UIColor) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    defer { UIGraphicsEndImageContext() }
    
    tintColor.set()
    self.draw(in: .init(origin: .zero, size: self.size))
    
    return UIGraphicsGetImageFromCurrentImageContext()
  }
}
