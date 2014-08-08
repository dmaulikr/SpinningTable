//
//  Info.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-06.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import Foundation

struct Info{
    static var display:ShowInfo?
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
        display?.updateInfo()
    }
    }
    static var bestScore:Int = 0
    static var gameOver:Bool = false
        {
        willSet
    {
        if newValue
        {
            let original = NSUserDefaults.standardUserDefaults()
            Info.bestScore = original.integerForKey("bestScore")
            if Info.bestScore < Info.score
            {
                Info.bestScore = Info.score
                original.setInteger(Info.score, forKey: "bestScore")
                original.synchronize()
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
        display?.updateInfo()
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
        display?.updateInfo()
    }
    }
    static var speedMultiple:Float = 0
    static var begin:Bool = false
    static func replay()
    {
        Info.changeLevel = 5
        Info.score = 0
        Info.level = 1
        Info.speedMultiple = 0
        Info.life = 0
        Info.begin = true
    }
}