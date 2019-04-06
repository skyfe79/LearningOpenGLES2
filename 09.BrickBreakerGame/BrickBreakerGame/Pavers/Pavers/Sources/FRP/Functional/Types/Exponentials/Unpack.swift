/**
 Unpacks a nested tuple into a flat tuple.

 - parameter ab: A tuple
 - parameter c:  A value

 - returns: A flattened 3-tuple.
 */
public func unpack <A, B, X> (_ ab: (A, B), x: X) -> (A, B, X) {
  return (ab.0, ab.1, x)
}

public func unpack <A, B, C, X> (_ ab: (A, B, C), x: X) -> (A, B, C, X) {
  return (ab.0, ab.1, ab.2, x)
}

public func unpack <A, B, C, D, X> (_ ab: (A, B, C, D), x: X) -> (A, B, C, D, X) {
  return (ab.0, ab.1, ab.2, ab.3, x)
}

public func unpack <A, B, C, D, E, X> (_ ab: (A, B, C, D, E), x: X) -> (A, B, C, D, E, X) {
  return (ab.0, ab.1, ab.2, ab.3, ab.4, x)
}

public func unpack <A, B, C, D, E, F, X> (_ ab: (A, B, C, D, E, F), x: X) -> (A, B, C, D, E, F, X) {
  return (ab.0, ab.1, ab.2, ab.3, ab.4, ab.5, x)
}

public func unpack <A, B, C, D, E, F, G, X> (_ ab: (A, B, C, D, E, F, G), x: X) -> (A, B, C, D, E, F, G, X) {
  return (ab.0, ab.1, ab.2, ab.3, ab.4, ab.5, ab.6, x)
}

/**
 Unpacks a nested tuple into a flat tuple.

 - parameter a:  A value
 - parameter bc: A tuple

 - returns: A flattened 3-tuple.
 */
public func unpack <A, B, C> (_ a: A, bc: (B, C)) -> (A, B, C) {
  return (a, bc.0, bc.1)
}

public func unpack <A, B, C, D> (_ a: A, bc: (B, C, D)) -> (A, B, C, D) {
  return (a, bc.0, bc.1, bc.2)
}
public func unpack <A, B, C, D, E> (_ a: A, bc: (B, C, D, E)) -> (A, B, C, D, E) {
  return (a, bc.0, bc.1, bc.2, bc.3)
}
public func unpack <A, B, C, D, E, F> (_ a: A, bc: (B, C, D, E, F)) -> (A, B, C, D, E, F) {
  return (a, bc.0, bc.1, bc.2, bc.3, bc.4)
}
public func unpack <A, B, C, D, E, F, G> (_ a: A, bc: (B, C, D, E, F, G)) -> (A, B, C, D, E, F, G) {
  return (a, bc.0, bc.1, bc.2, bc.3, bc.4, bc.5)
}
