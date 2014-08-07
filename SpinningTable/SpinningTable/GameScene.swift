//
//  GameScene.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-06.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit

class GameScene: SKScene ,SKPhysicsContactDelegate{
    var player:Player
    let map:Map
    let display:Display
    init(size:CGSize)
    {
        let center = CGPointMake(size.width/2, size.height/2)
        player = Player()
        map = Map(origin:center, layer: 5)
        display = Display()
        super.init(size:size)
        //WHY YOU NO WORK.
        //let bgImage = SKSpriteNode(imageNamed: "bg.png")
        //bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        //self.addChild(bgImage)
        player.position = map.points[player.posLine]
        Data.display = display
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        map.alpha = 0.8
        self.addChild(map)
        self.addChild(player)
        self.addChild(display)
        display.setPosition()
        player.runOnMap(map)
        generatePlayers()
        
    }
    
    override func didMoveToView(view: SKView)
    {
        /* Setup your scene here */
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        for touch:AnyObject in touches
        {
            if player.posLine>3
            {
                newPosition()
                player.runOnMap(map)
            }
        }
    }
    
    func overGame()
    {
        map.alpha = 0.1
        for stuff in self.children
        {
            if let object = stuff as? Object
            {
                object.alpha = 0.1
            }
        }
        
    }
    
    func restartGame()
    {
        for stuff in self.children
        {
            if let object = stuff as? Object
            {
                if object.name!=="Shuriken"||object.name!=="Food"||object.name!=="Life"
                {
                    object.removeFromParent()
                }
            }
            
        }
        map.alpha = 0.8
        Data.replay()
        player.replay(map)
    }
    
    func newPosition()
    {
        let scale = CGFloat((player.posLine/4-1)*2+1)/CGFloat(player.posLine/4*2+1)
        let newLength = player.leftoverLength(map)*scale
        player.posLine-=4
        player.removeAllActions()
        let next = map.points[player.posLine+1]
        if !Data.gameOver
        {
            switch player.posLine%4
                {
            case 0:
                player.position = CGPointMake(next.x, next.y+newLength)
            case 1:
                player.position = CGPointMake(next.x+newLength, next.y)
            case 2:
                player.position = CGPointMake(next.x, next.y-newLength)
            case 3:
                player.position = CGPointMake(next.x-newLength, next.y)
            default:
                println("this better not appear")
            }
        }
    }
    
    func generatePlayers(){
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.runBlock(
            {
                if !Data.gameOver
                {
                    let type = arc4random()%UInt32(6)
                    var random:AnyObject!
                    if type == 0
                    {
                        random = Life()
                    }
                    else if type == 2 || type == 3
                    {
                        random = Food()
                    }
                    else
                    {
                        random = Shuriken()
                    }
                    var object = random as Object
                    object.posLine = 0
                    object.position = self.map.points[object.posLine]
                    object.runOnMap(self.map)
                    self.addChild(object)
                }
            }),SKAction.waitForDuration(5, withRange: 1)])))
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
    }
    
    override func didSimulatePhysics()
    {
        if Data.gameOver
        {
            for node in self.children
            {
                (node as SKNode).removeAllActions()
            }
        }
    }
    
    func speedUp()
    {
        for stuff in self.children
        {
            if let object = stuff as? Object //downcasting
            {
                object.removeAllActions()
                object.movingSpeed += CGFloat(Data.speedMultiple) * object.movingSpeed
                object.runOnMap(map)
            }
        }
    }
    
    //SKPhysicsContactDelegate
    func didBeginContact(contact:SKPhysicsContact)
    {
        let firstVisitor = ContactVisitor.contactVisitorWithBody(contact.bodyA, forContact: contact)
        let secondVisitor = ContactVisitor.contactVisitorWithBody(contact.bodyB, forContact: contact)
        
        let firstVisitableBody = VisitableBody(body: contact.bodyA)
        let secondVisitableBody = VisitableBody(body: contact.bodyB)
        
        secondVisitableBody.acceptVisitor(firstVisitor)
        firstVisitableBody.acceptVisitor(secondVisitor)
    }
}
