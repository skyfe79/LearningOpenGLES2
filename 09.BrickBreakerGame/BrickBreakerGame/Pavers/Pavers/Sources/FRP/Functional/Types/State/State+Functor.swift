public func <^><A, B, S>(_ f: @escaping (A) -> B, _ g: @escaping State<S,A>)
  -> State<S, B> {
    return { (s: S) -> (B, S) in
      let (l, r) = g(s)
      return (f(l), r)
    }
}

public func <^><A, B, S>(_ f: @escaping (A) -> B, _ state: NominalState<S,A>)
  -> NominalState<S, B> {
    return NominalState.state(
      { (s: S) -> (B, S) in
        switch state {
        case .state(let g):
          let (l, r) = g(s)
          return (f(l), r)
        }
      }
    )
}
