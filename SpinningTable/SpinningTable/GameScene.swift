//
//  GameScene.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit

class GameScene: SKScene ,SKPhysicsContactDelegate{
    var player:Player
    let map:Map
    let display:Display
    override init(size:CGSize)
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
        Info.display = display
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
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func speedUp()
    {
        for stuff in self.children
        {
            if let object = stuff as? Object //downcasting
            {
                object.removeAllActions()
                object.movingSpeed += CGFloat(Info.speedMultiple) * object.movingSpeed
                object.runOnMap(map)
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
        Info.replay()
        player.replay(map)
    }
    
    func newPosition()
    {
        let scale = CGFloat((player.posLine/4-1)*2+1)/CGFloat(player.posLine/4*2+1)
        let newLength = player.leftoverLength(map)*scale
        player.posLine-=4
        player.removeAllActions()
        let next = map.points[player.posLine+1]
        if !Info.gameOver
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
                if !Info.gameOver
                {
                    let type = arc4random()%UInt32(6)
                    var random:AnyObject!
                    if type == 1
                    {
                        random = Life()
                    }
                    else if type == 0 || type == 3
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
        if Info.gameOver
        {
            for node in self.children
            {
                (node as SKNode).removeAllActions()
            }
        }
    }
    
    func viewToImage(view:UIView)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0);
        view.drawViewHierarchyInRect(view.bounds,afterScreenUpdates:true)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext(); //clean up
        return screenShot;
    }
    
    //grabbing a node into UIImage
    func nodeToImage(node:SKNode)->UIImage
    {
        let tex = self.scene!.view!.textureFromNode(node)
        let view  = SKView(frame: CGRectMake(0, 0, tex.size().width, tex.size().height))
        let scene = SKScene(size: tex.size())
        let frame  = SKSpriteNode(texture: tex)
        frame.position = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame));
        scene.addChild(frame)
        view.presentScene(scene)
        return self.viewToImage(view)
    }
    
    //SKPhysicsContactDelegate
    func didBeginContact(contact:SKPhysicsContact)
    {
        let firstVisitor = ContactVisitor.touchBody(contact.bodyA, forContact: contact)
        let secondVisitor = ContactVisitor.touchBody(contact.bodyB, forContact: contact)
        
        let firstVisitableBody = VisitableBody(touch: contact.bodyA)
        let secondVisitableBody = VisitableBody(touch: contact.bodyB)
        
        secondVisitableBody.acceptVisitor(firstVisitor)
        firstVisitableBody.acceptVisitor(secondVisitor)
    }
}
