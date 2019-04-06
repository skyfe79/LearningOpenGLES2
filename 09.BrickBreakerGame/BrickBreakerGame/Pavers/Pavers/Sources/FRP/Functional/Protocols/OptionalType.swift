/// An optional protocol for use in type constraints.
public protocol OptionalType {
  /// The type contained in the optional.
  associatedtype Wrapped

  /// Extracts an optional from the receiver.
  var optional: Wrapped? { get }
}

extension OptionalType {
  public var isNil: Bool {
    return self.optional == nil
  }

  public var isSome: Bool {
    return !isNil
  }

  public func forceUnwrap() -> Wrapped {
    return self.optional!
  }

  // swiftlint:disable valid_docs
  /**
   Call `body` on wrapped value of `self` if present. An analog to `Sequence.forEach`.

   - parameter body: A procedure to call on the wrapped value of `self` if present.
   */
  public func doIfSome(_ body: (Wrapped) throws -> Void) rethrows {
    if let value = self.optional {
      try body(value)
    }
  }
  // swiftlint:enable valid_docs

  /**
   - parameter predicate: A predicate that determines if the wrapped value should be kept or not.

   - returns: If optional is not `nil` and satisfies predicate, it is returned, otherwise `nil`
   is returned.
   */
  public func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
    if let value = self.optional, predicate(value) {
      return value
    }
    return nil
  }

  /**
   Coalesces `self` into an unwrapped value. This is a functional equivalent of the `??` operator.

   - parameter value:

   - returns:
   */
  public func coalesceWith(_ value: @autoclosure () -> Wrapped) -> Wrapped {
    return self.optional ?? value()
  }
}
