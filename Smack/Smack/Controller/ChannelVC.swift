//
//  ChannelVC.swift
//  Smack
//
//  Created by Sophie Berger on 14.08.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customize rear view reveal width
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60

    }

    

}
