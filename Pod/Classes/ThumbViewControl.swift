//
//  ThumbViewControl.swift
//  ColorPicker
//
//  Created by PC on 3/26/16.
//  Copyright © 2016 Randel Smith. All rights reserved.
//

import UIKit

public class ThumbViewControl: UIControl {

    public override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)

        if let superview = self.superview{
            if superview.isKindOfClass(UIControl){
               let control = superview as! UIControl
                control .beginTrackingWithTouch(touch, withEvent: event)
            }
        }
        
        
        return true
    }
    
    public override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)

        if let superview = self.superview{
            if superview.isKindOfClass(UIControl){
                let control = superview as! UIControl
                control .continueTrackingWithTouch(touch, withEvent: event)
            }
        }
        return true
    }
    
    public override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
        
        if let superview = self.superview{
            if superview.isKindOfClass(UIControl){
                let control = superview as! UIControl
                control .endTrackingWithTouch(touch, withEvent: event)
            }
        }
    }

}
