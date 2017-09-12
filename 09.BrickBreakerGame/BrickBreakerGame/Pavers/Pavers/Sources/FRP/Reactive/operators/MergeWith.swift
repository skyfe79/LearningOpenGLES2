

public extension SignalProtocol {

  /**
   Merges `self` with another signal.

   - parameter other: The other signal.

   - returns: A merged signal.
   */
  public func mergeWith (_ other: Signal<Value, Error>) -> Signal<Value, Error> {
    return Signal.merge([self.signal, other])
  }
}

public extension SignalProducerProtocol {

  /**
   Merges `self` with another producer.

   - parameter other: The other producer.

   - returns: A merged producer.
   */
  public func mergeWith (_ other: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
    return SignalProducer<SignalProducer<Value, Error>, Error>([self.producer, other]).flatten(.merge)
  }
}
