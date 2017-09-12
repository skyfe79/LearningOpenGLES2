//
//  FixtureHelper.swift
//  SwiftObjLoader
//
//  Created by Hugo Tunius on 02/09/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

enum FixtureLoadingErrors: Error {
    case NotFound
}

class FixtureHelper {
    let bundle: Bundle
    init() {
        bundle = FixtureHelper.loadBundle()
    }
    
    func loadObjFixture(name: String) throws -> String {
        guard let path = bundle.path(forResource: name, ofType: "obj") else {
            throw FixtureLoadingErrors.NotFound
        }
        
        let string = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
        
        return string as String
    }
    
    func loadMtlFixture(name: String) throws -> String {
        guard let path = bundle.path(forResource: name, ofType: "mtl") else {
            throw FixtureLoadingErrors.NotFound
        }
        
        let string = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
        
        return string as String
    }
    
    var resourcePath: String {
        get {
            return bundle.resourcePath!
        }
    }
    
    static private func loadBundle() -> Bundle {
        return Bundle(for: self)
    }
}
