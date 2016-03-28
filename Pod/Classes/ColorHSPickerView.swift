//
//  ColorHSPickerView.swift
//  ColorPicker
//
//  Created by PC on 3/26/16.
//  Copyright © 2016 Randel Smith. All rights reserved.
//

import UIKit

public class ColorHSPickerView: UIControl {
    var thumbView : UIControl
    
    private var color : UIColor!
    private var lastPoint : CGPoint?
    
    public var currentColor : UIColor! {
        get{
            if let c = self.color {
                return c
            }
        return nil
            
        }

        set(newColor){
            
            
            if let color = newColor {
                var h : CGFloat = 0
                var s : CGFloat = 0
                
                color.getHue(&h, saturation: &s, brightness: nil, alpha: nil)
                
                self.color = UIColor(hue: h, saturation: s, brightness: 1, alpha: 1)
                self.thumbView.backgroundColor = self.color!
                
                self.thumbView.center = self.pointWithPadding(self.pointFromColor(color), padding: 20)
            }
            
            
            
            
            
            
//            }
            
            
           
        }
    }
    var contentView : UIView
    
    var colorMapImageView : UIImageView
    
//    override func didMoveToWindow(){
//        if let newColor = self.color{
//            self.thumbView.center = self.pointWithPadding(self.pointFromColor(newColor), padding: 20)
//        }
//    }
    
    
    init (color: UIColor = UIColor.redColor()){
        self.thumbView = UIButton.init(frame: CGRect(x: 0, y: 0, width: 60, height: 80))
        self.thumbView.userInteractionEnabled = false
        
        self.contentView = UIView.init(frame: CGRect(x: 0, y: 0, width: 60, height: 80))
        
        self.colorMapImageView = UIImageView(image: UIImage(named: "colormap"))
        

        super.init(frame: CGRect.zero)
        
        self.addSubview(self.thumbView)
        self.contentView.addSubview(self.colorMapImageView)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.thumbView = ThumbViewControl(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        self.thumbView.backgroundColor = UIColor.blackColor()
        self.thumbView.layer.cornerRadius = self.thumbView.frame.width / 2
        self.thumbView.layer.borderColor = UIColor(white: 0.9, alpha: 0.8).CGColor
        self.thumbView.layer.borderWidth = 2
        self.thumbView.layer.shadowColor = UIColor.blackColor().CGColor
        self.thumbView.layer.shadowOffset = CGSizeZero;
        self.thumbView.layer.shadowRadius = 1;
        self.thumbView.layer.shadowOpacity = 0.5;
        
        self.contentView = UIView.init()
        self.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.contentView.userInteractionEnabled = false
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.borderColor = UIColor(white: 0.9, alpha: 0.8).CGColor
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.shadowColor = UIColor.blackColor().CGColor
        self.contentView.layer.shadowOffset = CGSizeZero;
        self.contentView.layer.shadowRadius = 1;
        self.contentView.layer.shadowOpacity = 0.5;
        
        self.colorMapImageView = UIImageView(image: UIImage(named: "colormap"))
        self.colorMapImageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.colorMapImageView.layer.cornerRadius = 15;
        self.colorMapImageView.layer.masksToBounds = true
        
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.clearColor()

        self.addSubview(self.contentView)
        self.contentView.addSubview(self.colorMapImageView)
        
        self.addSubview(self.thumbView)
        
        self.contentView.frame = CGRect(x: 8, y: 8, width: self.frame.width - 16, height: self.frame.height - 16)
        self.colorMapImageView.frame = CGRect(x: 0, y: 0, width: self.colorMapImageView.superview!.frame.width, height: self.colorMapImageView.superview!.frame.height)
        
        
    }
    
    public override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)
        
        self.updateWithTouch(touch)
        
        return true
    }
    
    public override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        
        self.updateWithTouch(touch)
        
        self.sendActionsForControlEvents(.ValueChanged)
        
        return true
    }
    
    public override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
        
        if let newTouch = touch {
            self.updateWithTouch(newTouch)
            
            if CGRectContainsPoint(self.bounds, newTouch.locationInView(self)){
                self.sendActionsForControlEvents(.TouchUpInside)
            }
        }
        
    }
    
    private func pointWithPadding(point: CGPoint, padding: CGFloat) -> CGPoint {
        var x : CGFloat = point.x
        if point.x < padding {
            x = padding
        } else if point.x > self.frame.size.width - padding {
            x = self.frame.size.width - padding
        }
        
        var y : CGFloat = point.y
        if point.y < padding {
            y = padding
        } else if point.y > self.frame.size.height - padding{
            y = self.frame.size.height - padding
        }
        
        return CGPoint(x: x, y: y)
    }
    
    private func colorFromPoint(point: CGPoint) -> UIColor{
        
        
        var hue = point.x/self.frame.size.width
        if hue <= 0 {
            hue = 0.00001
        }
        
        var sat = 1 - point.y/self.frame.size.height
        if sat <= 0 {
            sat = 0.00001
        }
        
        
        return UIColor(hue: hue, saturation: sat, brightness: 1, alpha: 1)
    }
    
    private func pointFromColor(color : UIColor) -> CGPoint {
        
        var h : CGFloat = 0
        var s : CGFloat = 0
        
        color.getHue(&h, saturation: &s, brightness: nil, alpha: nil)
        
        let x = h * self.frame.width
        
        let y = ((s * self.frame.height) - self.frame.height) * -1        
        return CGPoint(x: x, y: y)
    
    }
    
    private func updateWithTouch(touch: UITouch) {
        
        self.updateWithPoint(touch.locationInView(self))
        
        
        }
    
    private func updateWithPoint(point: CGPoint){
        let color = self.colorFromPoint(point)
        var h : CGFloat = 0
        var s : CGFloat = 0
        
        color.getHue(&h, saturation: &s, brightness: nil, alpha: nil)
        
        self.thumbView.center = self.pointWithPadding(point, padding: 20)
        self.thumbView.backgroundColor = color;
        self.color = color
    }

}
