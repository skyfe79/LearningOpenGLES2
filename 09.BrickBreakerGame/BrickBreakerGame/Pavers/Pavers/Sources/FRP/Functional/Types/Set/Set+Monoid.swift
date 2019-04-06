extension SetAlgebra {
  public func op(_ other: Self) -> Self {
    return self.union(other)
  }
}

extension SetAlgebra {
  public static func identity() -> Self {
    return Self.init()
  }
}

extension Set: Monoid {}
