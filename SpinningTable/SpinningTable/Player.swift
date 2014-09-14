//
//  Player.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit

class Player: Object
{
    var life:Bool = false
    {
    willSet
    {
        if newValue
        {
            self.texture = SKTexture(imageNamed: "happy")
        }
        else
        {
            self.texture = SKTexture(imageNamed: "sad")
        }
        if Info.begin == true //hardcoding ftw
        {
            self.texture = SKTexture(imageNamed: "normal")
        }
    }
    }
    convenience init()
    {
        self.init(name:"Player",image:"normal")
        self.physicsBody!.categoryBitMask = playerCategory
        self.movingSpeed = 70
        self.posLine = 3
    }
    func replay(map:Map)
    {
        self.alpha = 1
        self.removeAllActions()
        self.posLine = 3
        self.movingSpeed = 70
        self.life = false
        Info.begin = false
        self.position = map.points[self.posLine]
        self.runOnMap(map)
    }
}

