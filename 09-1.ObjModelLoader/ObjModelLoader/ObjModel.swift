//
//  ObjModel.swift
//  ObjModelLoader
//
//  Created by Michael Rommel on 30.08.17.
//  Copyright © 2017 BurtK. All rights reserved.
//

import Foundation
import GLKit

class ObjModel: Model {
    
    init(name: String, shape: Shape, shader: BaseEffect) {
        
        var vertices: [Vertex] = []
        var indices: [GLuint] = []
        var index: GLuint = 0
        
        //assert(shape.vertices.count == shape.normals.count && shape.normals.count == shape.textureCoords.count, "wrong number of vertices, normals and texture coords")
        
        for vertexIndexes in shape.faces {
            for vertexIndex in vertexIndexes {
                // Will cause an out of bounds error
                // if vIndex, nIndex or tIndex is not normalized
                // to be local to the internal data of the shape
                // instead of global to the file as per the
                // .obj specification
                let (vertexVector, normalVector, textureVector) = shape.dataForVertexIndex(vertexIndex)
                
                var v = Vertex()
                if let vertexVector = vertexVector {
                    v.x = GLfloat(vertexVector[0])
                    v.y = GLfloat(vertexVector[1])
                    v.z = GLfloat(vertexVector[2])
                }
                
                if let normalVector = normalVector {
                    v.nx = GLfloat(normalVector[0])
                    v.ny = GLfloat(normalVector[1])
                    v.nz = GLfloat(normalVector[2])
                }
                
                if let textureVector = textureVector {
                    v.u = GLfloat(textureVector[0])
                    v.v = GLfloat(textureVector[1])
                }
                
                vertices.append(v)
                
                indices.append(index)
                index = index + 1
            }
        }
        
        super.init(name: name, shader: shader, vertices: vertices, indices: indices)
        self.loadTexture((shape.material?.diffuseTextureMapFilePath?.lastPathComponent)! as String)
    }
    
    override func updateWithDelta(_ dt: TimeInterval) {
        self.rotationY = self.rotationY + Float(Double.pi * dt / 8)
    }
}
