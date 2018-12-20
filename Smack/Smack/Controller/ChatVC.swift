//
//  ChatVC.swift
//  Smack
//
//  Created by Sophie Berger on 14.08.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //action of button is in didLoad
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIControlEvent = what triggers this code
        //Selector = the method inside SWRevealController file that will be fetched
        //#selector = this is a method we will invoke
        //Target = SWRevealViewController
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //adding Gesture recognizers already in SWReveal file
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        //        detects a change in user data
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        //        observes notification that channel was selected
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_Notif:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    
    //    selector for viewDidLoad notification = what happens when user data changes
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            //            get channels
            onLoginGetMessages()
            
        } else {
            channelNameLbl.text = "Please Log In"
        }
    }
    
    //    executed when channel is selected
    @objc func channelSelected(_Notif: Notification){
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLbl.text = "#\(channelName)"
    }

    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                //                do stuff with channels
            }
        }
    }

}
