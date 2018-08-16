//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Sophie Berger on 14.08.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func createAccountPressed(_ sender: Any) {
        //To register a user only email/password is needed
        //guard let = another way of force unwrapping optionals
        //text field values are optional by default
        guard let email = emailTxt.text , emailTxt.text != "" else { return}
        guard let pass = passTxt.text , passTxt.text != "" else { return}
        
        //Calling 1st required API func
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                //calling 2nd required API func
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        print("Logged in user!", AuthService.instance.authToken)
                    }
                })
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    

  

}
