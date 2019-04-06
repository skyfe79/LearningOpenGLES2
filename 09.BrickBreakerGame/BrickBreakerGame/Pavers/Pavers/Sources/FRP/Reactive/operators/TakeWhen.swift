

public extension SignalProtocol {

  /**
   Emits the most recent value of `self` when `other` emits.

   - parameter other: Another signal.

   - returns: A new signal.
   */
  public func takeWhen <U> (_ other: Signal<U, Error>) -> Signal<Value, Error> {
    return other.withLatestFrom(self.signal).map { tuple in tuple.1 }
  }

  /**
   Emits the most recent value of `self` and `other` when `other` emits.

   - parameter other: Another signal.

   - returns: A new signal.
   */
  public func takePairWhen <U> (_ other: Signal<U, Error>) -> Signal<(Value, U), Error> {
    return other.withLatestFrom(self.signal).map { ($0.1, $0.0) }
  }
}

public extension SignalProducerProtocol {

  /**
   Emits the most recent value of `self` when `other` emits.

   - parameter other: Another producer.

   - returns: A new producer.
   */
  public func takeWhen <U> (_ other: Signal<U, Error>) -> Signal<Value, Error> {
    return other.withLatestFrom(self.producer).map { $0.1 }
  }

  /**
   Emits the most recent value of `self` and `other` when `other` emits.

   - parameter other: Another producer.

   - returns: A new producer.
   */
  public func takePairWhen <U> (_ other: Signal<U, Error>) -> Signal<(Value, U), Error> {
    return other.withLatestFrom(self.producer).map { ($0.1, $0.0) }
  }
}
