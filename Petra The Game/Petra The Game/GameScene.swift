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
    
    let worldCategory : UInt32 = 1 << 1
    
    let ground = SKNode()
    let groundTexture = SKTexture(imageNamed: "ground")
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.5)
        self.physicsWorld.contactDelegate = self
        
        self.backgroundColor = skyColor
        
        self.addChild(movingNode)
        
        createGround()
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
}
