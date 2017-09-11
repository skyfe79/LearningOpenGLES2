public protocol LensObject {}

public extension LensObject {
  public static var lens: LensHolder<Self> {
    return LensHolder()
  }
}
