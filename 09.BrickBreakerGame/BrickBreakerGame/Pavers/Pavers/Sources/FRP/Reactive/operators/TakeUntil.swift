

extension SignalProtocol {

  /**
   - parameter predicate: A function that determines when to terminate the signal.

   - returns: A signal that emits values up to, and including, when `predicate` returns true. Once
              `predicate` returns false the signal is completed.
   */
  public func takeUntil(_ predicate: @escaping (Value) -> Bool) -> Signal<Value, Error> {
    return Signal { observer in
      return self.signal.observe { event in
        if case let .value(value) = event, predicate(value) {
          observer.send(value: value)
          observer.sendCompleted()
        } else {
          observer.action(event)
        }
      }
    }
  }
}

extension SignalProducerProtocol {

  /**
   - parameter predicate: A function that determines when to terminate the signal.

   - returns: A signal that emits values up to, and including, when `predicate` returns false. Once
              `predicate` returns false the signal is completed.
   */
  public func takeUntil(_ predicate: @escaping (Value) -> Bool) -> SignalProducer<Value, Error> {
    return self.producer.lift { $0.takeUntil(predicate) }
  }
}
