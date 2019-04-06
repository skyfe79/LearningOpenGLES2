public typealias State<S, A> = (S) -> (A, S)

public enum NominalState<S, A> {
  case state((S) -> (A, S))
}

public func toState<S, A>(s: NominalState<S, A>) -> State<S, A> {
  switch s {
  case .state(let f):
    return f
  }
}

public func toNominalState<S, A> (s: @escaping State<S, A>) -> NominalState<S, A> {
  return .state(s)
}
















