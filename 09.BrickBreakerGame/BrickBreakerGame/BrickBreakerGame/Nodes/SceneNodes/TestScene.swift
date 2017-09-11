//
//  TestScene.swift
//  OpenGLESLearning
//
//  Created by Pi on 06/09/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import GLKit
import UIKit

final class TestScene: Scene {

  let cube: TriangleNode

  init(shaderProgram sp: ShaderProgram) {
    //let colorCubeResult = TriangleNode.node(name: "Ball", objectFile: "ball.obj", textureFile: nil, with: sp)
    let colorCubeResult = TriangleNode.node(name: "YouWin", objectFile: "YouWin.obj", textureFile: nil, with: sp)
    guard let colorCube = colorCubeResult.value else {
      fatalError(colorCubeResult.error?.localizedDescription ?? "colorCube created failed")
    }

    self.cube = colorCube
    self.cube.rotated = true
    self.cube.scale = 3
    self.cube.rotationX = -GLKMathDegreesToRadians(90)
    super.init(name: "TestScene", shaderProgram: sp)
    self.director = director

    self.add(child: self.cube)
    self.position = GLKVector3Make(0, 0, -27)
    self.rotationX = GLKMathDegreesToRadians(20)
  }

}
