//
//  ViewController.swift
//  SpecularLight
//
//  Created by burt on 2016. 3. 1..
//  Copyright © 2016년 BurtK. All rights reserved.
//

import UIKit
import GLKit

class GLKUpdater : NSObject, GLKViewControllerDelegate {
    
    weak var glkViewController : ViewController!
    
    init(glkViewController : ViewController) {
        self.glkViewController = glkViewController
    }
    
    
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        self.glkViewController.model.updateWithDelta(self.glkViewController.timeSinceLastUpdate)
    }
}


class ViewController: GLKViewController {
    
    var glkView: GLKView!
    var glkUpdater: GLKUpdater!
    var shader : BaseEffect!
    var model : Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGLcontext()
        setupGLupdater()
        setupScene()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        
        //Transfomr4: Viewport: Normalized -> Window
        //glViewport(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
        //이건 GLKit이 자동으로 해준다
        glClearColor(1.0, 0.0, 0.0, 1.0);
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
        
        glEnable(GLenum(GL_DEPTH_TEST))
        glEnable(GLenum(GL_CULL_FACE))
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        let viewMatrix : GLKMatrix4 =  GLKMatrix4Rotate(GLKMatrix4MakeTranslation(0, 0, -5), GLKMathDegreesToRadians(20), 1, 0, 0)
        
        self.model.render(withParentModelViewMatrix: viewMatrix)
    }
}

extension ViewController {
    
    func setupGLcontext() {
        glkView = self.view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)!
        glkView.drawableDepthFormat = .format16         // for depth testing
        EAGLContext.setCurrent(glkView.context)
    }
    
    func setupGLupdater() {
        self.glkUpdater = GLKUpdater(glkViewController: self)
        self.delegate = self.glkUpdater
    }
    
    func setupScene() {
        self.shader = BaseEffect(vertexShader: "SimpleVertexShader.glsl", fragmentShader: "SimpleFragmentShader.glsl")
        
        self.shader.projectionMatrix = GLKMatrix4MakePerspective(
            GLKMathDegreesToRadians(85.0),
            GLfloat(self.view.bounds.size.width / self.view.bounds.size.height),
            1,
            150)

        // load obj file named "key.obj"
        let fixtureHelper = FixtureHelper()
        let source = try? fixtureHelper.loadObjFixture(name: "key")
        
        if let source = source {
            let loader = ObjLoader(source: source, basePath: fixtureHelper.resourcePath)
            do {
                let shapes = try loader.read()
                
                self.model = ObjModel(name: "key", shape: shapes.first!, shader: self.shader)
                self.model.scale = 0.3
            } catch {
                print("Parsing failed with unknown error")
            }
        } else {
            print("obj not found")
        }
    }
    
    
}
