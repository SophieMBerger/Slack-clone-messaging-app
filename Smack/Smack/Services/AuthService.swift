//
//  AuthService.swift
//  Smack
//
//  Created by Sophie Berger on 16.08.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import Foundation
import Alamofire

//handels all login/create/register user functions

class AuthService {
    //singleton
    static let instance = AuthService()
    
    //variables that will persist even after user stops using the app
    //UserDefaults holds the above data, simplest way of saving data
    let defaults = UserDefaults.standard
    
    
    //below variables will be persistant accross app launches
    
    //creating methods for a variable
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    
    var authToken : String {
        get { //casting the token as a String
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    
    //register user function uses AlamoFire
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        //creating a header
        //creating JSON object
        let header = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        //creating body (JSON object with multiple key-value pairs)
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        //create web-request with response
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            
            if response.result.error == nil {
                completion(true) //custom completion handler from func parameters
            }else {
                completion(false)
                debugPrint(response.result.error as Any) //prints out the error as any data type
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
