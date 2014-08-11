//
//  Map.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import UIKit
import SpriteKit
class Map: SKShapeNode
{
    let spaces:CGFloat = 35
    var points:[CGPoint] = []
    convenience init(origin:CGPoint,layer:CGFloat)
    {
        var x:CGFloat = origin.x
        var y:CGFloat = origin.y
        var line = CGPathCreateMutable()
        self.init()
        CGPathMoveToPoint(line, nil, x, y)
        points.append(CGPointMake(x, y))
        for index in 1..<layer
        {
            y-=spaces*(2*index-1)
            CGPathAddLineToPoint(line, nil , x, y)
            points.append(CGPointMake(x, y))
            
            x-=spaces*(2*index-1)
            CGPathAddLineToPoint(line, nil , x, y)
            points.append(CGPointMake(x, y))
            
            y+=spaces*2*index
            CGPathAddLineToPoint(line, nil , x, y)
            points.append(CGPointMake(x, y))
            
            x+=spaces*2*index
            CGPathAddLineToPoint(line, nil , x, y)
            points.append(CGPointMake(x, y))
        }
        var bgImage = SKSpriteNode(imageNamed: "bg.png")
        self.addChild(bgImage)
        self.strokeColor = SKColor.blueColor()
        self.fillColor = SKColor.whiteColor()
        self.path = line
        self.glowWidth = 0
        self.antialiased = true
        CGPathGetCurrentPoint(path)
    }
}
