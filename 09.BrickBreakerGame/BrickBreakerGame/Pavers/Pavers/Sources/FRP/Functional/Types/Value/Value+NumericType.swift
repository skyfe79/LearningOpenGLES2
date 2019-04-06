import CoreGraphics

extension CGFloat : NumericType {
  public static func zero() -> CGFloat {
    return 0.0
  }
  public static func one() -> CGFloat {
    return 1.0
  }
}

extension Double : NumericType {
  public static func zero() -> Double {
    return 0.0
  }
  public static func one() -> Double {
    return 1.0
  }
}

