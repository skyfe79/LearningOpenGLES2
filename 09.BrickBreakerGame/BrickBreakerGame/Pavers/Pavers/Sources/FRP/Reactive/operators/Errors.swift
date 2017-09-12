

extension SignalProtocol where Value: EventProtocol, Error == NoError {
  /**
   - returns: A signal of errors of `Error` events from a materialized signal.
   */
  public func errors() -> Signal<Value.Error, NoError> {
    return self.signal.map { $0.event.error }.skipNil()
  }
}

extension SignalProducerProtocol where Value: EventProtocol, Error == NoError {
  /**
   - returns: A producer of errors of `Error` events from a materialized signal.
   */
  public func errors() -> SignalProducer<Value.Error, NoError> {
    return self.producer.lift { $0.errors() }
  }
}
