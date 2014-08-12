//
//  VisitableBody.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import Foundation
import SpriteKit

class VisitableBody
{
    let body:SKPhysicsBody
    init(touch:SKPhysicsBody)
    {
        self.body = touch
    }
    
    func acceptVisitor(contact:ContactVisitor)
    {
        contact.touch(body)
    }
}