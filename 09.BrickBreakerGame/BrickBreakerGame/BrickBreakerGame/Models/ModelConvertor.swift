//
//  Model.swift
//  OpenGLESLearning
//
//  Created by Pi on 08/09/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import Foundation
import GLKit
import PaversFRP

internal enum ModelError: Error {
  case invalidVertexStringFormat(String)
  case invalidTextureCoordinateStringFormat(String)
  case invalidNormalVectorStringFormat(String)
  case invalidTriangularFaceVertexStringFormat(String)
  case invalidTriangularFace3StringFormat(String)
  case invalidNumberStringFormat(String)
}

/// (x, y, z) in 3D coordinate system
internal struct Vertex3 {
  let x: Float
  let y: Float
  let z: Float
}

extension Vertex3 {
  internal init(_ x: Float = 0, _ y: Float = 0, _ z: Float = 0) {
    self.x = x
    self.y = y
    self.z = z
  }
}

extension Vertex3 {
  /// the format of line should be "v 1.000000 -1.000000 -1.000000"
  internal static func from(line: String) -> Result<Vertex3, ModelError> {
    let numbers = line.components(separatedBy: .whitespaces)
    if numbers.count != 4 && numbers[0] == "v" {
      return Result(error: .invalidVertexStringFormat(line))
    }
    guard let x = Float(numbers[1]), let y = Float(numbers[2]), let z = Float(numbers[3])
      else { return Result(error: .invalidNumberStringFormat(line)) }

    return Result(value: Vertex3(x, y, z))
  }
}

internal struct TextureCoordinate2 {
  let u: Float
  let v: Float
}

extension TextureCoordinate2 {
  internal init(_ u: Float = 0, _ v: Float = 0) {
    self.u = u
    self.v = v
  }
}

extension TextureCoordinate2 {
  /// the format of line should be "vt 0.375624 0.500625"
  internal static func from(line: String) -> Result<TextureCoordinate2, ModelError> {
    let numbers = line.components(separatedBy: .whitespaces)
    if numbers.count != 3 && numbers[0] == "vt" {
      return Result(error: .invalidTextureCoordinateStringFormat(line))
    }
    guard let u = Float(numbers[1]), let v = Float(numbers[2])
      else { return Result(error: .invalidNumberStringFormat(line)) }

    return Result(value: TextureCoordinate2(u, v))
  }
}


internal struct NormalVector3 {
  let x: Float
  let y: Float
  let z: Float
}

extension NormalVector3 {
  internal init(_ x: Float = 0, _ y: Float = 0, _ z: Float = 0) {
    self.x = x
    self.y = y
    self.z = z
  }
}

extension NormalVector3 {
  /// the format of line should be "vn 0.000000 -1.000000 0.000000"
  internal static func from(line: String) -> Result<NormalVector3, ModelError> {
    let numbers = line.components(separatedBy: .whitespaces)
    if numbers.count != 4 && numbers[0] == "vn" {
      return Result(error: .invalidNormalVectorStringFormat(line))
    }
    guard let x = Float(numbers[1]), let y = Float(numbers[2]), let z = Float(numbers[3])
      else { return Result(error: .invalidNumberStringFormat(line)) }

    return Result(value: NormalVector3(x, y, z))
  }
}

internal struct TriangularFaceVertex3 {
  let vertexIndex: Int
  let textureCoordinateIndex: Int
  let normalVectorIndex: Int
}
extension TriangularFaceVertex3 {
  internal init(_ v: Int = 0, _ t: Int = 0, _ nv: Int = 0) {
    self.vertexIndex = v
    self.textureCoordinateIndex = t
    self.normalVectorIndex = nv
  }
}

extension TriangularFaceVertex3 {
  /// the format of line should be "1/1/1" or "1//1"
  internal static func from(line: String) -> Result<TriangularFaceVertex3, ModelError> {

    let indice = line.components(separatedBy: "/")
    if indice.count != 3 {
      return Result(error: .invalidTriangularFaceVertexStringFormat(line))
    }
    let revisedIndice = indice.map{ $0.isEmpty ? "-1" : $0 }

    guard
      let v = Int(revisedIndice[0]),
      let t = Int(revisedIndice[1]),
      let nv = Int(revisedIndice[2])
      else { return Result(error: .invalidNumberStringFormat(line)) }

    return Result(value: TriangularFaceVertex3(v, t, nv))
  }
}


internal struct TriangularFace3 {
  let a: TriangularFaceVertex3
  let b: TriangularFaceVertex3
  let c: TriangularFaceVertex3

  var vertices: [TriangularFaceVertex3] { return [a, b, c] }
}

extension TriangularFace3 {
  internal init(_ a: TriangularFaceVertex3, _ b: TriangularFaceVertex3, _ c: TriangularFaceVertex3) {
    self.a = a
    self.b = b
    self.c = c
  }
}

extension TriangularFace3 {
  /// the format of line should be "f 1/1/1 2/2/1 3/3/1"
  internal static func from(line: String) -> Result<TriangularFace3, ModelError> {

    let lines = line.components(separatedBy: .whitespaces)
    if lines.count != 4 && lines[0] == "f" {
      return Result(error: .invalidTriangularFace3StringFormat(line))
    }

    let fs = lines[1...3]
      .map { (line) -> () -> Result<([TriangularFaceVertex3]), ModelError> in
        {  TriangularFaceVertex3.from(line: line).map{[$0]} }
    }

    let initial: () -> Result<([TriangularFaceVertex3]), ModelError> = { Result(value: [])}
    let chained = fs.reduce(initial, >>>)

    return chained().flatMap { (vertices) -> Result<TriangularFace3, ModelError> in
      if vertices.count == 3 {
        return Result(value:TriangularFace3(vertices[0], vertices[1], vertices[2]))
      } else {
        return Result(error: .invalidTriangularFace3StringFormat(line))
      }
    }
  }
}

/// return error when firstly encounter an error
fileprivate func >>> <A> (f: @escaping () -> Result<([A]), ModelError>,
          g: @escaping () -> Result<([A]), ModelError>)
  -> () -> Result<([A]), ModelError> {
    return { 
      f().flatMap { (org) -> Result<[A], ModelError> in
        g().map{ org + $0 }
      }
    }
}

/// iteratively compute all results to see if there is any error inside an array.
fileprivate func resultsInArray2ArrayInResult<V, E>(_ results: [Result<V, E>]) -> Result<[V], E> {
  return results.reduce(Result(value: [])) { (accumulator, element) in
    accumulator.flatMap{ vs in element.map{ vs + [$0] } }
  }
}


internal enum ModelConvertor {

  internal static func parseModel(content: String) -> Result<([Vertex], [GLuint]), ModelError> {
    let lines = content.components(separatedBy: .newlines)

    let vertexLines = lines.filter{ $0.hasPrefix("v ") }
    let textureCoordinateLines = lines.filter{ $0.hasPrefix("vt ") }
    let normalVectorLines = lines.filter{ $0.hasPrefix("vn ") }
    let triangularFaceLines = lines.filter{ $0.hasPrefix("f ") }


    let vertexResult = resultsInArray2ArrayInResult(vertexLines.map(Vertex3.from))
    let textureCoordinateResult = resultsInArray2ArrayInResult(textureCoordinateLines.map(TextureCoordinate2.from))
    let normalVectorsResult = resultsInArray2ArrayInResult(normalVectorLines.map(NormalVector3.from))
    let triangularFaceResult = resultsInArray2ArrayInResult(triangularFaceLines.map(TriangularFace3.from))

    guard let vertices = vertexResult.value else { return Result(error: vertexResult.error!) }
    guard let textureCoordinates = textureCoordinateResult.value else { return Result(error: textureCoordinateResult.error!) }
    guard let normalVectors = normalVectorsResult.value else { return Result(error: normalVectorsResult.error!) }
    guard let triangularFace = triangularFaceResult.value else { return Result(error: triangularFaceResult.error!) }

    // generate an array of Vertex
    let triangularFaceVertices = triangularFace.flatMap{ $0.vertices }
    let returnedVertices = triangularFaceVertices.map { (triangularFaceVertex) -> Vertex in
      let position = vertices[triangularFaceVertex.vertexIndex - 1]
      let uv = triangularFaceVertex.textureCoordinateIndex > -1
        ? textureCoordinates[triangularFaceVertex.textureCoordinateIndex - 1]
        : TextureCoordinate2()
      let nv = normalVectors[triangularFaceVertex.normalVectorIndex - 1]

      return Vertex(position, uv, nv)
    }

    let indice = (0 ..< returnedVertices.count).map{GLuint($0)}

    return Result(value: (returnedVertices, indice))
  }
}

fileprivate extension Vertex {
  init(_ position: Vertex3, _ uv: TextureCoordinate2, _ nv: NormalVector3 ) {
    self = Vertex(position.x,
           position.y,
           position.z,
           0,
           0,
           0,
           1,
           uv.u,
           uv.v,
           nv.x,
           nv.y,
           nv.z)
  }
}

