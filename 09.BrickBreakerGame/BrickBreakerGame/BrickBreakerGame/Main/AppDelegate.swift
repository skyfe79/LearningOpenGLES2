//
//  AppDelegate.swift
//  OpenGLESLearning
//
//  Created by Pi on 04/09/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
    -> Bool {

      self.window = UIWindow()
      self.window?.backgroundColor = .white
      self.window?.rootViewController = ViewController()
      self.window?.makeKeyAndVisible()

      return true
  }
}

