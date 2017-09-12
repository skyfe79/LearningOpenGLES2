

public extension SignalProtocol {

  public func mergeMap <U> (_ f: @escaping (Value) -> SignalProducer<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.merge, f)
  }

  public func mergeMap <U> (_ f: @escaping (Value) -> Signal<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.merge, f)
  }
}

public extension SignalProducerProtocol {

  public func mergeMap <U> (_ f: @escaping (Value) -> SignalProducer<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.merge, f)
  }

  public func mergeMap <U> (_ f: @escaping (Value) -> Signal<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.merge, f)
  }
}
