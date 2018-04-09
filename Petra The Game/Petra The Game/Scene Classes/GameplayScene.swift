//
//  GameplayScene.swift
//  Petra The Game
//
//  Created by Thaynara Silva on 05/04/2018.
//  Copyright © 2018 Thaynara Silva. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let PLAYER: UInt32 = 0
    static let GROUND: UInt32 = 1
    static let PHONE: UInt32 = 2
    static let SCORE: UInt32 = 1 << 3
}

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    struct changePetraShirt {
        static var COLOUR: String!
    }
    
    var movingNode: SKNode!
    var groundNode: SKNode!
    var phoneNode: SKNode!
    
    var groundSprite: SKSpriteNode!
    var skylineSprite: SKSpriteNode!
    var cloudSprite: SKSpriteNode!
    var petraSprite: SKSpriteNode!
    var phoneSprite: SKSpriteNode!
    
    let groundTexture = SKTexture(imageNamed: "ground")
    let skylineTexture = SKTexture(imageNamed: "skyline_w_logo")
    let cloudTexture = SKTexture(imageNamed: "clouds")
    var petraTexture: SKTexture!
    let phoneTexture = SKTexture(imageNamed: "phone")
    
    var skyColour: SKColor!
    var playerAnimation = [SKTexture]()
    var animatePlayerAction = SKAction()
    var movePhonesAndRemove: SKAction!
    var scoreNode: SKLabelNode!
    
    var canRestart = Bool()
    var maxY = CGFloat(150)
    var score = Int()
    
    override func didMove(to view: SKView) {
        
        canRestart = false
        
        // Setup world physics
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        self.physicsWorld.contactDelegate = self
        
        // Setup sky colour
        skyColour = SKColor(displayP3Red: 135/255, green: 206/255, blue: 250/255, alpha: 1)
        self.backgroundColor = skyColour
        
        movingNode = SKNode()
        self.addChild(movingNode)
        phoneNode = SKNode()
        movingNode.addChild(phoneNode)
        
        // Setup ground
        groundTexture.filteringMode = .nearest
        let moveGround = SKAction.moveBy(x: -groundTexture.size().width * 3.0, y: 0,
                                         duration: TimeInterval(0.006 * groundTexture.size().width * 3.0))
        let resetGround = SKAction.moveBy(x: groundTexture.size().width * 3.0, y: 0, duration: 0.00)
        let moveGroundForever = SKAction.repeatForever(SKAction.sequence([moveGround, resetGround]))
        
        for i in 0...3 + Int(self.frame.size.width / (groundTexture.size().width * 3)) {
            let i = CGFloat(i)
            groundSprite = SKSpriteNode(texture: groundTexture)
            groundSprite.size.width = 720
            groundSprite.size.height = 250
            groundSprite.position = CGPoint(x: i * groundSprite.size.width, y: -(self.frame.height / 2.45))
            groundSprite.run(moveGroundForever)
            groundSprite.physicsBody = SKPhysicsBody(rectangleOf: groundSprite.size)
            groundSprite.physicsBody?.affectedByGravity = false
            groundSprite.physicsBody?.categoryBitMask = ColliderType.GROUND
            groundSprite.physicsBody?.isDynamic = false
            movingNode.addChild(groundSprite)
        }
        
        // Setup skyline
        skylineTexture.filteringMode = .nearest
        let moveSkyline = SKAction.moveBy(x: -skylineTexture.size().width * 3.0, y: 0,
                                          duration: TimeInterval(0.05 * skylineTexture.size().width * 3.0))
        let resetSkyline = SKAction.moveBy(x: skylineTexture.size().width * 3.0, y: 0, duration: 0.00)
        let moveSkylineForever = SKAction.repeatForever(SKAction.sequence([moveSkyline, resetSkyline]))
        
        for i in 0...3 + Int(self.frame.size.width / (skylineTexture.size().width * 3)) {
            let i = CGFloat(i)
            skylineSprite = SKSpriteNode(texture: skylineTexture)
            skylineSprite.zPosition = -20
            skylineSprite.position = CGPoint(x: i * skylineSprite.size.width,
                                             y: -250)
            skylineSprite.run(moveSkylineForever)
            movingNode.addChild(skylineSprite)
        }
        
        // Setup clouds
        cloudTexture.filteringMode = .nearest
        let moveClouds = SKAction.moveBy(x: -cloudTexture.size().width * 3.0, y: 0,
                                         duration: TimeInterval(0.03 * cloudTexture.size().width * 3.0))
        let resetClouds = SKAction.moveBy(x: cloudTexture.size().width * 3.0, y: 0, duration: 0.00)
        let moveCloudsForever = SKAction.repeatForever(SKAction.sequence([moveClouds, resetClouds]))
        
        for i in 0...3 + Int(self.frame.size.width / (cloudTexture.size().width * 3)) {
            let i = CGFloat(i)
            cloudSprite = SKSpriteNode(texture: cloudTexture)
            cloudSprite.zPosition = -20
            cloudSprite.position = CGPoint(x: i * cloudSprite.size.width,
                                           y: -(self.frame.size.height / 2.5) + skylineTexture.size().height * 3.15)
            cloudSprite.run(moveCloudsForever)
            movingNode.addChild(cloudSprite)
        }
        
        // Setup Petra
        if changePetraShirt.COLOUR == "red" {
            playerAnimation.append(SKTexture(imageNamed: "Petra_1_red"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_2_red"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_1_red"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_3_red"))
            petraTexture = SKTexture(imageNamed: "Petra_1_red")
        } else if changePetraShirt.COLOUR == "orange" {
            playerAnimation.append(SKTexture(imageNamed: "Petra_1"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_2"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_1"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_3"))
            petraTexture = SKTexture(imageNamed: "Petra_1")
        } else if changePetraShirt.COLOUR == "yellow" {
            playerAnimation.append(SKTexture(imageNamed: "Petra_1_yellow"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_2_yellow"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_1_yellow"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_3_yellow"))
            petraTexture = SKTexture(imageNamed: "Petra_1_yellow")
        } else if changePetraShirt.COLOUR == "purple" {
            playerAnimation.append(SKTexture(imageNamed: "Petra_1_purple"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_2_purple"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_1_purple"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_3_purple"))
            petraTexture = SKTexture(imageNamed: "Petra_1_purple")
        } else {
            playerAnimation.append(SKTexture(imageNamed: "Petra_1"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_2"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_1"))
            playerAnimation.append(SKTexture(imageNamed: "Petra_3"))
            petraTexture = SKTexture(imageNamed: "Petra_1")
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.2, resize: true, restore: false)
        petraSprite = SKSpriteNode(texture: petraTexture)
        petraSprite.name = "player"
        petraSprite.setScale(0.6)
        petraSprite.position = CGPoint(x: -200, y: -(self.frame.size.height / 2.4) + groundTexture.size().height)
        petraSprite.zPosition = 5
        petraSprite.run(SKAction.repeatForever(animatePlayerAction))
        petraSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: petraSprite.size.width - 40, height: petraSprite.size.height - 30))
        petraSprite.physicsBody?.affectedByGravity = true
        petraSprite.physicsBody?.allowsRotation = false
        petraSprite.physicsBody?.restitution = 0
        petraSprite.physicsBody?.categoryBitMask = ColliderType.PLAYER
        petraSprite.physicsBody?.collisionBitMask = ColliderType.GROUND
        petraSprite.physicsBody?.contactTestBitMask = ColliderType.PHONE
        self.addChild(petraSprite)
        
        // Setup phones
        phoneTexture.filteringMode = .nearest
        let movePhones = SKAction.moveBy(x: -(self.frame.size.width) * 2.0, y: 0.0, duration: TimeInterval(2.0))
        let removePhones = SKAction.removeFromParent()
        movePhonesAndRemove = SKAction.sequence([movePhones, removePhones])

        let spawn = SKAction.run(spawnPhones)
        let ring = SKAction.playSoundFileNamed("ring.wav", waitForCompletion: false)
        ring.duration = 2.0
        let delay = SKAction.wait(forDuration: TimeInterval(3.0))
        let spawnDelay = SKAction.sequence([spawn, ring, delay])
        let spawnDelayForever = SKAction.repeatForever(spawnDelay)
        self.run(spawnDelayForever)
        
        // Setup score
        score = 0
        scoreNode = SKLabelNode()
        scoreNode.position = CGPoint(x: 0, y: 30)
        scoreNode.fontName = "courier"
        scoreNode.fontSize = 250
        scoreNode.fontColor = UIColor.orange
        scoreNode.zPosition = 5
        scoreNode.text = "0"
        movingNode.addChild(scoreNode)
        
        let wait = SKAction.wait(forDuration: TimeInterval(3.0))
        let updateScore = SKAction.run {
            self.score += 1
            self.scoreNode.text = String(self.score)
        }
        let updatingScore = SKAction.sequence([wait, updateScore])
        let updateScoreForever = SKAction.repeatForever(updatingScore)
        self.run(updateScoreForever)
    }
    
    func spawnPhones() {
        
        phoneSprite = SKSpriteNode(texture: phoneTexture)
        phoneSprite.name = "phone"
        phoneSprite.physicsBody = SKPhysicsBody(rectangleOf: phoneSprite.size)
        phoneSprite.physicsBody?.affectedByGravity = false
        phoneSprite.physicsBody?.categoryBitMask = ColliderType.PHONE
        phoneSprite.zPosition = 4
        phoneSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        phoneSprite.setScale(4.5)
        phoneSprite.position = CGPoint(x: self.frame.size.width + phoneTexture.size().width * 2, y: -300)
        phoneSprite.run(movePhonesAndRemove)
        phoneNode.addChild(phoneSprite)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if movingNode.speed > 0 {
            for _ in touches {
                if petraSprite.position.y < maxY {
                    let jumpUpAction = SKAction.moveBy(x: 0, y: 300, duration: 0.5)
                    let jumpDownAction = SKAction.moveBy(x: 0, y: -300, duration: 0.4)
                    let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
                    petraSprite.run(jumpSequence)
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "player" && secondBody.node?.name == "phone" {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
            GameOverScene.updateScore.score = score
            endGame()
        }
    }
    
    func endGame() {
        phoneNode.removeAllChildren()
        if let scene = GameOverScene(fileNamed: "GameOver") {
            scene.scaleMode = .aspectFill
            view!.presentScene(scene)
        }
    }
}
