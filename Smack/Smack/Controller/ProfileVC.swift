//
//  ProfileVC.swift
//  Smack
//
//  Created by Sophie Berger on 17.08.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var newUsernameTxt: UITextField!
    @IBOutlet weak var setBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupView() {
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        setBtn.isHidden = true
    }
    
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    

    
    @IBAction func newUsernameTxtEditChanged(_ sender: Any) {
        setBtn.isHidden = false
        //        value of text field changes correctly
    }
    
    
    @IBAction func setBtnPressed(_ sender: Any) {
        
            guard let newUsername = newUsernameTxt.text, newUsernameTxt.text != "" else {return}
        
        //username value is correctly set to newUsernameTxt.text here
        
            AuthService.instance.changeUsername(newUsername: newUsername) { (success) in
                
                // UserdataService.instance.name value not re-set correctly here  --> problem woth changeUsername func above
                
                if success {
                    self.newUsernameTxt.text = ""
                    self.newUsernameTxt.resignFirstResponder()
                    self.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)

                }
    }
    
}
}

