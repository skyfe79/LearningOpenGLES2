public protocol NonEmpty {
  associatedtype Collection: Swift.Collection
  var head: Collection.Iterator.Element { get }
  var tail: Collection { get }
}

extension NonEmpty {
  public var count: Int {
    return self.tail.count.advanced(by: 1)
  }

  public var first: Collection.Iterator.Element {
    return self.head
  }
}

extension NonEmpty where Collection: RandomAccessCollection {
  public var last: Collection.Iterator.Element {
    return self.tail.last ?? self.head
  }
}

