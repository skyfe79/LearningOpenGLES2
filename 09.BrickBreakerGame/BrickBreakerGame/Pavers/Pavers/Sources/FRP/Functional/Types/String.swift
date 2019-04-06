extension String: Semigroup {
  public func op(_ other: String) -> String {
    return self + other
  }
}


extension String: Monoid {
  public static func identity() -> String {
    return ""
  }
}
