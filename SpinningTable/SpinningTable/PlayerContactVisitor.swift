//
//  PlayerContactVisitor.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import Foundation
import SpriteKit
class PlayerContactVisitor:ContactVisitor
{
    func visitPlayer(body:SKPhysicsBody)
    {
        let first = self.body.node
        let second = body.node
    }
    
    func visitShuriken(body:SKPhysicsBody)
    {
        let first = self.body.node as Player
        let second = body.node
        if Info.life == 1
        {
            second.removeFromParent()
            first.life = false
            Info.life = 0
        }
        else if Info.life > 1
        {
            second.removeFromParent()
            Info.life--
        }
        else
        {
            Info.gameOver = true
        }
    }
    
    func visitFood(body:SKPhysicsBody)
    {
        let first = self.body.node
        let second = body.node
        second.removeFromParent()
        Info.score += 2
    }
    
    func visitLife(body:SKPhysicsBody)
    {
        let first = self.body.node as Player
        let second = body.node
        second.removeFromParent()
        first.life = true
        Info.score++
        Info.life++
    }
}