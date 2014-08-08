//
//  ContactVisitor.swift
//  SpinningTable
//
//  Created by Sally Ouyang on 2014-08-06.
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
    class func contactVisitorWithBody(body:SKPhysicsBody,forContact contact:SKPhysicsContact)->ContactVisitor!
    {
        if body.categoryBitMask & playerCategory != 0 {
            return PlayerContactVisitor(body: body, forContact: contact)
        }
        else if body.categoryBitMask & shurikenCategory != 0 {
            return ShurikenContactVisitor(body: body, forContact: contact)
        }
        else if body.categoryBitMask & foodCategory != 0 {
            return FoodContactVisitor(body: body, forContact: contact)
        }
        else if body.categoryBitMask & lifeCategory != 0 {
            return LifeContactVisitor(body: body, forContact: contact)
        }
        return nil
    }
    
    init(body:SKPhysicsBody, forContact contact:SKPhysicsContact)
    {
        self.body = body
        self.contact = contact
        super.init()
    }
    
    //second part of the double dispatch by sending a message named after the second physics body in the contact to the newly constructed ContactVisitor subclass instance which is named after the first body in the contact
    func visitBody(body:SKPhysicsBody)
    {
        var contactSelectorString = "visit" + body.node.name + ":"
        let selector = NSSelectorFromString(contactSelectorString)
        if self.respondsToSelector(selector)
        {
            dispatch_after(0, dispatch_get_main_queue(),
                {
                    NSThread.detachNewThreadSelector(selector, toTarget:self, withObject: body)
                })
        }
    }
}
