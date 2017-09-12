

public extension SignalProtocol {

  /**
   Transforms the signal into one that emits the most recent values of `self` and `other` only when `self`
   emits.

   - parameter other: A signal.

   - returns: A new signal.
   */
  public func withLatestFrom <U, OtherError> (_ other: Signal<U, OtherError>) ->
    Signal<(Value, U), OtherError> {

    return Signal { observer in
      let lock = NSLock()
      lock.name = "org.reactivecocoa.ReactiveCocoa.withLatestFrom"

      let disposable = CompositeDisposable()
      var latestValue: U? = nil

      disposable += other.observe { event in
        switch event {
        case let .value(value):
          lock.lock()
          latestValue = value
          lock.unlock()
        case let .failed(error):
          observer.send(error: error)
        case .completed:
          observer.sendCompleted()
        case .interrupted:
          observer.sendInterrupted()
        }
      }

      disposable += self.signal.observe { event in
        switch event {
        case let .value(value):
          lock.lock()
          if let latestValue = latestValue {
            observer.send(value: (value, latestValue))
          }
          lock.unlock()
        case .failed, .completed, .interrupted:
          // don't fail, complete or interrupt when the other does
          break
        }
      }

      return disposable
    }
  }

  /**
   Transforms the signal into one that emits the most recent values of `self` and `other` only when `self`
   emits.

   - parameter other: A producer.

   - returns: A new signal.
   */
  public func withLatestFrom <U, OtherError> (_ other: SignalProducer<U, OtherError>) ->
    Signal<(Value, U), OtherError> {

    return Signal { observer in
      let lock = NSLock()
      lock.name = "org.reactivecocoa.ReactiveCocoa.withLatestFrom"

      let disposable = CompositeDisposable()
      var latestValue: U? = nil

      disposable += other.start { event in
        switch event {
        case let .value(value):
          lock.lock()
          latestValue = value
          lock.unlock()
        case let .failed(error):
          observer.send(error: error)
        case .completed:
          observer.sendCompleted()
        case .interrupted:
          observer.sendInterrupted()
        }
      }

      disposable += self.signal.observe { event in
        switch event {
        case let .value(value):
          lock.lock()
          if let latestValue = latestValue {
            observer.send(value: (value, latestValue))
          }
          lock.unlock()
        case .failed, .completed, .interrupted:
          // don't fail, complete or interrupt when the other does
          break
        }
      }

      return disposable
    }
  }
}
