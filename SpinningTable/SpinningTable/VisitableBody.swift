//
//  VisitableBody.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-06.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import Foundation
import SpriteKit

class VisitableBody
{
    let body:SKPhysicsBody
    init(body:SKPhysicsBody)
    {
        self.body = body
    }
    
    func acceptVisitor(visitor:ContactVisitor)
    {
        visitor.visitBody(body)
    }
}
