//
//  ViewController.swift
//  OpenGLESLearning
//
//  Created by Pi on 04/09/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import UIKit
import GLKit

final class ViewController: GLKViewController {

  fileprivate var glView: GLKView { return self.view as! GLKView }
  fileprivate var director: Director!


  override func viewDidLoad() {
    super.viewDidLoad()

    self.preferredFramesPerSecond = 60
    self.view.backgroundColor = .clear

    self.director = Director.gameDirector(of: self.glView)
    self.director.setPopEffect(file: "hit.wav")
  }

  func update() {
    self.director.scene.updateWithDelta(self.timeSinceLastUpdate)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.director.playBackgroundMusic(file: "bgm.wav")
  }
}


// MARK: - Drawing
extension ViewController {
  override func glkView(_ view: GLKView, drawIn rect: CGRect) {
    self.director.render(with: GLKMatrix4Identity)
  }
}

// MARK: - Reaction
extension ViewController {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.director.scene.touchesBegan(touches, with: event)
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.director.scene.touchesMoved(touches, with: event)
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.director.scene.touchesEnded(touches, with: event)
  }
}

























