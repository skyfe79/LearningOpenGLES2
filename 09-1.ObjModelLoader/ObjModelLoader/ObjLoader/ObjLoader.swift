//
//  ObjLoader.swift
//  SwiftObjLoader
//
//  Created by Hugo Tunius on 02/09/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

enum ObjLoadingError: Error {
    case unexpectedFileFormat(error: String)
}

extension String {
    func appendingPathComponent(_ string: String) -> String {
        return URL(fileURLWithPath: self).appendingPathComponent(string).path
    }
}

public final class ObjLoader {
    // Represent the state of parsing
    // at any point in time
    class State {
        var objectName: NSString?
        var vertices: [Vector] = []
        var normals: [Vector] = []
        var textureCoords: [Vector] = []
        var faces: [[VertexIndex]] = []
        var material: Material?
    }

    // Source markers
    fileprivate static let commentMarker = "#".characters.first
    fileprivate static let vertexMarker = "v".characters.first
    fileprivate static let normalMarker = "vn"
    fileprivate static let textureCoordMarker = "vt"
    fileprivate static let objectMarker = "o".characters.first
    fileprivate static let groupMarker = "g".characters.first
    fileprivate static let faceMarker = "f".characters.first
    fileprivate static let materialLibraryMarker = "mtllib"
    fileprivate static let useMaterialMarker = "usemtl"

    fileprivate let scanner: ObjScanner
    fileprivate let basePath: String
    fileprivate var materialCache: [NSString: Material] = [:]

    fileprivate var state = State()
    fileprivate var vertexCount = 0
    fileprivate var normalCount = 0
    fileprivate var textureCoordCount = 0

    // Init an objloader with the
    // source of the .obj file as a string
    //
    public init(source: String, basePath: String) {
        scanner = ObjScanner(source: source)
        self.basePath = basePath
    }

    // Read the specified source.
    // This operation is singled threaded and
    // should not be invoked again before
    // the call has returned
    public func read() throws -> [Shape] {
        var shapes: [Shape] = []

        resetState()

        do {
            while scanner.dataAvailable {
                let marker = scanner.readMarker()

                guard let m = marker, m.length > 0 else {
                    scanner.moveToNextLine()
                    continue
                }
                
                let markerString = m as String

                if ObjLoader.isComment(markerString) {
                    scanner.moveToNextLine()
                    continue
                }

                if ObjLoader.isVertex(markerString) {
                    if let v = try readVertex() {
                        state.vertices.append(v)
                    }

                    scanner.moveToNextLine()
                    continue
                }

                if ObjLoader.isNormal(markerString) {
                    if let n = try readVertex() {
                        state.normals.append(n)
                    }

                    scanner.moveToNextLine()
                    continue
                }

                if ObjLoader.isTextureCoord(markerString) {
                    if let vt = scanner.readTextureCoord() {
                        state.textureCoords.append(vt)
                    }

                    scanner.moveToNextLine()
                    continue
                }

                if ObjLoader.isObject(markerString) {
                    if let s = buildShape() {
                        shapes.append(s)
                    }

                    state = State()
                    state.objectName = scanner.readLine()
                    scanner.moveToNextLine()
                    continue
                }

                if ObjLoader.isGroup(markerString) {
                    if let s = buildShape() {
                        shapes.append(s)
                    }

                    state = State()
                    state.objectName = try scanner.readString()
                    scanner.moveToNextLine()
                    continue
                }

                if ObjLoader.isFace(markerString) {
                    if let indices = try scanner.readFace() {
                        state.faces.append(normalizeVertexIndices(indices))
                    }

                    scanner.moveToNextLine()
                    continue
                }

                if ObjLoader.isMaterialLibrary(markerString) {
                    let filenames = try scanner.readTokens()
                    try parseMaterialFiles(filenames)
                    scanner.moveToNextLine()
                    continue
                }

                if ObjLoader.isUseMaterial(markerString) {
                    let materialName = try scanner.readString()

                    guard let material = self.materialCache[materialName] else {
                        throw ObjLoadingError.unexpectedFileFormat(error: "Material \(materialName) referenced before it was definied")
                    }

                    state.material = material
                    scanner.moveToNextLine()
                    continue
                }

                scanner.moveToNextLine()
            }

            if let s = buildShape() {
                shapes.append(s)
            }
            state = State()
        } catch let e {
            resetState()
            throw e
        }
        return shapes
    }

    fileprivate static func isComment(_ marker: String) -> Bool {
        return marker.characters.first == commentMarker
    }

    fileprivate static func isVertex(_ marker: String) -> Bool {
        return marker.characters.count == 1 && marker.characters.first == vertexMarker
    }

    fileprivate static func isNormal(_ marker: String) -> Bool {
        return marker.characters.count == 2 && marker == normalMarker
        //return marker.characters.count == 2 && marker.substring(to: marker.index(from: 2)) == normalMarker
        //return true
    }

    fileprivate static func isTextureCoord(_ marker: String) -> Bool {
        return marker.characters.count == 2 && marker == textureCoordMarker
        //return marker.characters.count == 2 && marker.substring(to: marker.index(from: 2)) == textureCoordMarker
        //return true
    }

    fileprivate static func isObject(_ marker: String) -> Bool {
        return marker.characters.count == 1 && marker.characters.first == objectMarker
    }

    fileprivate static func isGroup(_ marker: String) -> Bool {
        return marker.characters.count == 1 && marker.characters.first == groupMarker
    }

    fileprivate static func isFace(_ marker: String) -> Bool {
        return marker.characters.count == 1 && marker.characters.first == faceMarker
    }

    fileprivate static func isMaterialLibrary(_ marker: String) -> Bool {
        return marker  == materialLibraryMarker
    }

    fileprivate static func isUseMaterial(_ marker: String) -> Bool {
        return marker == useMaterialMarker
    }

    fileprivate func readVertex() throws -> [Double]? {
        do {
            return try scanner.readVertex()
        } catch ScannerErrors.unreadableData(let error) {
            throw ObjLoadingError.unexpectedFileFormat(error: error)
        }
    }

    fileprivate func resetState() {
        scanner.reset()
        state = State()
        vertexCount = 0
        normalCount = 0
        textureCoordCount = 0
    }

    fileprivate func buildShape() -> Shape? {
        if state.vertices.count == 0 && state.normals.count == 0 && state.textureCoords.count == 0 {
            return nil
        }


        let result =  Shape(name: (state.objectName as String?), vertices: state.vertices, normals: state.normals, textureCoords: state.textureCoords, material: state.material, faces: state.faces)
        vertexCount += state.vertices.count
        normalCount += state.normals.count
        textureCoordCount += state.textureCoords.count

        return result
    }

    fileprivate func normalizeVertexIndices(_ unnormalizedIndices: [VertexIndex]) -> [VertexIndex] {
        return unnormalizedIndices.map {
            return VertexIndex(vIndex: ObjLoader.normalizeIndex($0.vIndex, count: vertexCount),
                nIndex: ObjLoader.normalizeIndex($0.nIndex, count: normalCount),
                tIndex: ObjLoader.normalizeIndex($0.tIndex, count: textureCoordCount))
        }
    }

    fileprivate func parseMaterialFiles(_ filenames: [NSString]) throws {
        for filename in filenames {
            let fullPath = basePath.appendingPathComponent(filename as String)
            do {
                let fileContents = try NSString(contentsOfFile: fullPath,
                                        encoding: String.Encoding.utf8.rawValue)
                let loader = MaterialLoader(source: fileContents as String,
                                            basePath: basePath)

                let materials = try loader.read()

                for material in materials {
                    materialCache[material.name] = material
                }

            } catch MaterialLoadingError.unexpectedFileFormat(let msg) {
                throw ObjLoadingError.unexpectedFileFormat(error: msg)
            } catch {
                throw ObjLoadingError.unexpectedFileFormat(error: "Invalid material file at \(fullPath)")
            }
        }
    }

    fileprivate static func normalizeIndex(_ index: Int?, count: Int) -> Int? {
        guard let i = index else {
            return nil
        }

        if i == 0 {
            return 0
        }

        return i - count - 1
    }
}
