

public extension SignalProtocol {

  /**
   Demotes the `Error` of this signal to `NoError`, thus preventing it from ever erroring. Essentially the
   inverse of `promoteErrors`.

   - parameter value:  An optional value that will be played in place of the error.

   - returns: A new signal that will never error.
   */
  public func demoteErrors(replaceErrorWith value: Value? = nil) -> Signal<Value, NoError> {

    return self.signal
      .flatMapError { _ in
        if let value = value {
          return SignalProducer(value: value)
        }
        return SignalProducer.empty
    }
  }
}

public extension SignalProducerProtocol {
  /**
   Demotes the `Error` of the producer to `NoError`, thus preventing it from ever erroring. Essentially the
   inverse of `promoteErrors`.

   - parameter value:  An optional value that will be played in place of the error.

   - returns: A new producer that will never error.
   */
  public func demoteErrors(replaceErrorWith value: Value? = nil) -> SignalProducer<Value, NoError> {
    return self.producer.lift { $0.demoteErrors(replaceErrorWith: value) }
  }
}
