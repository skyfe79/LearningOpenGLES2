//
//  MaterialLoader.swift
//  SwiftObjLoader
//
//  Created by Hugo Tunius on 04/10/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

public enum MaterialLoadingError: Error {
    case unexpectedFileFormat(error: String)
}

public final class MaterialLoader {

    // Represent the state of parsing
    // at any point in time
    struct State {
        var materialName: String?
        var ambientColor: Color?
        var diffuseColor: Color?
        var specularColor: Color?
        var specularExponent: Double?
        var illuminationModel: IlluminationModel?
        var ambientTextureMapFilePath: NSString?
        var diffuseTextureMapFilePath: NSString?

        func isDirty() -> Bool {
            if materialName != nil {
                return true
            }

            if ambientColor != nil {
                return true
            }

            if diffuseColor != nil {
                return true
            }

            if specularColor != nil {
                return true
            }

            if specularExponent != nil {
                return true
            }

            if illuminationModel != nil {
                return true
            }

            if ambientTextureMapFilePath != nil {
                return true
            }

            if diffuseTextureMapFilePath != nil {
                return true
            }

            return false
        }
    }

    // Source markers
    fileprivate static let newMaterialMarker       = "newmtl"
    fileprivate static let ambientColorMarker      = "Ka"
    fileprivate static let diffuseColorMarker      = "Kd"
    fileprivate static let specularColorMarker     = "Ks"
    fileprivate static let specularExponentMarker  = "Ns"
    fileprivate static let illuminationModeMarker  = "illum"
    fileprivate static let ambientTextureMapMarker = "map_Ka"
    fileprivate static let diffuseTextureMapMarker = "map_Kd"

    fileprivate let scanner: MaterialScanner
    fileprivate let basePath: String
    fileprivate var state: State

    // Init an MaterialLoader with the
    // source of the .mtl file as a string
    //
    init(source: String, basePath: String) {
        self.basePath = basePath
        scanner = MaterialScanner(source: source)
        state = State()
    }

    // Read the specified source.
    // This operation is singled threaded and
    // should not be invoked again before
    // the call has returned
    func read() throws -> [Material] {
        resetState()
        var materials: [Material] = []

        do {
            while scanner.dataAvailable {
                let marker = scanner.readMarker()

                guard let m = marker, m.length > 0 else {
                    scanner.moveToNextLine()
                    continue
                }

                if MaterialLoader.isAmbientColor(m) {
                    let color = try readColor()
                    state.ambientColor = color

                    scanner.moveToNextLine()
                    continue
                }

                if MaterialLoader.isDiffuseColor(m) {
                    let color = try readColor()
                    state.diffuseColor = color

                    scanner.moveToNextLine()
                    continue
                }

                if MaterialLoader.isSpecularColor(m) {
                    let color = try readColor()
                    state.specularColor = color

                    scanner.moveToNextLine()
                    continue
                }

                if MaterialLoader.isSpecularExponent(m) {
                    let specularExponent = try readSpecularExponent()

                    state.specularExponent = specularExponent

                    scanner.moveToNextLine()
                    continue
                }

                if MaterialLoader.isIlluminationMode(m) {
                    let model = try readIlluminationModel()
                    state.illuminationModel = model

                    scanner.moveToNextLine()
                    continue
                }

                if MaterialLoader.isAmbientTextureMap(m) {
                    let mapFilename = try readFilename()
                    state.ambientTextureMapFilePath = basePath.appendingPathComponent(mapFilename as String) as NSString

                    scanner.moveToNextLine()
                    continue
                }

                if MaterialLoader.isDiffuseTextureMap(m) {
                    let mapFilename = try readFilename()
                    state.diffuseTextureMapFilePath = basePath.appendingPathComponent(mapFilename as String) as NSString

                    scanner.moveToNextLine()
                    continue
                }

                if MaterialLoader.isNewMaterial(m) {
                    if let material = try buildMaterial() {
                        materials.append(material)
                    }

                    state = State()
                    state.materialName = scanner.readLine() as! String
                    scanner.moveToNextLine()
                    continue
                }
                scanner.readLine()
                scanner.moveToNextLine()
                continue
            }

            if let material = try buildMaterial() {
                materials.append(material)
            }

            state = State()
        }

        return materials
    }

    fileprivate func resetState() {
        scanner.reset()
        state = State()
    }

    fileprivate static func isNewMaterial(_ marker: NSString) -> Bool {
        return marker as String == newMaterialMarker
    }

    fileprivate static func isAmbientColor(_ marker: NSString) -> Bool {
        return marker as String == ambientColorMarker
    }

    fileprivate static func isDiffuseColor(_ marker: NSString) -> Bool {
        return marker as String == diffuseColorMarker
    }

    fileprivate static func isSpecularColor(_ marker: NSString) -> Bool {
        return marker as String == specularColorMarker
    }

    fileprivate static func isSpecularExponent(_ marker: NSString) -> Bool {
        return marker as String == specularExponentMarker
    }

    fileprivate static func isIlluminationMode(_ marker: NSString) -> Bool {
        return marker as String == illuminationModeMarker
    }

    fileprivate static func isAmbientTextureMap(_ marker: NSString) -> Bool {
        return marker as String == ambientTextureMapMarker
    }

    fileprivate static func isDiffuseTextureMap(_ marker: NSString) -> Bool {
        return marker as String == diffuseTextureMapMarker
    }

    fileprivate func readColor() throws -> Color {
        do {
            return try scanner.readColor()
        } catch ScannerErrors.invalidData(let error) {
            throw MaterialLoadingError.unexpectedFileFormat(error: error)
        } catch ScannerErrors.unreadableData(let error) {
            throw MaterialLoadingError.unexpectedFileFormat(error: error)
        }
    }

    fileprivate func readIlluminationModel() throws -> IlluminationModel {
        do {
            let value = try scanner.readInt()
            if let model = IlluminationModel(rawValue: Int(value)) {
                return model
            }

            throw MaterialLoadingError.unexpectedFileFormat(error: "Invalid illumination model: \(value)")
        } catch ScannerErrors.invalidData(let error) {
            throw MaterialLoadingError.unexpectedFileFormat(error: error)
        }
    }

    fileprivate func readSpecularExponent() throws -> Double {
        do {
            let value = try scanner.readDouble()

            guard value >= 0.0 && value <= 1000.0 else {
                throw MaterialLoadingError.unexpectedFileFormat(error: "Invalid Ns value: !(value)")
            }

            return value
        } catch ScannerErrors.invalidData(let error) {
            throw MaterialLoadingError.unexpectedFileFormat(error: error)
        }
    }

    fileprivate func readFilename() throws -> NSString {
        do {
            return try scanner.readString()
        } catch ScannerErrors.invalidData(let error) {
            throw MaterialLoadingError.unexpectedFileFormat(error: error)
        }
    }

    fileprivate func buildMaterial() throws -> Material? {
        guard state.isDirty() else {
            return nil
        }

        guard let name = state.materialName else {
            throw MaterialLoadingError.unexpectedFileFormat(error: "Material name required for all materials")
        }

        return Material() {
            $0.name              = name as NSString
            $0.ambientColor      = self.state.ambientColor
            $0.diffuseColor      = self.state.diffuseColor
            $0.specularColor     = self.state.specularColor
            $0.specularExponent  = self.state.specularExponent
            $0.illuminationModel = self.state.illuminationModel
            $0.ambientTextureMapFilePath = self.state.ambientTextureMapFilePath
            $0.diffuseTextureMapFilePath = self.state.diffuseTextureMapFilePath

            return $0
        }
    }
}
