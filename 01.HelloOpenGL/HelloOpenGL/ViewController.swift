//
//  ViewController.swift
//  HelloOpenGL
//
//  Created by burt on 2016. 2. 23..
//  Copyright © 2016년 BurtK. All rights reserved.
//

import UIKit
import GLKit

class ViewController: GLKViewController {
    
    var glkView: GLKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        glkView = self.view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(1.0, 0.0, 0.0, 1.0)
        
        // GLbitfield is typealias of UInt32
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }

}

