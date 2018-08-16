//
//  RoundedButton.swift
//  Smack
//
//  Created by Sophie Berger on 16.08.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    //able to change corner radius i storyboard
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    override func awakeFromNib() {
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
    //so that storyboard looks like run-time
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
}
