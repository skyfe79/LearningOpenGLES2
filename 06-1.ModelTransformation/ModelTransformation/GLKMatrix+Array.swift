//
//  GLKMatrix4+Array.swift
//  ModelTransformation
//
//  Created by burt on 2016. 2. 28..
//  Copyright © 2016년 BurtK. All rights reserved.
//
//  glUniformMatrix4fv 나 glUniformMatrix3fv 에 GLKMatrix를 전달하기 위한 확장코드 
//
//  @see https://www.snip2code.com/Snippet/407785/Xcode-6-3-OpenGL-Game-template-ported-to
import GLKit

extension GLKMatrix2 {
    var array: [Float] {
        return (0..<4).map { i in
            self[i]
        }
    }
}


extension GLKMatrix3 {
    var array: [Float] {
        return (0..<9).map { i in
            self[i]
        }
    }
}

extension GLKMatrix4 {
    var array: [Float] {
        return (0..<16).map { i in
            self[i]
        }
    }
}
