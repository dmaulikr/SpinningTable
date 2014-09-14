//
//  Object.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//
//

import UIKit
import SpriteKit
import Foundation

class Object: SKSpriteNode
{
    let circle:CGFloat = 10
    var movingSpeed:CGFloat = 50
    var posLine = 0
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    init(name:String,image:String)
    {
        super.init(texture: SKTexture(imageNamed: image),color:SKColor.clearColor(), size: CGSizeMake(circle*2, circle*2))
        self.physicsBody = SKPhysicsBody(circleOfRadius: circle)
        self.physicsBody!.usesPreciseCollisionDetection = true
        self.physicsBody!.collisionBitMask = 0
        self.physicsBody!.contactTestBitMask = playerCategory|shurikenCategory|foodCategory
        movingSpeed += CGFloat(Info.speedMultiple) * self.movingSpeed
        self.name = name
        self.physicsBody!.angularDamping = 0
    }
    
    func runOnMap(map:Map)
    {
        let distance = leftoverLength(map)
        let duration = distance/movingSpeed
        let rotate = SKAction.rotateByAngle(distance/10, duration:(Double)(duration))
        let forward = SKAction.moveTo(map.points[posLine+1], duration:(Double)(duration))
        let group = SKAction.group([rotate,forward])
        self.runAction(group, completion:
            {
                self.posLine++
                if self.posLine==map.points.count-1
                {
                    if self is Player
                    {
                        Info.gameOver = true
                    }
                    if self is Shuriken
                    {
                        self.removeFromParent()
                    }
                    if self is Food
                    {
                        self.removeFromParent()
                    }
                    if self is Life
                    {
                        self.removeFromParent()
                    }
                }
                else
                {
                    self.runOnMap(map)
                }
            })
    }
    
    func leftoverLength(map:Map)->CGFloat
    {
        if self.posLine==map.points.count
        {
            return 0
        }
        switch posLine%4
            {
        case 0:
            return position.y-map.points[posLine+1].y
        case 1:
            return position.x-map.points[posLine+1].x
        case 2:
            return map.points[posLine+1].y-position.y
        case 3:
            return map.points[posLine+1].x-position.x
        default:
            return 0
        }
    }
}
