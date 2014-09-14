//
//  ContactVisitor.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-11.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

import Foundation
import SpriteKit

//Double dispatch method, reference: https://github.com/kouky/iOS-SpriteKit-Pong
class ContactVisitor:NSObject
{
    let body:SKPhysicsBody!
    let contact:SKPhysicsContact!
    
    //first part of the double dispatch, an instance of a class which is named after one of the bodies in the contact
    class func touchBody(touch:SKPhysicsBody,forContact contact:SKPhysicsContact)->ContactVisitor!
    {
        if touch.categoryBitMask & playerCategory != 0 {
            return PlayerContactVisitor(touch: touch, forContact: contact)
        }
        else if touch.categoryBitMask & shurikenCategory != 0 {
            return ShurikenContactVisitor(touch: touch, forContact: contact)
        }
        else if touch.categoryBitMask & foodCategory != 0 {
            return FoodContactVisitor(touch: touch, forContact: contact)
        }
        else if touch.categoryBitMask & lifeCategory != 0 {
            return LifeContactVisitor(touch: touch, forContact: contact)
        }
        return nil
    }
    
    init(touch:SKPhysicsBody, forContact contact:SKPhysicsContact)
    {
        self.body = touch
        self.contact = contact
        super.init()
    }
    
    //second part of the double dispatch by sending a message named after the second physics body in the contact to the newly constructed ContactVisitor subclass instance which is named after the first body in the contact
    func touch(visitor:SKPhysicsBody)
    {
        var visit = "visit" + visitor.node!.name! + ":"
        let string1 = NSSelectorFromString(visit)
        if self.respondsToSelector(string1)
        {
            dispatch_after(0, dispatch_get_main_queue(),
                {
                    NSThread.detachNewThreadSelector(string1, toTarget:self, withObject: visitor)
                })
        }
    }
}

