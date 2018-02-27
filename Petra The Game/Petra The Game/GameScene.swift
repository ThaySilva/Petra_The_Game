//
//  GameScene.swift
//  Petra The Game
//
//  Created by Thaynara Silva on 08/02/2018.
//  Copyright © 2018 Thaynara Silva. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate {

    var skyColor = SKColor(displayP3Red: 135/255, green: 206/255, blue: 250/255, alpha: 1)
    var movingNode = SKNode()
    var petra:SKSpriteNode!
    
    let petraCategory: UInt32 = 1 << 0
    let worldCategory : UInt32 = 1 << 1
    
    let ground = SKNode()
    let groundTexture = SKTexture(imageNamed: "ground")
    let skylineTexture = SKTexture(imageNamed: "skyline")
    let cloudsTexture = SKTexture(imageNamed: "clouds")
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.5)
        self.physicsWorld.contactDelegate = self
        
        self.backgroundColor = skyColor
        
        self.addChild(movingNode)
        
        createGround()
        
        createSkyline()
        
        let petraTexture = SKTexture(imageNamed: "Petra_1")
        petraTexture.filteringMode = .nearest
        let petraTexture2 = SKTexture(imageNamed: "Petra_2")
        petraTexture2.filteringMode = .nearest
        let petraTexture3 = SKTexture(imageNamed: "Petra_3")
        petraTexture3.filteringMode = .nearest

        let anim = SKAction.animate(with: [petraTexture, petraTexture2, petraTexture3], timePerFrame: 0.2)
        let walk = SKAction.repeatForever(anim)
        
        petra = SKSpriteNode(texture: petraTexture)
        petra.setScale(0.6)
        petra.position = CGPoint(x: -85,
                                 y: -(self.frame.size.height / 2.5) + groundTexture.size().height * 3.2)
        petra.run(walk)
        
//        petra.physicsBody = SKPhysicsBody(circleOfRadius: petra.size.height)
//        petra.physicsBody?.isDynamic = true
//        petra.physicsBody?.allowsRotation = false
        
        petra.physicsBody?.categoryBitMask = petraCategory
        
        self.addChild(petra)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func createGround() {
        groundTexture.filteringMode = .nearest
        
        let moveGround = SKAction.moveBy(x: -groundTexture.size().width * 3.0, y: 0,
                                       duration: TimeInterval(0.006 * groundTexture.size().width * 3.0))
        let resetGround = SKAction.moveBy(x: groundTexture.size().width * 3.0, y: 0, duration: 0.00)
        let moveGroundForever = SKAction.repeatForever(SKAction.sequence([moveGround, resetGround]))
        
        for i in 0...3 + Int(self.frame.size.width / (groundTexture.size().width * 3)) {
            let i = CGFloat(i)
            let groundSprite = SKSpriteNode(texture: groundTexture)
            groundSprite.setScale(3.0)
            groundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            groundSprite.position = CGPoint(x: i * groundSprite.size.width, y: -(self.frame.size.height / 2.5))
            groundSprite.run(moveGroundForever)
            movingNode.addChild(groundSprite)
        }
        
        ground.position = CGPoint(x: 0, y: groundTexture.size().height)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width,
                                                               height: groundTexture.size().height * 2.0))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = worldCategory
        self.addChild(ground)
    }
    
    func createSkyline() {
        skylineTexture.filteringMode = .nearest
        
        let moveSkyline = SKAction.moveBy(x: -skylineTexture.size().width * 3.0, y: 0,
                                          duration: TimeInterval(0.05 * skylineTexture.size().width * 3.0))
        let resetSkyline = SKAction.moveBy(x: skylineTexture.size().width * 3.0, y: 0, duration: 0.00)
        let moveSkylineForever = SKAction.repeatForever(SKAction.sequence([moveSkyline, resetSkyline]))
        
        for i in 0...3 + Int(self.frame.size.width / (skylineTexture.size().width * 3)) {
            let i = CGFloat(i)
            let skylineSprite = SKSpriteNode(texture: skylineTexture)
            skylineSprite.setScale(3.0)
            skylineSprite.zPosition = -20
            skylineSprite.position = CGPoint(x: i * skylineSprite.size.width,
                                             y: -(self.frame.size.height / 2.5) + groundTexture.size().height * 3.15)
            skylineSprite.run(moveSkylineForever)
            movingNode.addChild(skylineSprite)
        }
        
        createClouds()
    }
    
    func createClouds() {
        cloudsTexture.filteringMode = .nearest
        
        let moveClouds = SKAction.moveBy(x: -cloudsTexture.size().width * 3.0, y: 0,
                                         duration: TimeInterval(0.03 * cloudsTexture.size().width * 3.0))
        let resetClouds = SKAction.moveBy(x: cloudsTexture.size().width * 3.0, y: 0, duration: 0.00)
        let moveCloudsForever = SKAction.repeatForever(SKAction.sequence([moveClouds, resetClouds]))
        
        for i in 0...3 + Int(self.frame.size.width / (cloudsTexture.size().width * 3)) {
            let i = CGFloat(i)
            let cloudSprite = SKSpriteNode(texture: cloudsTexture)
            cloudSprite.setScale(3.0)
            cloudSprite.zPosition = -20
            cloudSprite.position = CGPoint(x: i * cloudSprite.size.width,
                                           y: -(self.frame.size.height / 2.5) + skylineTexture.size().height * 8.5)
            cloudSprite.run(moveCloudsForever)
            movingNode.addChild(cloudSprite)
        }
    }
}
