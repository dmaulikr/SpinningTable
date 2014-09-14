//
//  Food.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit

class Food: Object
{
    convenience init()
    {
        self.init(name:"Food",image:"food")
        self.physicsBody!.categoryBitMask = foodCategory
    }
}

