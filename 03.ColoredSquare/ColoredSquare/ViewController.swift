//
//  ViewController.swift
//  ColoredSquare
//
//  Created by burt on 2016. 2. 26..
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
    var indexBuffer: GLuint = 0
    var shader : BaseEffect!
    
    let vertices : [Vertex] = [
        Vertex( 1.0, -1.0, 0, 1.0, 0.0, 0.0, 1.0),
        Vertex( 1.0,  1.0, 0, 0.0, 1.0, 0.0, 1.0),
        Vertex(-1.0,  1.0, 0, 0.0, 0.0, 1.0, 1.0),
        Vertex(-1.0, -1.0, 0, 1.0, 1.0, 0.0, 1.0)
    ]
    
    let indices : [GLubyte] = [
        0, 1, 2,
        2, 3, 0
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
        
        // 이렇게 하면 매 드로잉 콜마다
        // 정점과 인덱스 데이터를 CPU에서 GPU로 복사해야 하므로 성능이 떨이지는 단점이 있다.
        // 이를 해결하기 위해서 VertexArrayObject를 사용하는 것이다.
        // 프로그램 초기에 VAO를 GPU만들어서 거기에 모든 데이터를 CPU에서 GPU로 한번 설정한다.
        // 그리고 매 드로잉콜에서는 VAO를 바인딩해서 사용하면 된다.
        // 즉, 그리고자 하는 모델이 VAO를 가지고 있으면 된다.
        // 모델이 생성될 때, 정점 등의 데이터를 읽어서 자신의 VAO를 GPU에 만들고
        // VAO에 데이터를 전송하면 매 드로잉콜마다 데이터를 전송할 필요 없이
        // 자신의 VAO를 바인딩해서 사용하며 된다.
        glEnableVertexAttribArray(VertexAttributes.Position.rawValue)
        glVertexAttribPointer(
            VertexAttributes.Position.rawValue,
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(sizeof(Vertex)), BUFFER_OFFSET(0))

        
        glEnableVertexAttribArray(VertexAttributes.Color.rawValue)
        glVertexAttribPointer(
            VertexAttributes.Color.rawValue,
            4,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(sizeof(Vertex)), BUFFER_OFFSET(3 * sizeof(GLfloat))) // x, y, z | r, g, b, a :: offset is 3*sizeof(GLfloat)
        
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(indices.count), GLenum(GL_UNSIGNED_BYTE), nil)
        
        glDisableVertexAttribArray(VertexAttributes.Position.rawValue)
        
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
        
        glGenBuffers(GLsizei(1), &indexBuffer)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), indices.count * sizeof(GLubyte), indices, GLenum(GL_STATIC_DRAW))
    }
    
    func BUFFER_OFFSET(n: Int) -> UnsafePointer<Void> {
        let ptr: UnsafePointer<Void> = nil
        return ptr + n
    }
}
