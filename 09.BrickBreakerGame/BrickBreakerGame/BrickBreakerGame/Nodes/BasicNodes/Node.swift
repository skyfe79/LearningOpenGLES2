//
//  Model.swift
//  OpenGLESLearning
//
//  Created by Pi on 05/09/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import GLKit
import UIKit
import PaversFRP

internal class Node {
  // ModelView Transformation

  internal weak var parent: Node?

  internal var position : GLKVector3 = GLKVector3(v: (0.0, 0.0, 0.0))

  internal var rotationX : Float = 0.0
  internal var rotationY : Float = 0.0
  internal var rotationZ : Float = 0.0

  internal var scaleX : Float = 1.0 { didSet{self.computeWidth()} }
  internal var scaleY : Float = 1.0 { didSet{self.computeHeight()} }
  internal var scaleZ : Float = 1.0 { didSet{self.computeDepth()} }

  internal var scale: Float = 1.0  { didSet{self.computeVolumn()} }


  internal let shaderProgram: ShaderProgram
  internal let name: String
  internal let vertices: [Vertex]
  internal let indices: [GLuint]

  fileprivate var vao: GLuint = 0
  fileprivate var vertexBuffer: GLuint = 0
  fileprivate var indexBuffer: GLuint = 0
  fileprivate var texture: GLuint = 0

  internal var matColor: GLKVector4 = GLKVector4Make(1, 1, 1, 1)

  fileprivate var _children = [Node]()

  fileprivate var _width: Float = 0
  fileprivate var _height: Float = 0
  fileprivate var _depth: Float = 0

  internal init(name: String,
       shaderProgram: ShaderProgram,
       vertices: [Vertex] = [],
       indices: [GLuint] = []) {

    self.name = name
    self.shaderProgram = shaderProgram
    self.vertices = vertices
    self.indices = indices

    self.setupVertexBuffer()
    self.computeVolumn()
  }



  deinit {
    glDeleteTextures(1, &self.texture);
    glDeleteBuffers(1, &self.vertexBuffer)
    glDeleteBuffers(1, &self.indexBuffer)
    glDeleteVertexArraysOES(1, &self.vao);
  }


  // MARK: - Drawing

  internal func render(with parentModelViewMatrix: GLKMatrix4) {
    let m = GLKMatrix4Multiply(parentModelViewMatrix, self.modelMatrix)

    for child in self._children { child.render(with: m) }

    self.shaderProgram.modelViewMatrix = m
    self.shaderProgram.texture = self.texture
    self.shaderProgram.matColor = self.matColor
    self.shaderProgram.prepareToDraw()

    glBindVertexArrayOES(self.vao)

    self.drawContent()

    glBindVertexArrayOES(0)
  }

  internal func drawContent() {}


  internal func updateWithDelta(_ dt: TimeInterval) {
    for child in self._children {
      child.updateWithDelta(dt)
    }
  }


  // MARK: - Reactive
  internal func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {}

  internal func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}

  internal func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}

  internal func boundingBoxWithModelViewMatrix(parenetModelViewMatrix: GLKMatrix4) -> CGRect {
    let modelViewMatrix = GLKMatrix4Multiply(parenetModelViewMatrix, self.modelMatrix)

    let preLowerLeft = GLKVector4Make(-self.width / 2, -self.height / 2, 0, 1)
    let lowerLeft = GLKMatrix4MultiplyVector4(modelViewMatrix, preLowerLeft)

    let preUpperRight = GLKVector4Make(self.width / 2, self.height / 2, 0, 1)
    let upperRight = GLKMatrix4MultiplyVector4(modelViewMatrix, preUpperRight)

    let boundingBox = CGRect(CGFloat(lowerLeft.x),
                             CGFloat(lowerLeft.y),
                             CGFloat(upperRight.x - lowerLeft.x),
                             CGFloat(upperRight.y - lowerLeft.y))
    return boundingBox
  }
}

// MARK: - Matrix: Mode -> World
extension Node {
  internal var modelMatrix: GLKMatrix4 {
    var modelMatrix : GLKMatrix4 = GLKMatrix4Identity
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, self.position.z)
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationX, 1, 0, 0)
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationY, 0, 1, 0)
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationZ, 0, 0, 1)
    modelMatrix = GLKMatrix4Scale(modelMatrix, self.scaleX * self.scale, self.scaleY * self.scale, self.scaleZ * self.scale)
    return modelMatrix
  }
}


// MARK: - Sizing
extension Node {
  internal var width: Float {return self._width}
  internal var height: Float {return self._height}
  internal var depth: Float {return self._depth}

  fileprivate func computeWidth() {
    let xs = self.vertices.map{ $0.x }
    let minX = xs.min() ?? 0
    let maxX = xs.max() ?? 0
    self._width = (maxX - minX) * self.scaleX * self.scale
  }

  fileprivate func computeHeight() {
    let ys = self.vertices.map{ $0.y }
    let minY = ys.min() ?? 0
    let maxY = ys.max() ?? 0
    self._height = maxY - minY * self.scaleY * self.scale
  }

  fileprivate func computeDepth() {
    let zs = self.vertices.map{ $0.z }
    let minZ = zs.min() ?? 0
    let maxZ = zs.max() ?? 0
    self._depth = maxZ - minZ * self.scaleZ * self.scale
  }

  fileprivate func computeVolumn() {
    self.computeWidth()
    self.computeHeight()
    self.computeDepth()
  }
}

// MARK: - Children Management
extension Node {
  internal var children: [Node] {return self._children}

  internal func add(child: Node) {
    child.parent = self
    self._children.append(child)
  }

  internal func remove(child: Node) {
    if let idx = self._children.index(where: {$0 === child}) {
      child.parent = nil
      self._children.remove(at: idx)
    }
  }

  internal func removeAllChildren() {
    self._children.removeAll()
  }
}

// MARK: - Data Buffer and texture
extension Node {
  internal func loadTexture(_ filename: String) -> Result<(), TriangleNodeError> {
    guard let path = Bundle.main.path(forResource: filename, ofType: nil) else {
      return Result(error: .textureFileNotFound(filename: filename))
    }
    let option: [String : NSNumber] = [ GLKTextureLoaderOriginBottomLeft: true]
    do {
      let info = try GLKTextureLoader.texture(withContentsOfFile: path, options: option)
      self.texture = info.name
    } catch {
      return Result(error: .textureLoadFailed(filePath:path, error:error))
    }
    return Result(value: ())
  }

  fileprivate func BUFFER_OFFSET(_ n: Int) -> UnsafeRawPointer? {
    return UnsafeRawPointer(bitPattern: n)
  }


  fileprivate func setupVertexBuffer() {

    // generate and bind vertex array object
    glGenVertexArraysOES(1, &self.vao)
    glBindVertexArrayOES(self.vao)

    // generate, bind and buffer vertex array buffer object
    glGenBuffers(GLsizei(1), &self.vertexBuffer)
    glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.vertexBuffer)
    glBufferData(GLenum(GL_ARRAY_BUFFER),
                 self.vertices.memorySize,
                 self.vertices,
                 GLenum(GL_STATIC_DRAW))

    // generate, bind and buffer vertex index array buffer object
    glGenBuffers(GLsizei(1), &self.indexBuffer)
    glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), self.indexBuffer)
    glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER),
                 self.indices.memorySize,
                 self.indices,
                 GLenum(GL_STATIC_DRAW))


    // enable vertex attributes
    glEnableVertexAttribArray(VertexAttributes.position.rawValue)
    glVertexAttribPointer(
      VertexAttributes.position.rawValue,
      3,
      GLenum(GL_FLOAT),
      GLboolean(GL_FALSE),
      GLsizei(MemoryLayout<Vertex>.size), BUFFER_OFFSET(0))


    glEnableVertexAttribArray(VertexAttributes.color.rawValue)
    glVertexAttribPointer(
      VertexAttributes.color.rawValue,
      4,
      GLenum(GL_FLOAT),
      GLboolean(GL_FALSE),
      GLsizei(MemoryLayout<Vertex>.size), BUFFER_OFFSET(3 * MemoryLayout<GLfloat>.size))
    // x, y, z | r, g, b, a :: offset is 3*sizeof(GLfloat)

    glEnableVertexAttribArray(VertexAttributes.texCoord.rawValue)
    glVertexAttribPointer(
      VertexAttributes.texCoord.rawValue,
      2,
      GLenum(GL_FLOAT),
      GLboolean(GL_FALSE),
      GLsizei(MemoryLayout<Vertex>.size), BUFFER_OFFSET((3+4) * MemoryLayout<GLfloat>.size))

    glEnableVertexAttribArray(VertexAttributes.normal.rawValue)
    glVertexAttribPointer(
      VertexAttributes.normal.rawValue,
      3,
      GLenum(GL_FLOAT),
      GLboolean(GL_FALSE),
      GLsizei(MemoryLayout<Vertex>.size), BUFFER_OFFSET((3+4+2) * MemoryLayout<GLfloat>.size)) // x, y, z | r, g, b, a | u, v | nx, ny, nz :: offset is (3+4+2)*sizeof(GLfloat)

    glBindVertexArrayOES(0)
    glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
    glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
  }

}




















