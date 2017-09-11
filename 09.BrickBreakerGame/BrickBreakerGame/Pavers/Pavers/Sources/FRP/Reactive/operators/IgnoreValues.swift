

public extension SignalProtocol {

  /**
   Creates a new signal that emits a void value for every emission of `self`.

   - returns: A new signal.
   */
  public func ignoreValues() -> Signal<Void, Error> {
    return signal.map { _ in () }
  }
}

public extension SignalProducerProtocol {

  /**
   Creates a new producer that emits a void value for every emission of `self`.

   - returns: A new producer.
   */
  public func ignoreValues() -> SignalProducer<Void, Error> {
    return self.producer.lift { $0.ignoreValues() }
  }
}
