//
//  Share.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-06.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit

class Share: SKLabelNode {
    init() {
        super.init()
        self.userInteractionEnabled = true
        self.text = "SHARE"
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!)
    {
        let gameScene = nodeToImage(self.scene)
        let message = "I scored \(Data.score) points in Spinning Table, join me and play!"
        let shareItems = [gameScene,message]
        let shareController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        (scene.view.nextResponder() as UIViewController).presentViewController(shareController, animated: true, completion: nil)
    }
    
    func viewToImage(view:UIView)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0);
        view.drawViewHierarchyInRect(view.bounds,afterScreenUpdates:true)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext(); //clean up
        return screenShot;
    }
    //grabbing a node into UIImage
    func nodeToImage(node:SKNode)->UIImage
    {
        let tex = self.scene.view.textureFromNode(node)
        let view  = SKView(frame: CGRectMake(0, 0, tex.size().width, tex.size().height))
        let scene = SKScene(size: tex.size())
        let frame  = SKSpriteNode(texture: tex)
        frame.position = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame));
        scene.addChild(frame)
        view.presentScene(scene)
        return self.viewToImage(view)
    }
}
