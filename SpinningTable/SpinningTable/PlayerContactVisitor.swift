//
//  PlayerContactVisitor.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-06.
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
        if Data.life == 1
        {
            second.removeFromParent()
            first.life = false
            Data.life = 0
        }
        else if Data.life > 1
        {
            second.removeFromParent()
            Data.life--
        }
        else
        {
            Data.gameOver = true
        }
    }
    
    func visitFood(body:SKPhysicsBody)
    {
        let first = self.body.node
        let second = body.node
        second.removeFromParent()
        Data.score += 2
    }
    
    func visitLife(body:SKPhysicsBody)
    {
        let first = self.body.node as Player
        let second = body.node
        second.removeFromParent()
        first.life = true
        Data.score++
        Data.life++
    }
}
