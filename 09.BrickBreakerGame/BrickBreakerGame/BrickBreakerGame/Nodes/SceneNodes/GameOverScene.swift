//
//  GameOverScene.swift
//  OpenGLESLearning
//
//  Created by Pi on 06/09/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import GLKit

final internal class GameOverScene: Scene {

  internal let gameArea: CGSize
  internal let sceneOffset: Float
//  internal let cube: CubeNode
  internal var timeSinceStart: TimeInterval = 0
  internal let msg: Node


  init(shaderProgram: ShaderProgram, win: Bool) {
    let height: CGFloat = 48
    let width = height * UIScreen.main.bounds.size.ratioW2H
    self.gameArea = CGSize(width, height)
    let x = self.gameArea.height / 2
    let y = tanf(GLKMathDegreesToRadians(90/2))
    self.sceneOffset = Float(x) / y
//    self.cube = CubeNode(shader: shaderProgram)

    let name = win ? "YouWin" : "YouLose"
    let msgResult = TriangleNode.node(name: name, objectFile: name + ".obj", textureFile: nil, with: shaderProgram)
    guard let msg = msgResult.value else {
      fatalError(msgResult.error?.localizedDescription ?? "colorCube created failed")
    }
    self.msg = msg


    super.init(name: "GameOverScene", shaderProgram: shaderProgram, vertices: [], indices: [])

    // create the initial scene position (i.e. camera)
    self.position = GLKVector3Make(Float(-self.gameArea.width / 2),
                                   Float(-self.gameArea.height / 2),
                                   -self.sceneOffset)
    
    self.msg.position = GLKVector3Make(Float(self.gameArea.width / 2),
                                        Float(self.gameArea.height * 0.5), 0)
    self.msg.scale = 3
    self.msg.rotationX = GLKMathDegreesToRadians(90)

    self.add(child:self.msg)
  }

  override func updateWithDelta(_ dt: TimeInterval) {
    super.updateWithDelta(dt)

    self.msg.rotationX = GLKMathDegreesToRadians(90) + Float(sin(CACurrentMediaTime() * 2 * Double.pi / 2))

    self.timeSinceStart += dt
    if timeSinceStart > 5 {
      guard let director = self.director else { return }
      director.scene = GameScene(shaderProgram: self.shaderProgram)
      director.backgroundMusicPlayer?.play()
    }
  }
}
