//
//  Vertex.swift
//  Triangle
//
//  Created by burt on 2016. 2. 25..
//  Copyright © 2016년 BurtK. All rights reserved.
//

import Foundation
import GLKit

internal struct Vertex {
  let x : GLfloat
  let y : GLfloat
  let z : GLfloat

  let r : GLfloat
  let g : GLfloat
  let b : GLfloat
  let a : GLfloat

  let u : GLfloat
  let v : GLfloat

  let nx : GLfloat
  let ny : GLfloat
  let nz : GLfloat
}

extension Vertex {
  init(_ x : GLfloat = 0.0,
       _ y : GLfloat = 0.0,
       _ z : GLfloat = 0.0,
       _ r : GLfloat = 0.0,
       _ g : GLfloat = 0.0,
       _ b : GLfloat = 0.0,
       _ a : GLfloat = 1.0,
       _ u : GLfloat = 0.0,
       _ v : GLfloat = 0.0,
       _ nx : GLfloat = 0.0,
       _ ny : GLfloat = 0.0,
       _ nz : GLfloat = 0.0) {
    self.x = x
    self.y = y
    self.z = z

    self.r = r
    self.g = g
    self.b = b
    self.a = a

    self.u = u
    self.v = v

    self.nx = nx
    self.ny = ny
    self.nz = nz
  }

}

























