//: [Previous](@previous)

import Foundation

let longStr = """
      Hello_world
      """

enum Grouper {
  static let longStr = """
  Hello world
  """
}

print("StartOfString----"+Grouper.longStr+"----EndOfString")

//: [Next](@next)
