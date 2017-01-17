//
//  Vertex.swift
//  Triangle
//
//  Created by burt on 2016. 2. 25..
//  Copyright © 2016년 BurtK. All rights reserved.
//

import Foundation
import GLKit

enum VertexAttributes : GLuint {
    case vertexAttribPosition = 0
}

struct Vertex {
    var x : GLfloat = 0.0
    var y : GLfloat = 0.0
    var z : GLfloat = 0.0
    
    init(_ x : GLfloat, _ y : GLfloat, _ z : GLfloat) {
        self.x = x
        self.y = y
        self.z = z 
    }
}
