//
//  GameplayScene.swift
//  Petra The Game
//
//  Created by Thaynara Silva on 05/04/2018.
//  Copyright © 2018 Thaynara Silva. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    struct changePetraShirt {
        static var colour: String!
    }
    
    var movingNode: SKNode!
    var groundNode: SKNode!
    
    var groundSprite: SKSpriteNode!
    var skylineSprite: SKSpriteNode!
    var cloudSprite: SKSpriteNode!
    var petraSprite: SKSpriteNode!
    
    let worldCategory: UInt32 = 1 << 1
    let petraCategory: UInt32 = 1 << 0
    
    let groundTexture = SKTexture(imageNamed: "ground")
    let skylineTexture = SKTexture(imageNamed: "skyline")
    let cloudTexture = SKTexture(imageNamed: "clouds")
    var petraTexture: SKTexture!
    var petraTexture2: SKTexture!
    var petraTexture3: SKTexture!
    
    var skyColour: SKColor!
    var petraColour: String!
    
    override func didMove(to view: SKView) {
        
        // Setup world physics
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        self.physicsWorld.contactDelegate = self
        
        // Setup sky colour
        skyColour = SKColor(displayP3Red: 135/255, green: 206/255, blue: 250/255, alpha: 1)
        self.backgroundColor = skyColour
        
        movingNode = SKNode()
        self.addChild(movingNode)
        
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
            groundSprite.position = CGPoint(x: i * groundSprite.size.width, y: -(self.frame.height / 2.4))
            groundSprite.run(moveGroundForever)
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
                                             y: -(self.frame.size.height / 2.5) + groundTexture.size().height)
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
        if changePetraShirt.colour == nil || changePetraShirt.colour == "orange" {
            petraTexture = SKTexture(imageNamed: "Petra_1")
            petraTexture2 = SKTexture(imageNamed: "Petra_2")
            petraTexture3 = SKTexture(imageNamed: "Petra_3")
        } else if changePetraShirt.colour == "red" {
            petraTexture = SKTexture(imageNamed: "Petra_1_red")
            petraTexture2 = SKTexture(imageNamed: "Petra_2_red")
            petraTexture3 = SKTexture(imageNamed: "Petra_3_red")
        } else if changePetraShirt.colour == "yellow" {
            petraTexture = SKTexture(imageNamed: "Petra_1_yellow")
            petraTexture2 = SKTexture(imageNamed: "Petra_2_yellow")
            petraTexture3 = SKTexture(imageNamed: "Petra_3_yellow")
        } else if changePetraShirt.colour == "purple" {
            petraTexture = SKTexture(imageNamed: "Petra_1_purple")
            petraTexture2 = SKTexture(imageNamed: "Petra_2_purple")
            petraTexture3 = SKTexture(imageNamed: "Petra_3_purple")
        }
        petraTexture.filteringMode = .nearest
        petraTexture2.filteringMode = .nearest
        petraTexture3.filteringMode = .nearest
        let animate = SKAction.animate(with: [petraTexture, petraTexture2, petraTexture, petraTexture3], timePerFrame: 0.2)
        let walk = SKAction.repeatForever(animate)
        petraSprite = SKSpriteNode(texture: petraTexture)
        petraSprite.setScale(0.6)
        petraSprite.position = CGPoint(x: -85, y: -(self.frame.size.height / 2.5) + groundTexture.size().height)
        petraSprite.run(walk)
        petraSprite.physicsBody?.isDynamic = true
        petraSprite.physicsBody?.allowsRotation = false
        self.petraSprite.physicsBody = SKPhysicsBody(rectangleOf: self.petraSprite.size)
        petraSprite.physicsBody?.categoryBitMask = petraCategory
        self.addChild(petraSprite)
    }
}
