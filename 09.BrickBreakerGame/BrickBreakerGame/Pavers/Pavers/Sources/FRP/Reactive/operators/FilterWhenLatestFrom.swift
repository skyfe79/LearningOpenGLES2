

public extension SignalProtocol {

  /**
   Filters a signal by using a predicate on the latest emitted value from another signal.

   - Parameters:
   - other: The other signal to use for the filtering mechanism.
   - satisfies: The predicate to use to test values emitted by `other`.

   - Returns: A new signal of type `(Value, Error)`.
   */
  public func filterWhenLatestFrom <U> (_ other: Signal<U, Error>, satisfies: @escaping (U) -> Bool)
    -> Signal<Value, Error> {

    return self.signal.withLatestFrom(other)
      .filter { (_, value) in satisfies(value) }
      .map { $0.0 }
  }
}
