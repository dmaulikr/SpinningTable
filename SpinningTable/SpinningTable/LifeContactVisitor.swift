//
//  LifeContactVisitor.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-06.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit
//nothing to do here
class LifeContactVisitor: ContactVisitor
{
    func visitPlayer(body:SKPhysicsBody)
    {
        let first = self.body.node
        let second = body.node
    }
    
    func visitShuriken(body:SKPhysicsBody)
    {
        let first = self.body.node
        let second = body.node
    }
    
    func visitFood(body:SKPhysicsBody)
    {
        let first = self.body.node
        let second = body.node
    }
    
    func visitLife(body:SKPhysicsBody)
    {
        let first = self.body.node
        let second = body.node
    }
}
