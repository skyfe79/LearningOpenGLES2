//
//  Cube.swift
//  AnimateCube
//
//  Created by burt on 2016. 2. 28..
//  Copyright © 2016년 BurtK. All rights reserved.
//

import GLKit

class Cube : Model {
    let vertexList : [Vertex] = [
        
        // Front
        Vertex(1, -1, 1,   1, 0, 0, 1),     // 0
        Vertex(1,  1, 1,   1, 0, 0, 1),     // 1
        Vertex(-1, 1, 1,   0, 1, 0, 1),     // 2
        Vertex(-1,-1, 1,   0, 1, 0, 1),     // 3
        
        
        // Back
        Vertex(-1,-1,-1,   1, 0, 0, 1),     // 4
        Vertex(-1, 1,-1,   1, 0, 0, 1),     // 5
        Vertex( 1, 1,-1,   0, 1, 0, 1),     // 6
        Vertex( 1,-1,-1,   0, 1, 0, 1)      // 7
        
    ]
    
    let indexList : [GLubyte] = [
        // Front
        0, 1, 2,
        2, 3, 0,
        
        // Back
        4, 5, 6,
        6, 7, 4,
        
        // Left
        3, 2, 5,
        5, 4, 3,
        
        // Right
        7, 6, 1,
        1, 0, 7,
        
        // Top
        1, 6, 5,
        5, 2, 1,
        
        // Bottom
        3, 4, 7,
        7, 0, 3
    ]
    
    init(shader: BaseEffect) {
        super.init(name: "cube", shader: shader, vertices: vertexList, indices: indexList)
    }
    
    override func updateWithDelta(_ dt: TimeInterval) {
        self.rotationZ = self.rotationZ + Float(Double.pi*dt)
        self.rotationY = self.rotationY + Float(Double.pi*dt)
    }

}

