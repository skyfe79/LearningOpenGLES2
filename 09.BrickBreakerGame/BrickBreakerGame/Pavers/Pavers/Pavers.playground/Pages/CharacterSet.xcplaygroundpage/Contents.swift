//: [Previous](@previous)

extension Collection {
  public var powerSet: [[Element]] {
    guard let fisrt = self.first else {return [[]]}
    return self.dropFirst().powerSet.flatMap{[$0, [fisrt] + $0]}
  }
}
let s: Set<Int> = [1,2,3]
s.powerSet //[[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
let a: Array<Int> = [1,2,3]
a.powerSet //[[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
//: [Next](@next)
