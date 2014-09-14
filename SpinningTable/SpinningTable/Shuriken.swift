//
//  Shuriken.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit

class Shuriken: Object
{
    convenience init()
    {
        self.init(name:"Shuriken",image:"shuriken")
        self.physicsBody!.categoryBitMask = shurikenCategory
    }
}
