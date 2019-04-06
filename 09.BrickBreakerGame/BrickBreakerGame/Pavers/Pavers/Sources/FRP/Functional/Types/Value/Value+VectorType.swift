import CoreGraphics

extension CGFloat : VectorType {
  public typealias Scalar = CGFloat

  public func scale(_ c: CGFloat) -> CGFloat {
    return self * c
  }

  public func add(_ v: CGFloat) -> CGFloat {
    return self + v
  }
}

extension CGPoint : VectorType {
  public typealias Scalar = CGFloat

  public func scale(_ c: CGFloat) -> CGPoint {
    return CGPoint(x: self.x * c, y: self.y * c)
  }

  public func add(_ v: CGPoint) -> CGPoint {
    return CGPoint(x: self.x + v.x, y: self.y + v.y)
  }

  public static func zero() -> CGPoint {
    return CGPoint.zero
  }
}

extension CGRect : VectorType {
  public typealias Scalar = CGFloat

  public func scale(_ c: Scalar) -> CGRect {
    return CGRect(
      x: self.origin.x * c,
      y: self.origin.y * c,
      width: self.size.width * c,
      height: self.size.height * c
    )
  }

  public func add(_ v: CGRect) -> CGRect {
    return CGRect(
      x: self.origin.x + v.origin.x,
      y: self.origin.y + v.origin.y,
      width: self.size.width + v.size.width,
      height: self.size.height + v.size.height
    )
  }

  public static func zero() -> CGRect {
    return CGRect.zero
  }
}

extension CGRect {
  public init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
    self.init(x:x, y:y, width:w, height:h)
  }
}
extension CGSize {
  public init(_ width:CGFloat, _ height:CGFloat) {
    self.init(width:width, height:height)
  }
}
extension CGPoint {
  public init(_ x:CGFloat, _ y:CGFloat) {
    self.init(x:x, y:y)
  }
}
extension CGVector {
  public init (_ dx:CGFloat, _ dy:CGFloat) {
    self.init(dx:dx, dy:dy)
  }
}
