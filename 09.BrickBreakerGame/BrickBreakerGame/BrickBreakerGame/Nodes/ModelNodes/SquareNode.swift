//
//  Square.swift
//  Model
//
//  Created by burt on 2016. 2. 27..
//  Copyright © 2016년 BurtK. All rights reserved.
//
import GLKit

final internal class SquareNode : TriangleNode {

  let vertexList : [Vertex] = [
    Vertex( 1.0, -1.0, 0, 1.0, 0.0, 0.0, 1.0),
    Vertex( 1.0,  1.0, 0, 0.0, 1.0, 0.0, 1.0),
    Vertex(-1.0,  1.0, 0, 0.0, 0.0, 1.0, 1.0),
    Vertex(-1.0, -1.0, 0, 1.0, 1.0, 0.0, 1.0)
  ]

  let indexList : [GLuint] = [
    0, 1, 2,
    2, 3, 0
  ]

  init(shader: ShaderProgram) {
    super.init(name: "square", shader: shader, vertices: vertexList, indices: indexList)
  }

  override func updateWithDelta(_ dt: TimeInterval) {
    let secsPerMove = 2.0
    self.position = GLKVector3Make(
      Float(sin(CACurrentMediaTime() * 2 * Double.pi / secsPerMove)),
      self.position.y,
      self.position.z)
  }
}
