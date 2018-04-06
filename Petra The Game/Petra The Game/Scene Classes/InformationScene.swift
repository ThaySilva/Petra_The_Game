//
//  InformationScene.swift
//  Petra The Game
//
//  Created by Thaynara Silva on 05/04/2018.
//  Copyright © 2018 Thaynara Silva. All rights reserved.
//

import SpriteKit

class InformationScene: SKScene {
    
    var mainNode: SKNode!
    
    var backgroundSprite: SKSpriteNode!
    var menuBtnSprite: SKSpriteNode!
    var startBtnSprite: SKSpriteNode!
    
    let backgroundTexture = SKTexture(imageNamed: "informationBackground")
    let menuBtnTexture = SKTexture(imageNamed: "menuBtn")
    let startBtnTexture = SKTexture(imageNamed: "startBtn")
    
    override func didMove(to view: SKView) {
        
        mainNode = SKNode()
        self.addChild(mainNode)
        
        // Setup background
        backgroundTexture.filteringMode = .nearest
        backgroundSprite = SKSpriteNode(texture: backgroundTexture)
        backgroundSprite.zPosition = 0
        backgroundSprite.position = CGPoint(x: 0.0, y: 0.0)
        mainNode.addChild(backgroundSprite)
        
        // Setup buttons
        menuBtnTexture.filteringMode = .nearest
        menuBtnSprite = SKSpriteNode(texture: menuBtnTexture)
        menuBtnSprite.name = "menu"
        menuBtnSprite.zPosition = 2
        menuBtnSprite.position = CGPoint(x: -170, y: -(self.frame.size.height / 2.4))
        mainNode.addChild(menuBtnSprite)
        
        startBtnTexture.filteringMode = .nearest
        startBtnSprite = SKSpriteNode(texture: startBtnTexture)
        startBtnSprite.name = "start"
        startBtnSprite.zPosition = 2
        startBtnSprite.position = CGPoint(x: 170, y: -(self.frame.size.height / 2.4))
        mainNode.addChild(startBtnSprite)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: mainNode)
            if atPoint(location).name == "menu" {
                if let scene = MainMenuScene(fileNamed: "MainMenu") {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            } else if atPoint(location).name == "start" {
                if let scene = GameplayScene(fileNamed: "Gameplay") {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            }
        }
    }
}
