//
//  Player.swift
//  MainGame
//
//  Created by Abhinav Mara on 12/22/21.
//

import SpriteKit

class Player1: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Player")
    
    var health = 50
    
    var exploded = false
    
    var initialSize: CGSize = CGSize(width: 50, height: 50)
    
    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        self.texture = textureAtlas.textureNamed("player1")
        self.name = "Player1"
        
        self.physicsBody = SKPhysicsBody(texture: textureAtlas.textureNamed("player1"), size: initialSize)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 10
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.player1.rawValue
        
    }
    
    func onTap() {}
    
    func movement(forward: Bool, rotateLeft: Bool, rotateRight: Bool) {
        if forward && rotateLeft {
            self.zRotation += 0.2
            self.physicsBody?.applyForce(CGVector(dx: cos(self.zRotation)*7500, dy: sin(self.zRotation)*7500))
        }
        
        else if forward && rotateRight {
            self.zRotation -= 0.2
            self.physicsBody?.applyForce(CGVector(dx: cos(self.zRotation)*7500, dy: sin(self.zRotation)*7500))
        }
        
        else if forward {
            self.physicsBody?.applyForce(CGVector(dx: cos(self.zRotation)*7500, dy: sin(self.zRotation)*7500))
        }
        
        else if rotateLeft {
            self.zRotation += 0.2
        }
        
        else if rotateRight {
            self.zRotation -= 0.2
        }
        
        else if !forward {
            self.physicsBody?.linearDamping = 3
        }
    }
    
    func takeDamage() {
        self.health -= (Int(arc4random_uniform(9))+1)
        print("Health of \(self.name!):  \(self.health)")
    }
    
    func explode(gameScene: GameScene) {
        if exploded { return }
        exploded = true
        
        gameScene.particlePool.placeEmitter(node: self, emitterType: "player1")
        SKAction.run(SKAction.wait(forDuration: 0.5), onChildWithName: "emitter")
        
        self.run(SKAction.fadeAlpha(to: 0, duration: 0.1))
        
        self.physicsBody?.categoryBitMask = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
