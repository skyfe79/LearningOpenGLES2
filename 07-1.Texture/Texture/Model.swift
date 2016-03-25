//
//  Model.swift
//  Model
//
//  Created by burt on 2016. 2. 27..
//  Copyright © 2016년 BurtK. All rights reserved.
//
//  VAO가 있어서 이렇게 정점 및 인덱스 데이터를 모델로 따로 분리할 수 있다.
//  모델 생성시나 렌더링 전 필요한 시기에 VAO를 만들고 정점 및 인덱스 데이터를 
//  CPU에서 GPU로 올리면 된다.
import GLKit

class Model {
    var shader: BaseEffect!
    var name: String!
    var vertices: [Vertex]!
    var vertexCount: GLuint! // 없어도 됨
    var indices: [GLubyte]!
    var indexCount: GLuint! // 없어도 됨
    
    var vao: GLuint = 0
    var vertexBuffer: GLuint = 0
    var indexBuffer: GLuint = 0
    var texture: GLuint = 0
    
    
    // ModelView Transformation
    var position : GLKVector3 = GLKVector3(v: (0.0, 0.0, 0.0))
    var rotationX : Float = 0.0
    var rotationY : Float = 0.0
    var rotationZ : Float = 0.0
    var scale : Float = 1.0
    
    init(name: String, shader: BaseEffect, vertices: [Vertex], indices: [GLubyte]) {
        self.name = name
        self.shader = shader
        self.vertices = vertices
        self.vertexCount = GLuint(vertices.count)
        self.indices = indices
        self.indexCount = GLuint(indices.count)
        
        glGenVertexArraysOES(1, &vao) // GPU에 VertexArrayObject를 생성해서 미리 정점과 인덱스를 CPU에서 GPU로 모두 복사한다
        glBindVertexArrayOES(vao)
        
        
        glGenBuffers(GLsizei(1), &vertexBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        let count = vertices.count
        let size =  sizeof(Vertex)
        glBufferData(GLenum(GL_ARRAY_BUFFER), count * size, vertices, GLenum(GL_STATIC_DRAW))
        
        glGenBuffers(GLsizei(1), &indexBuffer)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), indices.count * sizeof(GLubyte), indices, GLenum(GL_STATIC_DRAW))
        
        
        // 현재 vao가 바인딩 되어 있어서 아래 함수를 실행하면 정점과 인덱스 데이터가 모두 vao에 저장된다.
        glEnableVertexAttribArray(VertexAttributes.Position.rawValue)
        glVertexAttribPointer(
            VertexAttributes.Position.rawValue,
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(sizeof(Vertex)), BUFFER_OFFSET(0))
        
        
        glEnableVertexAttribArray(VertexAttributes.Color.rawValue)
        glVertexAttribPointer(
            VertexAttributes.Color.rawValue,
            4,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(sizeof(Vertex)), BUFFER_OFFSET(3 * sizeof(GLfloat))) // x, y, z | r, g, b, a :: offset is 3*sizeof(GLfloat)
        
        
        glEnableVertexAttribArray(VertexAttributes.TexCoord.rawValue)
        glVertexAttribPointer(
            VertexAttributes.TexCoord.rawValue,
            2,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(sizeof(Vertex)), BUFFER_OFFSET((3+4) * sizeof(GLfloat))) // x, y, z | r, g, b, a | u, v :: offset is (3+4)*sizeof(GLfloat)

        
        // 바인딩을 끈다
        glBindVertexArrayOES(0)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
    }
    
    func modelMatrix() -> GLKMatrix4 {
        var modelMatrix : GLKMatrix4 = GLKMatrix4Identity
        modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, self.position.z)
        modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationX, 1, 0, 0)
        modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationY, 0, 1, 0)
        modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationZ, 0, 0, 1)
        modelMatrix = GLKMatrix4Scale(modelMatrix, self.scale, self.scale, self.scale)
        return modelMatrix
    }
    
    func renderWithParentMoelViewMatrix(parentModelViewMatrix: GLKMatrix4) {
        
        let modelViewMatrix : GLKMatrix4 = GLKMatrix4Multiply(parentModelViewMatrix, modelMatrix())
        
        shader.modelViewMatrix = modelViewMatrix
        shader.texture = self.texture
        shader.prepareToDraw()
        
        glBindVertexArrayOES(vao)
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(indices.count), GLenum(GL_UNSIGNED_BYTE), nil)
        glBindVertexArrayOES(0)

    }
    
    func updateWithDelta(dt: NSTimeInterval) {
        
    }
    
    func loadTexture(filename: String) {
        
        let path = NSBundle.mainBundle().pathForResource(filename, ofType: nil)!
        let option = [ GLKTextureLoaderOriginBottomLeft: true]
        do {
            let info = try GLKTextureLoader.textureWithContentsOfFile(path, options: option)
            self.texture = info.name
        } catch {
            
        }
    }
    
    func BUFFER_OFFSET(n: Int) -> UnsafePointer<Void> {
        let ptr: UnsafePointer<Void> = nil
        return ptr + n
    }
}