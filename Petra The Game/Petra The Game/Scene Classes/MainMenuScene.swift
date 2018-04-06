//
//  MainMenuScene.swift
//  Petra The Game
//
//  Created by Thaynara Silva on 05/04/2018.
//  Copyright © 2018 Thaynara Silva. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {

    var skyColor: SKColor!
    
    var menuNode: SKNode!
    var movingNode: SKNode!
    var groundNode: SKNode!
    
    var logoSprite: SKSpriteNode!
    var startBtnSprite: SKSpriteNode!
    var customiseBtnSprite: SKSpriteNode!
    var infoBtnSprite: SKSpriteNode!
    var groundSprite: SKSpriteNode!
    var skylineSprite: SKSpriteNode!
    var cloudSprite: SKSpriteNode!
    
    let worldCategory: UInt32 = 1 << 1
    
    let logoTexture = SKTexture(imageNamed: "petraLogo")
    let startBtnTexture = SKTexture(imageNamed: "startBtn")
    let customiseBtnTexture = SKTexture(imageNamed: "customiseBtn")
    let infoBtnTexture = SKTexture(imageNamed: "info")
    let groundTexture = SKTexture(imageNamed: "ground")
    let skylineTexture = SKTexture(imageNamed: "skyline")
    let cloudsTexture = SKTexture(imageNamed: "clouds")
    
    override func didMove(to view: SKView) {
        
        // Setup world physics
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
        // Setup sky color
        skyColor = SKColor(displayP3Red: 135/255, green: 206/255, blue: 250/255, alpha: 1)
        self.backgroundColor = skyColor
        
        movingNode = SKNode()
        self.addChild(movingNode)
        menuNode = SKNode()
        menuNode.zPosition = 1
        self.addChild(menuNode)
        
        // Setup logo and menu buttons
        logoTexture.filteringMode = .nearest
        logoSprite = SKSpriteNode(texture: logoTexture)
        logoSprite.size.width = 720
        logoSprite.size.height = 300
        logoSprite.position = CGPoint(x: 0, y: -(self.frame.size.height / 2.5) + skylineTexture.size().height * 2.6)
        menuNode.addChild(logoSprite)
        
        startBtnTexture.filteringMode = .nearest
        startBtnSprite = SKSpriteNode(texture: startBtnTexture)
        startBtnSprite.name = "start"
        startBtnSprite.size.width = 257
        startBtnSprite.size.height = 128
        startBtnSprite.zPosition = 2
        startBtnSprite.position = CGPoint(x: 170, y: -(self.frame.size.height / 2.4))
        menuNode.addChild(startBtnSprite)
        
        customiseBtnTexture.filteringMode = .nearest
        customiseBtnSprite = SKSpriteNode(texture: customiseBtnTexture)
        customiseBtnSprite.name = "customise"
        customiseBtnSprite.size.width = 257
        customiseBtnSprite.size.height = 128
        customiseBtnSprite.zPosition = 2
        customiseBtnSprite.position = CGPoint(x: -170, y: -(self.frame.size.height / 2.4))
        menuNode.addChild(customiseBtnSprite)
        
        infoBtnTexture.filteringMode = .nearest
        infoBtnSprite = SKSpriteNode(texture: infoBtnTexture)
        infoBtnSprite.name = "info"
        infoBtnSprite.size.width = 100
        infoBtnSprite.size.height = 100
        infoBtnSprite.zPosition = 2
        infoBtnSprite.position = CGPoint(x: 300, y: 550)
        menuNode.addChild(infoBtnSprite)
        
        
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
            groundSprite.zPosition = -20
            groundSprite.position = CGPoint(x: i * groundSprite.size.width, y: -(self.frame.size.height / 2.4))
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
        cloudsTexture.filteringMode = .nearest
        let moveClouds = SKAction.moveBy(x: -cloudsTexture.size().width * 3.0, y: 0,
                                         duration: TimeInterval(0.03 * cloudsTexture.size().width * 3.0))
        let resetClouds = SKAction.moveBy(x: cloudsTexture.size().width * 3.0, y: 0, duration: 0.00)
        let moveCloudsForever = SKAction.repeatForever(SKAction.sequence([moveClouds, resetClouds]))
        
        for i in 0...3 + Int(self.frame.size.width / (cloudsTexture.size().width * 3)) {
            let i = CGFloat(i)
            cloudSprite = SKSpriteNode(texture: cloudsTexture)
            cloudSprite.zPosition = -20
            cloudSprite.position = CGPoint(x: i * cloudSprite.size.width,
                                           y: -(self.frame.size.height / 2.5) + skylineTexture.size().height * 3.15)
            cloudSprite.run(moveCloudsForever)
            movingNode.addChild(cloudSprite)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: menuNode);
            if atPoint(location).name ==  "info" {
                if let scene = InformationScene(fileNamed: "Information") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene)
                }
            } else if atPoint(location).name == "start" {
                if let scene = GameplayScene(fileNamed: "Gameplay") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene)
                }
            } else if atPoint(location).name == "customise" {
                if let scene = CustomiserScene(fileNamed: "Customiser") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene)
                }
            }
        }
    }
}
