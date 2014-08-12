//
//  Replay.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import SpriteKit

class Replay: SKLabelNode {
    init() {
        super.init()
        self.userInteractionEnabled = true
        self.text = "REPLAY"
    }
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        Info.gameOver = false
    }
}

