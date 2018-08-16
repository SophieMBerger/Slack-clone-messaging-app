//
//  AuthService.swift
//  Smack
//
//  Created by Sophie Berger on 16.08.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
        
        
        
        //creating body (JSON object with multiple key-value pairs)
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        //create web-request with String response (required here)
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true) //custom completion handler from func parameters
            }else {
                completion(false)
                debugPrint(response.result.error as Any) //prints out the error as any data type
            }
        }
    }
    
    
    
    
    //Function for loggingin user
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        //creating body (JSON object with multiple key-value pairs)
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        //Web-request with JSON response (more typical)
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                //JSON parsing
                
                //parsing JSON object to String type Dictionary (manual)
                //if let json = response.result.value as? Dictionary<String, Any> {
                    //if let email = json["user"] as? String {
                        //self.userEmail = email
                    //}
                    //if let token = json["token"] as? String {
                        //self.authToken = token
                    //}
                //}
                
                
                //using swiftyJSON
                
                //get data out of web-response
                let json: JSON = JSON(response.result.value!)
                self.userEmail = json["user"].stringValue //safely unwrapps value automatically (sets to empty string if nil)
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    
    
    
    //Create user function
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()

        //creating body
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        //creating header
        let header = [
            "Authorization": "Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                let json: JSON = JSON(response.result.value!)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue

                UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                completion(true)
                
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
