//
//  Share.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit


class Share: SKLabelNode {
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    override init() {
        super.init()
        self.userInteractionEnabled = true
        self.text = "SHARE"
        
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        let gameScene = self.scene as GameScene
        let pic = gameScene.nodeToImage(gameScene)
        let message = "I scored \(Info.score) points in Spinning Table, join me and play!"
        let shareItems = [pic,message]
        let shareController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        (gameScene.view!.nextResponder() as UIViewController).presentViewController(shareController, animated: true, completion: nil)
    }
}