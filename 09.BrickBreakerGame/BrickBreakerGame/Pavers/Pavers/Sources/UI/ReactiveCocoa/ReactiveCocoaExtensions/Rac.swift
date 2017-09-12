import UIKit

/**
 A type meant to be extended to provide a collection of reactive bindings for
 UIKit views and their subclasses.
 */
public struct Rac<Object: RacObject> {
  public let object: Object
}

/**
 UIView conforms to this protocol to expose (by extension) a `rac` signal
 namespace scoped by dynamic subclass.
 */
public protocol RacObject {}

public extension RacObject {
  typealias Object = Self

  /**
   A collection of reactive bindings.
  */
  public var rac: Rac<Object> {
    return Rac(object: self)
  }
}

extension NSObject: RacObject {}
