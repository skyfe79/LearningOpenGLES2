//
//  Cube.swift
//  AnimateCube
//
//  Created by burt on 2016. 2. 28..
//  Copyright © 2016년 BurtK. All rights reserved.
//

import GLKit

final internal class CubeNode : TriangleNode {
  let vertexList : [Vertex] = [

    // Front x,y,z,r,g,b,a,u,v,nx,ny,nz
    Vertex( 0.5, -0.5, 0.5,  1, 0, 0, 1,  1, 0,  0, 0, 1), // 0
    Vertex( 0.5,  0.5, 0.5,  0, 1, 0, 1,  1, 1,  0, 0, 1), // 1
    Vertex(-0.5,  0.5, 0.5,  0, 0, 1, 1,  0, 1,  0, 0, 1), // 2
    Vertex(-0.5, -0.5, 0.5,  0, 0, 0, 1,  0, 0,  0, 0, 1), // 3

    // Back
    Vertex(-0.5, -0.5, -0.5, 0, 0, 1, 1,  1, 0,  0, 0,-1), // 4
    Vertex(-0.5,  0.5, -0.5, 0, 1, 0, 1,  1, 1,  0, 0,-1), // 5
    Vertex( 0.5,  0.5, -0.5, 1, 0, 0, 1,  0, 1,  0, 0,-1), // 6
    Vertex( 0.5, -0.5, -0.5, 0, 0, 0, 1,  0, 0,  0, 0,-1), // 7

    // Left
    Vertex(-0.5, -0.5,  0.5, 1, 0, 0, 1,  1, 0, -1, 0, 0), // 8
    Vertex(-0.5,  0.5,  0.5, 0, 1, 0, 1,  1, 1, -1, 0, 0), // 9
    Vertex(-0.5,  0.5, -0.5, 0, 0, 1, 1,  0, 1, -1, 0, 0), // 10
    Vertex(-0.5, -0.5, -0.5, 0, 0, 0, 1,  0, 0, -1, 0, 0), // 11

    // Right
    Vertex( 0.5, -0.5, -0.5, 1, 0, 0, 1,  1, 0,  1, 0, 0), // 12
    Vertex( 0.5,  0.5, -0.5, 0, 1, 0, 1,  1, 1,  1, 0, 0), // 13
    Vertex( 0.5,  0.5,  0.5, 0, 0, 1, 1,  0, 1,  1, 0, 0), // 14
    Vertex( 0.5, -0.5,  0.5, 0, 0, 0, 1,  0, 0,  1, 0, 0), // 15

    // Top
    Vertex( 0.5,  0.5,  0.5, 1, 0, 0, 1,  1, 0,  0, 1, 0), // 16
    Vertex( 0.5,  0.5, -0.5, 0, 1, 0, 1,  1, 1,  0, 1, 0), // 17
    Vertex(-0.5,  0.5, -0.5, 0, 0, 1, 1,  0, 1,  0, 1, 0), // 18
    Vertex(-0.5,  0.5,  0.5, 0, 0, 0, 1,  0, 0,  0, 1, 0), // 19

    // Bottom
    Vertex( 0.5, -0.5, -0.5, 1, 0, 0, 1,  1, 0,  0,-1, 0), // 20
    Vertex( 0.5, -0.5,  0.5, 0, 1, 0, 1,  1, 1,  0,-1, 0), // 21
    Vertex(-0.5, -0.5,  0.5, 0, 0, 1, 1,  0, 1,  0,-1, 0), // 22
    Vertex(-0.5, -0.5, -0.5, 0, 0, 0, 1,  0, 0,  0,-1, 0), // 23

  ]

  let indexList : [GLuint] = [

    // Front
    0, 1, 2,
    2, 3, 0,

    // Back
    4, 5, 6,
    6, 7, 4,

    // Left
    8, 9, 10,
    10, 11, 8,

    // Right
    12, 13, 14,
    14, 15, 12,

    // Top
    16, 17, 18,
    18, 19, 16,

    // Bottom
    20, 21, 22,
    22, 23, 20
  ]

  init(shader: ShaderProgram) {
    super.init(name: "square", shader: shader, vertices: vertexList, indices: indexList)
    _ = self.loadTexture("dungeon_01.png")
  }

  override func updateWithDelta(_ dt: TimeInterval) {
    if rotated {
      self.rotationZ += Float(Double.pi*dt/2)
      self.rotationY += Float(Double.pi*dt/8)
    }
  }
}








