//
//  ShaderError.swift
//  OpenGLESLearning
//
//  Created by Pi on 04/09/2017.
//  Copyright © 2017 Keith. All rights reserved.
//

import Foundation

internal enum ShaderError: Error {
  case shaderFileNotFound(filename: String)
  case fileContentCannotRead(filepath: String, error: Error)
  case shaderFailedToCreate(info: String)
  case shaderProgramFailedToCreate(info: String)
}
