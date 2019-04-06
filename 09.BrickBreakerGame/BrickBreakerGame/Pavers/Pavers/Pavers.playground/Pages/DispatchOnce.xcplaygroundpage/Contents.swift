//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import PaversFRP

let concurrency = DispatchQueue(label: "concurrency", attributes: .concurrent)
let token = DispatchQueue.uniqueToken
(1...100).forEach { _ in
  concurrency.async {
    sleep(1)
    let token = DispatchQueue.uniqueToken
    DispatchQueue.once(token: token) {
      print("Got token: \(token)")
    }
  }
}

PlaygroundPage.current.needsIndefiniteExecution = true
