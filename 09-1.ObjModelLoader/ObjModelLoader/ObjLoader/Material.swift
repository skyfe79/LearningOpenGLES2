//
//  Material.swift
//  SwiftObjLoader
//
//  Created by Hugo Tunius on 04/10/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

// From http://floating-point-gui.de/errors/comparison/
private func doubleEquality(_ a: Double, _ b: Double) -> Bool {
    let diff = abs(a - b)

    if a == b { // shortcut for infinities
        return true
    } else if (a == 0 || b == 0 || diff < Double.leastNormalMagnitude) {
        return diff < (1e-5 * Double.leastNormalMagnitude)
    } else {
        let absA = abs(a)
        let absB = abs(b)
        return diff / min((absA + absB), Double.greatestFiniteMagnitude) < 1e-5
    }
}

public struct Color {
    public static let Black = Color(r: 0.0, g: 0.0, b: 0.0)

    public let r: Double
    public let g: Double
    public let b: Double

    func fuzzyEquals(_ other: Color) -> Bool {
        return doubleEquality(self.r, other.r) &&
               doubleEquality(self.g, other.g) &&
               doubleEquality(self.b, other.b)
    }
}

class MaterialBuilder {
    var name: NSString = ""
    var ambientColor: Color?
    var diffuseColor: Color?
    var specularColor: Color?
    var illuminationModel: IlluminationModel?
    var specularExponent: Double?
    var ambientTextureMapFilePath: NSString?
    var diffuseTextureMapFilePath: NSString?
}

public final class Material {
    public let name: NSString
    public let ambientColor: Color
    public let diffuseColor: Color
    public let specularColor: Color
    public let illuminationModel: IlluminationModel
    public let specularExponent: Double?
    public let ambientTextureMapFilePath: NSString?
    public let diffuseTextureMapFilePath: NSString?

    init(builderBlock: (MaterialBuilder) -> MaterialBuilder) {
        let builder = builderBlock(MaterialBuilder())

        self.name = builder.name
        self.ambientColor = builder.ambientColor ?? Color.Black
        self.diffuseColor = builder.diffuseColor ?? Color.Black
        self.specularColor = builder.specularColor ?? Color.Black
        self.illuminationModel = builder.illuminationModel ?? .constant
        self.specularExponent = builder.specularExponent
        self.ambientTextureMapFilePath = builder.ambientTextureMapFilePath
        self.diffuseTextureMapFilePath = builder.diffuseTextureMapFilePath
    }
}

extension Material: Equatable {}

public func ==(lhs: Material, rhs: Material) -> Bool {
    let result = lhs.name.isEqual(to: rhs.name as String) &&
            lhs.ambientColor.fuzzyEquals(rhs.ambientColor) &&
            lhs.diffuseColor.fuzzyEquals(rhs.diffuseColor) &&
            lhs.specularColor.fuzzyEquals(rhs.specularColor) &&
            lhs.illuminationModel == rhs.illuminationModel;

    return result;
}

public enum IlluminationModel: Int {
    // This is a constant color illumination model. The color is the specified Kd for the material. The formula is:
    // color = Kd
    case constant = 0

    // This is a diffuse illumination model using Lambertian shading.
    // The color includes an ambient and diffuse shading terms for each light source. The formula is
    // color = KaIa + Kd { SUM j=1..ls, (N * Lj)Ij }
    case diffuse = 1

    // This is a diffuse and specular illumination model using Lambertian shading
    // and Blinn's interpretation of Phong's specular illumination model (BLIN77).
    // The color includes an ambient constant term, and a diffuse and specular shading term for each light source. The formula is:
    // color = KaIa + Kd { SUM j=1..ls, (N*Lj)Ij } + Ks { SUM j=1..ls, ((H*Hj)^Ns)Ij }
    case diffuseSpecular = 2

    // Term definitions are: Ia ambient light, Ij light j's intensity, Ka ambient reflectance, Kd diffuse reflectance,
    // Ks specular reflectance, H unit vector bisector between L and V, L unit light vector, N unit surface normal, V unit view vector
}
