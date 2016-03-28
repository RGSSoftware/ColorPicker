//
//  ViewController.swift
//  ColorPicker
//
//  Created by Randel Smith on 03/28/2016.
//  Copyright (c) 2016 Randel Smith. All rights reserved.
//

import UIKit
import ColorPicker

class ViewController: UIViewController {
    
    var color : UIColor?


    @IBOutlet weak var hsPicker: ColorHSPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.hsPicker.cu =
        self.color = UIColor.brownColor()
        self.hsPicker.currentColor = self.color
    
        self.hsPicker.addTarget(self, action: "buttonClicked:", forControlEvents: .ValueChanged)
    }
    
    func buttonClicked(sender:ColorHSPickerView){
        
        if let color = sender.currentColor {
            self.color = color
            self.view.backgroundColor = self.color
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.hsPicker.currentColor = self.color
        
        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.hsPicker.currentColor = self.color
        
    }

}

