func ret<S, A>(_ a: A) -> State<S, A> {
  return { (s: S) -> (A,S) in
    return (a, s)
  }
}

public func join<S, A>(_ f: @escaping State<S, State<S,A>>) -> State<S, A> {
  return { (s0: S) -> (A, S) in
    let (g, s1) = f(s0)
    return g(s1)
  }
}

public func >>- <A, B, S> (_ s: @escaping State<S, A>, _ f: @escaping ((A) -> State<S, B>))
  -> State<S, B> {
    return join(f<^>s)
}

public func -<< <A, B, S> (_ f: @escaping ((A) -> State<S, B>), _ s: @escaping State<S, A>)
  -> State<S, B> {
    return s >>- f
}


public func >-> <A, B, C, S>
  (_ f: @escaping (A) -> State<S, B>,_ g: @escaping (B) -> State<S, C>)
  -> ((A) -> State<S, C>) {
    return { (a: A) -> State<S,C> in
      let x = f(a)
      return x >>- g
    }
}

public func <-< <A, B, C, S>
  (_ f: @escaping (B) -> State<S, C>,_ g: @escaping (A) -> State<S, B>)
  -> ((A) -> State<S, C>) {
    return g >-> f
}


func ret<S, A>(_ a: A) -> NominalState<S, A> {
  return NominalState.state(
    { (s: S) -> (A,S) in return (a, s) }
  )
}

public func join<S, A>(_ state: NominalState<S, NominalState<S,A>>) -> NominalState<S, A> {
  return NominalState.state(
    { (s0: S) -> (A, S) in
      switch state {
      case .state(let f):
        let (g, s1) = f(s0)
        switch g {
        case .state(let g0):
          return g0(s1)
        }
      }
    }
  )
}

public func >>- <A, B, S> (_ s: NominalState<S, A>, _ f: @escaping ((A) -> NominalState<S, B>))
  -> NominalState<S, B> {
    return join(f<^>s)
}

public func -<< <A, B, S> (_ f: @escaping ((A) -> NominalState<S, B>), _ s: NominalState<S, A>)
  -> NominalState<S, B> {
    return s >>- f
}


public func >-> <A, B, C, S>
  (_ f: @escaping (A) -> NominalState<S, B>,_ g: @escaping (B) -> NominalState<S, C>)
  -> ((A) -> NominalState<S, C>) {
    return { (a: A) -> NominalState<S,C> in
      let x = f(a)
      return x >>- g
    }
}

public func <-< <A, B, C, S>
  (_ f: @escaping (B) -> NominalState<S, C>,_ g: @escaping (A) -> NominalState<S, B>)
  -> ((A) -> NominalState<S, C>) {
    return g >-> f
}












