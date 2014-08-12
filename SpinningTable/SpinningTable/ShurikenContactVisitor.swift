//
//  ShurikenContactVisitor.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import Foundation
import SpriteKit

//nothing to do here really....
class ShurikenContactVisitor:ContactVisitor
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