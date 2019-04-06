//: [Previous](@previous)

import UIKit

//print(UIFont.familyNames)
//
//print(UIFont.fontNames(forFamilyName: "Heiti"))

let fontNames = UIFont.familyNames.flatMap(
  UIFont.fontNames(forFamilyName:)
)
print(fontNames)




//: [Next](@next)
