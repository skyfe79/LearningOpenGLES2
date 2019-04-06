

public extension SignalProtocol {

  /**
   Scans a signal without providing an initial value. The first emission of `self` will be emitted
   immediately, and subsequent emissions will be processed by the `combine` function.

   - parameter combine: The combining function used to scan the signal.

   - returns: A new signal.
   */
  public func scan(_ combine: @escaping (Value, Value) -> Value) -> Signal<Value, Error> {
    return Signal { observer in
      var accumulated: Value? = nil

      return self.signal.observe { event in
        observer.action(event.map { value in
          if let unwrapped = accumulated {
            let next = combine(unwrapped, value)
            accumulated = next
            return next
          }
          accumulated = value
          return value
          })
      }
    }
  }
}
