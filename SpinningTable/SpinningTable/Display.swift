//
//  Display.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-06.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit
import UIKit

protocol DisplayData
{
    func updateData()
    func levelUp()
    func gameOver()
    func replay()
}

class Display: SKNode ,DisplayData
{
    let scoreLabel = SKLabelNode(text: "SCORE \(Data.score)")
    let levelLabel = SKLabelNode(text: "LEVEL \(Data.level)")
    let lifeLabel = SKLabelNode(text: "LIFE \(Data.life)")
    let bestScoreLabel = SKLabelNode(text: "BEST SCORE \(Data.bestScore)")
    let gameOverLabel = SKLabelNode(text: "GAME OVER")
    let share = Share()
    let replayDisplay = Replay()
    
    init()
    {
        super.init()
        scoreLabel.fontName = "Helvetica"
        levelLabel.fontName = "Helvetica"
        lifeLabel.fontName = "Helvetica"
        self.addChild(scoreLabel)
        self.addChild(levelLabel)
        self.addChild(lifeLabel)
    }
    
    func setPosition()
    {
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.scene.frame), CGRectGetMaxY(self.scene.frame)/14)
        bestScoreLabel.position = CGPointMake(CGRectGetMidX(self.scene.frame), CGRectGetMinY(self.scene.frame))
        levelLabel.position = CGPointMake(CGRectGetMidX(self.scene.frame), 4*CGRectGetMaxY(self.scene.frame)/5)
        lifeLabel.position = CGPointMake(CGRectGetMidX(self.scene.frame), CGRectGetMaxY(self.scene.frame)/7)
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.scene.frame), CGRectGetMidY(self.scene.frame))
        share.position = CGPointMake(CGRectGetMaxX(self.scene.frame)*3/4, CGRectGetMaxY(self.scene.frame)/3)
        replayDisplay.position = CGPointMake(CGRectGetMaxX(self.scene.frame)/4, CGRectGetMaxY(self.scene.frame)/3)
    }
    
    func updateData()
    {
        scoreLabel.text = "SCORE \(Data.score)"
        levelLabel.text = "LEVEL \(Data.level)"
        lifeLabel.text = "LIFE \(Data.life)"
    }
    
    func levelUp()
    {
        levelLabel.runAction(SKAction.sequence([SKAction.scaleTo(1.5, duration: 0.5),SKAction.scaleTo(1, duration: 0.5)]))
        (self.scene as GameScene).speedUp()
    }
    
    func gameOver()
    {
        gameOverLabel.fontSize = 50
        gameOverLabel.fontColor = UIColor.redColor()
        gameOverLabel.fontName = "Helvetica"
        share.fontName = "Helvetica"
        replayDisplay.fontName = "Helvetica"
        bestScoreLabel.fontName = "Helvetica"
        bestScoreLabel.text = "BEST SCORE \(Data.bestScore)"
        self.addChild(gameOverLabel)
        self.addChild(share)
        self.addChild(replayDisplay)
        self.addChild(bestScoreLabel)
        (self.scene as GameScene).overGame()
    }
    
    func replay()
    {
        gameOverLabel.removeFromParent()
        share.removeFromParent()
        replayDisplay.removeFromParent()
        bestScoreLabel.removeFromParent()
        (self.scene as GameScene).restartGame()
    }
}

