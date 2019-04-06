/// A `VectorType` instance is something that behaves like a linear vector does, i.e. it can be
/// scaled with numeric values and added to other vectors.
public protocol VectorType: Equatable {
  associatedtype Scalar: NumericType

  func scale(_ c: Scalar) -> Self
  func add(_ v: Self) -> Self
  func subtract(_ v: Self) -> Self
  func negateVector() -> Self
  static func zero() -> Self
}

public extension VectorType {
  /**
   Linearly interpolate between two vectors.

   - parameter b: Another vector to interpolate to.

   - returns: A function that interpolates between `self` and `b` as `t` varies from `0` to `1`.
   */
  public func lerp(_ b: Self) -> ((Self.Scalar) -> Self) {
    return { t in self * (Self.Scalar.one() - t) + b * t }
  }

  public func subtract(_ v: Self) -> Self {
    return self.add(v.negateVector())
  }

  public func negateVector() -> Self {
    return self.scale(Self.Scalar.one().negate())
  }
}

/**
 Linearly interpolate between two vectors. This is a free-function version of `VectorType.lerp`.

 - parameter a: A vector to interpolate from.
 - parameter b: A vector to interpolate to.

 - returns: A function that interpolates between `a` and `b` as `t` varies from `0` to `1`.
 */
public func lerp <V: VectorType> (_ a: V, _ b: V) -> ((V.Scalar) -> V) {
  return { t in a * (V.Scalar.one() - t) + b * t }
}

public func * <V: VectorType> (v: V, c: V.Scalar) -> V {
  return v.scale(c)
}

public func + <V: VectorType> (v: V, w: V) -> V {
  return v.add(w)
}

public func - <V: VectorType> (v: V, w: V) -> V {
  return v.subtract(w)
}

extension Double : VectorType {
  public typealias Scalar = Double

  public func scale(_ c: Double) -> Double {
    return self * c
  }

  public func add(_ v: Double) -> Double {
    return self + v
  }

  public func zero() -> Double {
    return 0.0
  }
}
