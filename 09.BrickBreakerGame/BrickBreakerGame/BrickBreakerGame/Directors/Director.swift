import GLKit
import AVFoundation

extension CGSize {
    var ratioW2H: CGFloat {
        guard height > 0.0 else { return 1 }
        return width / height
    }
}

final class Director {
  internal let glkView: GLKView
  internal var scene: Scene {didSet{ scene.director = self }}
  internal var shaderProgram: ShaderProgram

  internal var backgroundMusicPlayer: AVAudioPlayer?
  internal var popEffect: AVAudioPlayer?

  internal init(view: GLKView,
                scene: Scene,
                shaderProgram: ShaderProgram) {
    self.glkView = view
    self.scene = scene
    self.shaderProgram = shaderProgram
    self.scene.director = self
  }


  internal func render(with parentModelViewMatrix: GLKMatrix4) {
    glClearColor(0, 0, 0, 0)
    glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
    glEnable(GLenum(GL_DEPTH_TEST))
    glEnable(GLenum(GL_CULL_FACE))
    glEnable(GLenum(GL_BLEND))
    glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
    self.scene.render(with: GLKMatrix4Identity)
  }

  // MARK: - Music
  internal func playBackgroundMusic(file: String) {
    guard let player = self.preloadSoundEffect(file: file) else { return }
    player.numberOfLoops = -1
    player.play()
    self.backgroundMusicPlayer = player
  }

  internal func setPopEffect(file: String) {
    self.popEffect = self.preloadSoundEffect(file: file)
  }

  internal func preloadSoundEffect(file: String) -> AVAudioPlayer? {
    guard let url = Bundle.main.url(forResource: file, withExtension: nil),
      let player = try? AVAudioPlayer(contentsOf: url)
      else { return nil }
    player.prepareToPlay()
    return player
  }

  internal func playPopEffect() {
    self.popEffect?.play()
  }
}

extension Director {
  static func gameDirector(of view: GLKView) -> Director {
    guard let context = EAGLContext(api: .openGLES2) else { fatalError("Cannot create an EAGLContext") }
    view.context = context
    view.drawableDepthFormat = .format16
    EAGLContext.setCurrent(view.context)

    let program = ShaderProgram.program(vertexShaderFile: "SimpleVertexShader.glsl",
                                        fragmentShaderFile: "SimpleFragmentShader.glsl")
    let shaderProgram: ShaderProgram
    switch program {
    case .success(let sp): shaderProgram = sp
    case .failure(let error): fatalError(error.localizedDescription)
    }

    let scene =
      GameScene(shaderProgram: shaderProgram)
//    TestScene(shaderProgram: shaderProgram)

    shaderProgram.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(90),
                                                               Float(view.bounds.size.ratioW2H),
                                                               1,
                                                               150)
    return Director(view: view, scene: scene, shaderProgram: shaderProgram)
  }
}


