//
//  CustomiserScene.swift
//  Petra The Game
//
//  Created by Thaynara Silva on 05/04/2018.
//  Copyright © 2018 Thaynara Silva. All rights reserved.
//

import SpriteKit

class CustomiserScene: SKScene {
    
    var mainNode: SKNode!
    
    var backgroundSprite: SKSpriteNode!
    var menuBtnSprite: SKSpriteNode!
    var startBtnSprite: SKSpriteNode!
    var redBtnSprite: SKSpriteNode!
    var orangeBtnSprite: SKSpriteNode!
    var yellowBtnSprite: SKSpriteNode!
    var purpleBtnSprite: SKSpriteNode!
    var petraSprite: SKSpriteNode!
    
    let backgroundTexture = SKTexture(imageNamed: "customiserBackground")
    let menuBtnTexture = SKTexture(imageNamed: "menuBtn")
    let startBtnTexture = SKTexture(imageNamed: "startBtn")
    let redTexture = SKTexture(imageNamed: "redBtn")
    let orangeTexture = SKTexture(imageNamed: "orangeBtn")
    let yellowTexture = SKTexture(imageNamed: "yellowBtn")
    let purpleTexture = SKTexture(imageNamed: "purpleBtn")
    let petraTexture = SKTexture(imageNamed: "Petra_1")
    
    override func didMove(to view: SKView) {
        
        mainNode = SKNode()
        self.addChild(mainNode)
        
        // Setup background
        backgroundTexture.filteringMode = .nearest
        backgroundSprite = SKSpriteNode(texture: backgroundTexture)
        backgroundSprite.zPosition = 0
        backgroundSprite.position = CGPoint(x: 0.0, y: 0.0)
        mainNode.addChild(backgroundSprite)
        
        // Setup color buttons
        redTexture.filteringMode = .nearest
        redBtnSprite = SKSpriteNode(texture: redTexture)
        redBtnSprite.name = "red"
        redBtnSprite.zPosition = 2
        redBtnSprite.position = CGPoint(x: -200, y: -230)
        mainNode.addChild(redBtnSprite)
        
        orangeTexture.filteringMode = .nearest
        orangeBtnSprite = SKSpriteNode(texture: orangeTexture)
        orangeBtnSprite.name = "orange"
        orangeBtnSprite.zPosition = 2
        orangeBtnSprite.position = CGPoint(x: -70, y: -230)
        mainNode.addChild(orangeBtnSprite)
        
        yellowTexture.filteringMode = .nearest
        yellowBtnSprite = SKSpriteNode(texture: yellowTexture)
        yellowBtnSprite.name = "yellow"
        yellowBtnSprite.zPosition = 2
        yellowBtnSprite.position = CGPoint(x: 70, y: -230)
        mainNode.addChild(yellowBtnSprite)
        
        purpleTexture.filteringMode = .nearest
        purpleBtnSprite = SKSpriteNode(texture: purpleTexture)
        purpleBtnSprite.name = "purple"
        purpleBtnSprite.zPosition = 2
        purpleBtnSprite.position = CGPoint(x: 200, y: -230)
        mainNode.addChild(purpleBtnSprite)
        
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
        
        // Setup Petra
        petraTexture.filteringMode = .nearest
        petraSprite = SKSpriteNode(texture: petraTexture)
        petraSprite.zPosition = 2
        petraSprite.position = CGPoint(x: 0, y: 200)
        mainNode.addChild(petraSprite)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: mainNode)
            if atPoint(location).name ==  "menu" {
                if let scene = MainMenuScene(fileNamed: "MainMenu") {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            } else if atPoint(location).name == "start" {
                if let scene = GameplayScene(fileNamed: "Gameplay") {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            } else if atPoint(location).name == "red" {
                petraSprite.texture = SKTexture(imageNamed: "Petra_1_red")
                GameplayScene.changePetraShirt.colour = "red"
            } else if atPoint(location).name == "orange" {
                petraSprite.texture = petraTexture
                GameplayScene.changePetraShirt.colour = "orange"
            } else if atPoint(location).name == "yellow" {
                petraSprite.texture = SKTexture(imageNamed: "Petra_1_yellow")
                GameplayScene.changePetraShirt.colour = "yellow"
            } else if atPoint(location).name == "purple" {
                petraSprite.texture = SKTexture(imageNamed: "Petra_1_purple")
                GameplayScene.changePetraShirt.colour = "purple"
            }
        }
    }

}
