
import GLKit

internal struct TriangleStripIndex {
  let a: GLuint
  let b: GLuint
  let c: GLuint
  let d: GLuint
  let e: GLuint
  let f: GLuint
}

extension TriangleStripIndex {
  internal init(_ a:GLuint = 0, _ b: GLuint = 0, _ c: GLuint = 0, _ d:GLuint = 0, _ e: GLuint = 0, _ f: GLuint = 0 ) {
    self.a = a
    self.b = b
    self.c = c
    self.d = d
    self.e = e
    self.f = f
  }

  internal var primitiveIndices: [GLuint] {
    return [self.a, self.b, self.c, self.d, self.e, self.f]
  }
}


internal class TriangleStripNode: Node {
  init(name: String,
       shaderProgram: ShaderProgram,
       vertices: [Vertex],
       indices: [TriangleStripIndex]) {

    let primitiveIndices = indices.flatMap{$0.primitiveIndices}

    super.init(name: name, shaderProgram: shaderProgram, vertices: vertices, indices: primitiveIndices)
  }

  override func drawContent() {
    glDrawElements(GLenum(GL_TRIANGLE_STRIP),
                   GLsizei(self.indices.count),
                   GLenum(GL_UNSIGNED_INT),
                   nil)
  }
}
