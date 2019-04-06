//: Playground - noun: a place where people can play

import PaversFRP
import PaversUI
import UIKit
import PlaygroundSupport
import Foundation



let colors = [UIColor.random.cgColor, UIColor.random.cgColor, UIColor.random.cgColor]
let locations = [NSNumber(value: 0),NSNumber(value: 0.25),NSNumber(value: 0.5)]
let sp = CGPoint(x: 0, y: 0)
let ep = CGPoint(x: 1, y: 1)

let gViewStyle =
  UIGradientView.lens.gradientLayer.colors .~ colors
    >>> UIGradientView.lens.gradientLayer.locations .~ locations
    >>> UIGradientView.lens.gradientLayer.startPoint .~ sp
    >>> UIGradientView.lens.gradientLayer.endPoint .~ ep
    >>> UIGradientView.lens.frame .~ frame

let gView = UIGradientView()
gView |> gViewStyle


//PlaygroundPage.current.liveView = gView
// Set the device type and orientation.
let (parent, _) = playgroundControllers(device: .phone5_5inch, orientation: .portrait)

// Render the screen.
let frame = parent.view.frame






PlaygroundPage.current.liveView = gView


Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
  let colors = [UIColor.random.cgColor, UIColor.random.cgColor, UIColor.random.cgColor]

  gView |> UIGradientView.lens.gradientLayer.colors .~ colors

}












