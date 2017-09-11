
import GLKit
import PaversFRP

internal enum TriangleNodeError: Error {
  case objectFileNotFound(filename: String)
  case textureFileNotFound(filename: String)
  case textureLoadFailed(filePath:String, error:Error)
  case fileContentCannotRead(filePath: String, error: Error)
  case modelConversionFailed(ModelError)
}


internal class TriangleNode: Node {

  var rotated: Bool = false

  init(name: String, shader: ShaderProgram, vertices: [Vertex], indices: [GLuint]) {
    super.init(name: name, shaderProgram: shader, vertices: vertices, indices: indices)
  }

  override func drawContent() {
    glDrawElements(GLenum(GL_TRIANGLES), GLsizei(indices.count), GLenum(GL_UNSIGNED_INT), nil)
  }

  override func updateWithDelta(_ dt: TimeInterval) {
//    if rotated {
//      self.rotationZ += Float(Double.pi*dt/2)
////      self.rotationY += Float(Double.pi*dt/8)
//    }
  }
}

extension TriangleNode {

  internal static func node(of model: ModelList, with sp: ShaderProgram) -> Result<TriangleNode, TriangleNodeError> {
    let name = model.rawValue
    return TriangleNode.node(named: name, with: sp)
  }

  internal static func node(named name: String, with sp: ShaderProgram) -> Result<TriangleNode, TriangleNodeError> {
    let objectFile = name + ".obj"
    let textureFile = name + ".png"
    return TriangleNode.node(name: name, objectFile: objectFile, textureFile: textureFile, with: sp)
  }

  internal static func node(name: String,
                            objectFile: String,
                            textureFile: String?,
                            with sp: ShaderProgram)
    -> Result<TriangleNode, TriangleNodeError> {
    guard let path = Bundle.main.path(forResource: objectFile, ofType: nil) else {
      return Result(error: .objectFileNotFound(filename: objectFile))
    }
    let content: String
    do {
      content = try String(contentsOfFile: path)
    } catch {
      return Result(error: .fileContentCannotRead(filePath: path, error: error))
    }

    let r = ModelConvertor.parseModel(content: content)
    guard let (vertices, indices) = r.value else {
      return Result(error: .modelConversionFailed(r.error!))
    }

    let node = TriangleNode(name: name, shader: sp, vertices: vertices, indices: indices)

    if let textureFileName = textureFile {
      let rst = node.loadTexture(textureFileName)
      if let e = rst.error {
        return Result(error: e)
      }
    }
    return Result(value: node)
  }
}





















