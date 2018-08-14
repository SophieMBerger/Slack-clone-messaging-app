//
//  GradientView.swift
//  Smack
//
//  Created by Sophie Berger on 14.08.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    //creating variables that can change attributes of UI elements
    
    //creating a colorpicker inside of the storyboard
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        //when we changed something update look of view
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        //when we changed something update look of view
        didSet {
            self.setNeedsLayout()
        }
    }
    
    //when layout is updated (above) this function is automatically called
    override func layoutSubviews() {
        //create gradient layers
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientlayer.startPoint = CGPoint(x: 0, y: 0)
        gradientlayer.endPoint = CGPoint(x: 1, y: 1)
        gradientlayer.frame = self.bounds //gradient as big as VC bounds
        self.layer.insertSublayer(gradientlayer, at: 0) //adding layer to VC view
    }

   
}
