//
//  Data.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-06.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import Foundation

struct Data{
    static var display:DisplayData?
    static var changeLevel:Int = 5
    static var score:Int = 0
        {
        willSet
    {
        if newValue>=changeLevel
    {
        changeLevel+=5 * ++level //level is only changed when the score satifies this
        }
        }
        didSet
    {
        display?.updateData()
    }
    }
    static var bestScore:Int = 0
    static var gameOver:Bool = false
        {
        willSet
    {
        if newValue
        {
            let standardDefaults = NSUserDefaults.standardUserDefaults()
            Data.bestScore = standardDefaults.integerForKey("bestScore")
            if Data.bestScore < Data.score
            {
                Data.bestScore = Data.score
                standardDefaults.setInteger(Data.score, forKey: "bestScore")
                standardDefaults.synchronize()
            }
            display?.gameOver()
        }
        else
        {
            display?.replay()
        }
    }
    }
    static var life:Int=0
        {
        didSet
    {
        display?.updateData()
    }
    }
    static var level:Int = 1
        {
        willSet
    {
        speedMultiple = Float(newValue)*0.1
        if newValue != 1
    {
        display?.levelUp()
        }
        }
        didSet
    {
        display?.updateData()
    }
    }
    static var speedMultiple:Float = 0
    static var begin:Bool = false
    static func replay()
    {
        Data.changeLevel = 5
        Data.score = 0
        Data.level = 1
        Data.speedMultiple = 0
        Data.life = 0
        Data.begin = true
    }
}