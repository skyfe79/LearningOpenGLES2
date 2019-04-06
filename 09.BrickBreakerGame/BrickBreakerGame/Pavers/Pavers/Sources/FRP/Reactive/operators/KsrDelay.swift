

public extension SignalProtocol {

  /**
   Debounces a signal by a time interval. The resulting signal emits a value only when `interval` seconds
   have passed since the last emission of `self`.

   - parameter interval:  The time to wait since last emission.
   - parameter scheduler: A scheduler.

   - returns: A new signal.
   */
  public func ksr_delay(_ interval: @autoclosure @escaping () -> DispatchTimeInterval,
                        on scheduler: @autoclosure @escaping () -> DateScheduler)
    -> Signal<Value, Error> {

      return self.signal.delay(interval().timeInterval, on: scheduler())
  }
}

public extension SignalProducerProtocol {

  /**
   Debounces a producer by a time interval. The resulting producer emits a value only when `interval` seconds
   have passed since the last emission of `self`.

   - parameter interval:  The time to wait since last emission.
   - parameter scheduler: A scheduler.

   - returns: A new producer.
   */
  public func ksr_delay(_ interval: @autoclosure @escaping () -> DispatchTimeInterval,
                        on scheduler: @autoclosure @escaping () -> DateScheduler)
    -> SignalProducer<Value, Error> {

      return self.producer.delay(interval().timeInterval, on: scheduler())
  }
}
