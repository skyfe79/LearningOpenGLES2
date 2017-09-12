extension Optional: OptionalType {
  public var optional: Wrapped? {
    return self
  }
}

/**
 Flattens a doubly nested optional.

 - parameter x: An optional.

 - returns: An optional.
 */
public func flattenOptional <A> (_ x: A??) -> A? {
  if let x = x { return x }
  return nil
}

public func isNil <A> (_ x: A?) -> Bool {
  return x == nil
}

public func isNotNil <A> (_ x: A?) -> Bool {
  return x != nil
}

/**
 An equality operator on arrays of equatable optionals.

 - parameter lhs: An array of equatable optionals.
 - parameter rhs: An array of equatable optionals.

 - returns: A boolean if the elements in both arrays are pairwise equal.
 */
public func == <A: Equatable> (lhs: [A?], rhs: [A?]) -> Bool {
  guard lhs.count == rhs.count else { return false }

  return zip(lhs, rhs).reduce(true) { (accum, lr) in
    return accum && lr.0 == lr.1
  }
}

/**
 An inequality operator on arrays of equatable optionals.

 - parameter lhs: An array of equatable optionals.
 - parameter rhs: An array of equatable optionals.

 - returns: A boolean if the elements in both arrays are not pairwise equal.
 */
public func != <A: Equatable> (lhs: [A?], rhs: [A?]) -> Bool {
  return !(lhs == rhs)
}

public func zip<A, B>(_ a: A?, _ b: B?) -> (A, B)? {
  return a.flatMap { a in b.map { b in (a, b) } }
}

public func zip<A, B, C>(_ a: A?, _ b: B?, _ c: C?) -> (A, B, C)? {
  return zip(a, b).flatMap { a, b in c.map { c in (a, b, c) } }
}

public func lift<A, B>(_ f: (A) -> B, _ x: A?) -> B? {
  return x.map(f)
}

public func lift<A, B, C>(_ f: (A, B) -> C, _ x: A?, _ y: B?) -> C? {
  return zip(x, y).map(f)
}

public func lift<A, B, C, D>(_ f: (A, B, C) -> D, _ x: A?, _ y: B?, _ z: C?) -> D? {
  return zip(x, y, z).map(f)
}
