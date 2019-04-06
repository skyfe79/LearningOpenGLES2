public extension SignalProtocol {

  /**
   Returns a signal of pairs: the previously emitted value and the currently emitted value. The first
   emission is skipped, so non-optional `Value`s are returned.

   - returns: A new signal.
   */
  public func combinePrevious() -> Signal<(Value, Value), Error> {

    return self.signal
      .wrapInOptional()
      .combinePrevious(nil)
      .skip(first: 1)
      .map { (old, new) in (old!, new!) }
  }
}

public extension SignalProducerProtocol {

  /**
   Returns a producer of pairs: the previously emitted value and the currently emitted value. The first
   emission is skipped, so non-optional `Value`s are returned.

   - returns: A new producer.
   */
  public func combinePrevious() -> SignalProducer<(Value, Value), Error> {
    return self.producer.lift { $0.combinePrevious() }
  }
}
