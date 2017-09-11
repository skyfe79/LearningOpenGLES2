

public extension SignalProtocol {

  /**
   Transforms a signal of `Value`s into a signal of `Optional<Value>`s by simply wrapping each emission.

   - returns: A new signal.
   */
  public func wrapInOptional() -> Signal<Value?, Error> {
    return signal.map { x in Optional(x) }
  }
}

public extension SignalProducerProtocol {

  /**
   Transforms a producer of `Value`s into a producer of `Optional<Value>`s by simply wrapping each emission.

   - returns: A new producer.
   */
  public func wrapInOptional() -> SignalProducer<Value?, Error> {
    return self.producer.lift { $0.wrapInOptional() }
  }
}
