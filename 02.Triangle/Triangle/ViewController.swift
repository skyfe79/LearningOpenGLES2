//
//  ViewController.swift
//  Triangle
//
//  Created by burt on 2016. 2. 25..
//  Copyright © 2016년 BurtK. All rights reserved.
//

import UIKit
import GLKit

class GLKUpdater : NSObject, GLKViewControllerDelegate {
    
    weak var glkViewController : GLKViewController!
    
    init(glkViewController : GLKViewController) {
        self.glkViewController = glkViewController
    }
    
    
    func glkViewControllerUpdate(controller: GLKViewController) {
        
    }
}


class ViewController: GLKViewController {
    
    var glkView: GLKView!
    var glkUpdater: GLKUpdater!
    
    var vertexBuffer : GLuint = 0
    var shader : BaseEffect!
        
    let vertices : [Vertex] = [
        Vertex( 0.0,  0.25, 0.0),    // TOP
        Vertex(-0.5, -0.25, 0.0),    // LEFT
        Vertex( 0.5, -0.25, 0.0),    // RIGHT

    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGLcontext()
        setupGLupdater()
        setupShader()
        setupVertexBuffer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func glkView(view: GLKView, drawInRect rect: CGRect) {
        glClearColor(1.0, 0.0, 0.0, 1.0);
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        // shader.begin() 이 더 나은거 같다.
        shader.prepareToDraw()
        
        glEnableVertexAttribArray(VertexAttributes.VertexAttribPosition.rawValue)
        glVertexAttribPointer(
            VertexAttributes.VertexAttribPosition.rawValue,
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(sizeof(Vertex)), nil) // or BUFFER_OFFSET(0) -> 한 구조체에 정점 위치 이외의 것을 같이 사용할 때
        
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
        
        glDisableVertexAttribArray(VertexAttributes.VertexAttribPosition.rawValue)

    }

}

extension ViewController {
    
    func setupGLcontext() {
        glkView = self.view as! GLKView
        glkView.context = EAGLContext(API: .OpenGLES2)
        EAGLContext.setCurrentContext(glkView.context)
    }
    
    func setupGLupdater() {
        self.glkUpdater = GLKUpdater(glkViewController: self)
        self.delegate = self.glkUpdater
    }
    
    func setupShader() {
        self.shader = BaseEffect(vertexShader: "SimpleVertexShader.glsl", fragmentShader: "SimpleFragmentShader.glsl")
    }
    
    func setupVertexBuffer() {
        glGenBuffers(GLsizei(1), &vertexBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        let count = vertices.count
        let size =  sizeof(Vertex)
        glBufferData(GLenum(GL_ARRAY_BUFFER), count * size, vertices, GLenum(GL_STATIC_DRAW))
    }

    func BUFFER_OFFSET(n: Int) -> UnsafePointer<Void> {
        let ptr: UnsafePointer<Void> = nil
        return ptr + n * sizeof(Void)
    }
}



