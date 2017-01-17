//
//  ViewController.swift
//  RedAlert
//
//  Created by burt on 2016. 2. 23..
//  Copyright © 2016년 BurtK. All rights reserved.
//

import UIKit
import GLKit

class ViewController: GLKViewController {
    
    var glkView: GLKView!
    var glkUpdater: GLKUpdater!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        glkView = self.view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)
        EAGLContext.setCurrent(glkView.context)
        
        self.glkUpdater = GLKUpdater(glkViewController: self)
        self.delegate = glkUpdater
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(Float(glkUpdater.redValue), 0.0, 0.0, 1.0)
        
        // GLbitfield is typealias of UInt32
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }
    
}

class GLKUpdater : NSObject, GLKViewControllerDelegate {
    
    var redValue : Double = 0.0
    let durationOfFlash : Double = 2.0
    weak var glkViewController : GLKViewController!
    
    init(glkViewController : GLKViewController) {
        self.glkViewController = glkViewController
    }
    
    
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        
        /// @see https://www.khanacademy.org/math/trigonometry/trig-function-graphs/graphing-sinusoids/v/amplitude-and-period-cosine-transformations
        redValue = (sin(self.glkViewController.timeSinceFirstResume * 2 * M_PI / durationOfFlash) * 0.5) + 0.5
    }
}


