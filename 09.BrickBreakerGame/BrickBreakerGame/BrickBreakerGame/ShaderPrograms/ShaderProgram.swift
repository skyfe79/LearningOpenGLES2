//
//  GLShaderProgram.swift
//  Triangle
//
//  Created by burt on 2016. 2. 25..
//  Copyright © 2016년 BurtK. All rights reserved.
//

import Foundation
import GLKit
import PaversFRP

internal enum VertexAttributes : GLuint {
  case position = 0
  case color = 1
  case texCoord = 2
  case normal = 3
}

internal final class ShaderProgram {
  fileprivate let programHandle : GLuint
  fileprivate let vertexShaderName: GLuint
  fileprivate let fragmentShaderName: GLuint

  fileprivate let modelViewMatrixUniform: GLint
  fileprivate let projectionMatrixUniform: GLint

  fileprivate let textureUniform : Int32

  fileprivate let lightColorUniform : Int32
  fileprivate let lightAmbientIntensityUniform : Int32

  fileprivate let lightDiffuseIntensityUniform : Int32
  fileprivate let lightDirectionUniform : Int32

  fileprivate let lightSpecularIntensityUniform : Int32
  fileprivate let lightShininessUniform : Int32

  fileprivate let matColorUniform : Int32

  var modelViewMatrix: GLKMatrix4 = GLKMatrix4Identity
  var projectionMatrix: GLKMatrix4 = GLKMatrix4Identity
  var matColor: GLKVector4 = GLKVector4Make(0, 0, 0, 0)

  var texture: GLuint = 0

  fileprivate init(_ parameters: (programHandle: GLuint, vertexShaderName: GLuint, fragmentShaderName: GLuint)) {
    self.programHandle = parameters.programHandle
    self.vertexShaderName = parameters.vertexShaderName
    self.fragmentShaderName = parameters.fragmentShaderName

    self.modelViewMatrixUniform = glGetUniformLocation(programHandle, "u_ModelViewMatrix")
    self.projectionMatrixUniform = glGetUniformLocation(programHandle, "u_ProjectionMatrix")

    self.textureUniform = glGetUniformLocation(self.programHandle, "u_Texture")

    self.lightColorUniform = glGetUniformLocation(self.programHandle, "u_Light.Color")
    self.lightAmbientIntensityUniform = glGetUniformLocation(self.programHandle, "u_Light.AmbientIntensity")

    self.lightDiffuseIntensityUniform = glGetUniformLocation(self.programHandle, "u_Light.DiffuseIntensity")
    self.lightDirectionUniform = glGetUniformLocation(self.programHandle, "u_Light.Direction")

    self.lightSpecularIntensityUniform = glGetUniformLocation(self.programHandle, "u_Light.SpecularIntensity")
    self.lightShininessUniform = glGetUniformLocation(self.programHandle, "u_Light.Shininess")
    self.matColorUniform = glGetUniformLocation(self.programHandle, "u_MatColor")
  }

  func prepareToDraw() {
    glUseProgram(self.programHandle)
    glUniformMatrix4fv(self.modelViewMatrixUniform, 1, 0, self.modelViewMatrix.array)
    glUniformMatrix4fv(self.projectionMatrixUniform, 1, 0, self.projectionMatrix.array)

    glActiveTexture(GLenum(GL_TEXTURE1))
    glBindTexture(GLenum(GL_TEXTURE_2D), self.texture)
    glUniform1i(self.textureUniform, 1)

    glUniform3f(self.lightColorUniform, 1, 1, 1)
    glUniform1f(self.lightAmbientIntensityUniform, 0.3)

    let lightDirection : GLKVector3 = GLKVector3(v: (0, 1, -1))
    glUniform3f(self.lightDirectionUniform, lightDirection.x, lightDirection.y, lightDirection.z)
    glUniform1f(self.lightDiffuseIntensityUniform, 0.7)

    glUniform1f(self.lightSpecularIntensityUniform, 0.5)
    glUniform1f(self.lightShininessUniform, 1)

    glUniform4f(self.matColorUniform, self.matColor.r, self.matColor.g, self.matColor.b, self.matColor.a)
  }

  deinit {
    glDeleteProgram(self.programHandle)
    glDeleteShader(self.vertexShaderName)
    glDeleteShader(self.fragmentShaderName)
  }
}

extension ShaderProgram {
  internal static func program(vertexShaderFile: String, fragmentShaderFile: String)
    -> Result<ShaderProgram, ShaderError> {
      return ShaderProgram.compile(vertexShader: vertexShaderFile, fragmentShader: fragmentShaderFile)
        .map { ShaderProgram($0) }
  }
}

extension ShaderProgram {
  fileprivate static func compileShader(_ shaderName: String, shaderType: GLenum) -> Result<GLuint, ShaderError> {
    guard let path = Bundle.main.path(forResource: shaderName, ofType: nil) else {
      return Result(error: ShaderError.shaderFileNotFound(filename: shaderName))
    }

    do {
      let shaderString = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
      let shaderHandle = glCreateShader(shaderType)
      var shaderStringLength : GLint = GLint(Int32(shaderString.length))
      var shaderCString = shaderString.utf8String
      glShaderSource(
        shaderHandle,
        GLsizei(1),
        &shaderCString,
        &shaderStringLength)

      glCompileShader(shaderHandle)
      var compileStatus : GLint = 0
      glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &compileStatus)

      if compileStatus == GL_FALSE {
        var infoLength : GLsizei = 0
        let bufferLength : GLsizei = 1024
        glGetShaderiv(shaderHandle, GLenum(GL_INFO_LOG_LENGTH), &infoLength)

        let info : [GLchar] = Array(repeating: GLchar(0), count: Int(bufferLength))
        var actualLength : GLsizei = 0

        glGetShaderInfoLog(shaderHandle, bufferLength, &actualLength, UnsafeMutablePointer(mutating: info))
        let infoStr = String(validatingUTF8: info) ?? ""
        return Result(error: ShaderError.shaderFailedToCreate(info: infoStr))
      }

      return Result.init(value: shaderHandle)

    } catch {
      let e = ShaderError.fileContentCannotRead(filepath: path, error: error)
      return Result(error:e)
    }
  }

  fileprivate static func compile(vertexShader: String, fragmentShader: String) -> Result<(GLuint, GLuint, GLuint), ShaderError> {

    return ShaderProgram.compileShader(vertexShader, shaderType: GLenum(GL_VERTEX_SHADER))
      .flatMap { (vertexShaderName) -> Result<(vertexShaderName:GLuint, fragmentShaderName:GLuint), ShaderError> in
        ShaderProgram.compileShader(fragmentShader, shaderType: GLenum(GL_FRAGMENT_SHADER)).map{(vertexShaderName, $0)}}
      .flatMap { (vertexShaderName: GLuint, fragmentShaderName: GLuint) -> Result<(GLuint, GLuint, GLuint), ShaderError> in
        let programHandle = glCreateProgram()
        glAttachShader(programHandle, vertexShaderName)
        glAttachShader(programHandle, fragmentShaderName)

        glBindAttribLocation(programHandle, VertexAttributes.position.rawValue, "a_Position")
        glBindAttribLocation(programHandle, VertexAttributes.color.rawValue, "a_Color")
        glBindAttribLocation(programHandle, VertexAttributes.texCoord.rawValue, "a_TexCoord")
        glBindAttribLocation(programHandle, VertexAttributes.normal.rawValue, "a_Normal")
        glLinkProgram(programHandle)

        var linkStatus : GLint = 0
        glGetProgramiv(programHandle, GLenum(GL_LINK_STATUS), &linkStatus)
        if linkStatus == GL_FALSE {
          var infoLength : GLsizei = 0
          let bufferLength : GLsizei = 1024
          glGetProgramiv(programHandle, GLenum(GL_INFO_LOG_LENGTH), &infoLength)

          let info : [GLchar] = Array(repeating: GLchar(0), count: Int(bufferLength))
          var actualLength : GLsizei = 0

          glGetProgramInfoLog(programHandle, bufferLength, &actualLength, UnsafeMutablePointer(mutating: info))
          let infoStr = String(validatingUTF8: info) ?? ""
          return Result(error: ShaderError.shaderProgramFailedToCreate(info: infoStr))
        } else {
          return Result(value: (programHandle, vertexShaderName, fragmentShaderName))
        }
    }
  }
}
