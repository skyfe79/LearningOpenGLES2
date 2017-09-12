//
//  WaveLikeHillsModel.swift
//  OpenGLESLearning
//
//  Created by Pi on 05/09/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import GLKit
import Foundation

fileprivate func generateWave() -> ([Vertex], [TriangleStripIndex]) {
  let xRange = -50 ... 50
  var verticalEndPoints = [CGPoint]()
  for x in xRange {
    let actualX = CGFloat(x) / 10
    let actualY = sin(actualX) + 1 / 3 * actualX + 5
    let p1 = CGPoint(x: actualX / 10, y: actualY / 10)
    let p2 = CGPoint(x: actualX / 10, y: 0)
    verticalEndPoints.append(contentsOf: [p1, p2])
  }
  var vertice = verticalEndPoints.map{ Vertex(GLfloat($0.x), GLfloat($0.y), 0) }
  let n = vertice.count
  var m = (n - 2) / 4
  let r = (n - 2) % 4
  if r > 0, let lastOne = vertice.last {
    m += 1
    for _ in 0 ..< (4-r) {
      vertice.append(lastOne)
    }
  }

  var indice = [TriangleStripIndex]()
  for i in 0 ..< m {
    let lowerBound = GLuint(i * 4)
    indice.append(TriangleStripIndex(lowerBound,
                                     lowerBound + 1,
                                     lowerBound + 2,
                                     lowerBound + 3,
                                     lowerBound + 4,
                                     lowerBound + 5))
  }

  return (vertice, indice)
}



final class WaveLikeHillsModel: TriangleStripNode {
  init(shaderProgram: ShaderProgram) {
    let data = generateWave()
    super.init(name: "WaveLikeHills", shaderProgram: shaderProgram, vertices: data.0, indices: data.1)
  }
}

