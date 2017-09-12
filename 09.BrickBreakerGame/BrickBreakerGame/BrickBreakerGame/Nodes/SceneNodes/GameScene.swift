
import GLKit
import PaversFRP


final internal class GameScene: Scene {

  fileprivate let gameArea: CGSize
  fileprivate let sceneOffset: Float
  fileprivate let paddle: Node

  fileprivate let ball: Node

  fileprivate let bricksPerRow = 9
  fileprivate let bricksPerCol = 8

  fileprivate var bricks = [Node]()

  fileprivate let leftWall: Node
  fileprivate let rightWall: Node
  fileprivate let topWall: Node

  fileprivate var velocityX: Float = 10
  fileprivate var velocityY: Float = 10

  init(shaderProgram: ShaderProgram) {

    let height: CGFloat = 48
    let width = height * UIScreen.main.bounds.size.ratioW2H

    self.gameArea = CGSize(width, height)

    let x = self.gameArea.height / 2
    let y = tanf(GLKMathDegreesToRadians(90/2))

    self.sceneOffset = Float(x) / y
    self.paddle = CubeNode(shader: shaderProgram)


    let ballResult = TriangleNode.node(name: "Ball", objectFile: "ball.obj", textureFile: nil, with: shaderProgram)
    guard let ball = ballResult.value else {
      fatalError(ballResult.error?.localizedDescription ?? "ball created failed")
    }
    self.ball = ball

    self.leftWall = CubeNode(shader: shaderProgram)
    self.rightWall = CubeNode(shader: shaderProgram)
    self.topWall = CubeNode(shader: shaderProgram)

    super.init(name: "GameScene", shaderProgram: shaderProgram, vertices: [], indices: [])

    // create the initial scene position (i.e. camera)
    self.position = GLKVector3Make(Float(-self.gameArea.width / 2),
                                   Float(-self.gameArea.height / 2) + 10,
                                   -self.sceneOffset)

    self.rotationX = GLKMathDegreesToRadians(-20)

    // create paddle near bottom of scene
    self.paddle.position = GLKVector3Make(Float(self.gameArea.width / 2),
                                          Float(self.gameArea.height * 0.1), 0)
    self.paddle.scaleX = 2
    self.paddle.scaleY = 0.5
    self.paddle.scaleZ = 0.5
    self.paddle.matColor = GLKVector4Make(1, 0, 0, 1)
    self.add(child:self.paddle)


    self.ball.position = GLKVector3Make(Float(self.gameArea.width / 2),
                                             Float(self.gameArea.height * 0.15) + 0.25, 0)
    self.ball.scaleX = 0.5
    self.ball.scaleY = 0.5
    self.ball.scaleZ = 0.5
    self.ball.matColor = GLKVector4Make(0, 1, 0, 1)
    self.add(child:self.ball)


    self.leftWall.position = GLKVector3Make(-0.5,
                                            Float(self.gameArea.height / 2), 0)
    self.leftWall.scaleY = Float(height)
    self.add(child:self.leftWall)

    self.rightWall.position = GLKVector3Make(Float(self.gameArea.width + 0.5),
                                            Float(self.gameArea.height / 2), 0)
    self.rightWall.scaleY = Float(height)
    self.add(child:self.rightWall)

    self.topWall.position = GLKVector3Make(Float(self.gameArea.width / 2),
                                            Float(self.gameArea.height + 0.5 ), 0)
    self.topWall.scaleX = Float(width) + 2
    self.add(child:self.topWall)


    let margin = Float(self.gameArea.width * 0.1)
    let startY = Float(self.gameArea.height * 0.5)
    for j in 0 ..< self.bricksPerCol {
      for i in 0 ..< self.bricksPerRow {
        let brick = CubeNode(shader: self.shaderProgram)
        brick.scaleX = 1
        brick.scaleY = 0.5
        brick.scaleZ = 0.5
        brick.matColor = GLKVector4Make(0, 0, 1, 1)
        brick.rotated = true
        brick.position = GLKVector3Make(margin + (margin * Float(i)), startY + margin * Float(j), 0)
        self.add(child:brick)
        self.bricks.append(brick)
      }
    }

  }

  // MARK: - Reaction

  fileprivate func touchLocationToGameArea(_ touchLocation: CGPoint) -> CGPoint {
    guard let director = self.director else { return .zero }

    let ratio = director.glkView.frame.size.height / self.gameArea.height
    let x = touchLocation.x / ratio
    let y = (director.glkView.frame.size.height - touchLocation.y) / ratio
    return CGPoint(x, y)

  }

  fileprivate var previousTouchLocation = CGPoint.zero

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    guard let touch = touches.first, let director = self.director else { return }
    let touchLocation = touch.location(in: director.glkView)
    self.previousTouchLocation = self.touchLocationToGameArea(touchLocation)

  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    guard let touch = touches.first, let director = self.director else { return }
    let touchLocation = self.touchLocationToGameArea(touch.location(in: director.glkView))
    let diff = CGPoint(touchLocation.x - self.previousTouchLocation.x, touchLocation.y - self.previousTouchLocation.y)
    self.previousTouchLocation = touchLocation

    var newX = self.paddle.position.x + Float(diff.x)
    newX = min(max(newX, self.paddle.scaleX / 2), Float(self.gameArea.width) - Float(self.paddle.scaleX / 2))
    self.paddle.position = GLKVector3Make(newX, self.paddle.position.y, self.paddle.position.z)
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}


  
  // MARK: - Content update

  override func updateWithDelta(_ dt: TimeInterval) {
    super.updateWithDelta(dt)

    guard let director = self.director else { return }
    var newX = self.ball.position.x + self.velocityX * Float(dt)
    var newY = self.ball.position.y + self.velocityY * Float(dt)
    if newX < 0 {
      newX = 0
      self.velocityX = -self.velocityX
      director.popEffect?.play()
    }
    if newY < 0 {
      newY = 0
      self.velocityY = -self.velocityY
      director.backgroundMusicPlayer?.stop()
      director.scene = GameOverScene(shaderProgram: self.shaderProgram, win: false)
    }
    if newX > Float(self.gameArea.width) {
      newX = 27
      self.velocityX = -self.velocityX
      director.popEffect?.play()
    }

    if newY > Float(self.gameArea.height) {
      newY = 48
      self.velocityY = -self.velocityY
      director.popEffect?.play()
    }

    self.ball.position = GLKVector3Make(newX, newY, self.ball.position.z)

    let ballRect = self.ball.boundingBoxWithModelViewMatrix(parenetModelViewMatrix: GLKMatrix4Identity)
    let paddleRect = self.paddle.boundingBoxWithModelViewMatrix(parenetModelViewMatrix: GLKMatrix4Identity)

    if ballRect.intersects(paddleRect) {
      self.velocityY = -self.velocityY
      director.popEffect?.play()
    }

    var brickToDestroy: Node? = nil
    for brick in self.bricks {
      let brickRect = brick.boundingBoxWithModelViewMatrix(parenetModelViewMatrix: GLKMatrix4Identity)
      if ballRect.intersects(brickRect) {
        brickToDestroy = brick
        break
      }
    }
    if let destroyedBrick = brickToDestroy {
      self.remove(child: destroyedBrick)

      if let idx = self.bricks.index(where: {$0 === destroyedBrick}) {
        self.bricks.remove(at: idx)
      }

      self.velocityY = -self.velocityY
      director.popEffect?.play()
    }

    if self.bricks.count == 0 {
      director.backgroundMusicPlayer?.stop()
      director.scene = GameOverScene(shaderProgram: self.shaderProgram, win: true)
    }
  }
}















