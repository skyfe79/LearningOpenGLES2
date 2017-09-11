

public extension SignalProtocol {

  /**
   Transforms the signal into one that observes values on the UI thread.

   - returns: A new signal.
   */
  public func observeForUI() -> Signal<Value, Error> {
    return self.signal.observe(on: UIScheduler())
  }

  /**
   Transforms the signal into one that can perform actions for a controller. Use this operator when doing
   any side-effects from a controller. We've found that `UIScheduler` can be problematic with many
   controller actions, such as presenting and dismissing of view controllers.

   - returns: A new signal.
   */
  public func observeForControllerAction() -> Signal<Value, Error> {
    return self.signal.observe(on: QueueScheduler.main)
  }

  /**
   Transforms the signal into one that can perform actions on a background thread.

   - returns: A new signal.
   */
  public func observeInBackground() -> Signal<Value, Error> {
    return self.signal.observe(on: QueueScheduler())
  }
}

public extension SignalProducerProtocol {

  /**
   Transforms the producer into one that observes values on the UI thread.

   - returns: A new producer.
   */
  public func observeForUI() -> SignalProducer<Value, Error> {
    return self.producer.observe(on: UIScheduler())
  }

  /**
   Transforms the producer into one that observes values on a background thread.

   - returns: A new producer.
   */
  public func observeInBackground() -> SignalProducer<Value, Error> {
    return self.producer.observe(on: QueueScheduler())
  }
}
