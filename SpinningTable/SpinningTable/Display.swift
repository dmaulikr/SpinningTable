//
//  Display.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit
import UIKit
protocol ShowInfo
{
    func updateInfo()
    func levelUp()
    func gameOver()
    func replay()
}
class Display: SKNode ,ShowInfo
{
    let scoreLabel = SKLabelNode(text: "SCORE \(Info.score)")
    let levelLabel = SKLabelNode(text: "LEVEL \(Info.level)")
    let lifeLabel = SKLabelNode(text: "LIFE \(Info.life)")
    let bestScoreLabel = SKLabelNode(text: "BEST SCORE \(Info.bestScore)")
    let gameOverLabel = SKLabelNode(text: "GAME OVER")
    let share = Share()
    let replayDisplay = Replay()
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    override init()
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
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.scene!.frame), CGRectGetMaxY(self.scene!.frame)/9)
        bestScoreLabel.position = CGPointMake(CGRectGetMidX(self.scene!.frame), CGRectGetMinY(self.scene!.frame))
        levelLabel.position = CGPointMake(CGRectGetMidX(self.scene!.frame), 4*CGRectGetMaxY(self.scene!.frame)/5)
        lifeLabel.position = CGPointMake(CGRectGetMidX(self.scene!.frame), CGRectGetMaxY(self.scene!.frame)/5)
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.scene!.frame), CGRectGetMidY(self.scene!.frame))
        share.position = CGPointMake(CGRectGetMaxX(self.scene!.frame)*3/4, CGRectGetMaxY(self.scene!.frame)/3)
        replayDisplay.position = CGPointMake(CGRectGetMaxX(self.scene!.frame)/4, CGRectGetMaxY(self.scene!.frame)/3)
    }
    
    func updateInfo()
    {
        scoreLabel.text = "SCORE \(Info.score)"
        levelLabel.text = "LEVEL \(Info.level)"
        lifeLabel.text = "LIFE \(Info.life)"
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
        bestScoreLabel.text = "BEST SCORE \(Info.bestScore)"
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
