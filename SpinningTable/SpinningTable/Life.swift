//
//  Life.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit

class Life: Object
{
    convenience init()
    {
        self.init(name:"Life",image:"life")
        self.physicsBody!.categoryBitMask = lifeCategory
    }
}
