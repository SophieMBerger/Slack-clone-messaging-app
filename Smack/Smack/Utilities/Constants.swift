//
//  Constants.swift
//  Smack
//
//  Created by Sophie Berger on 14.08.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import Foundation

//typealias = renaming a type -> CompletionHandler is the new type of right of = sign
//creating a custom closure
//pass true/flse into closure to see if request was successful/completed
typealias CompletionHandler = (_ Success: Bool) -> ()

//URL Constants
let BASE_URL = "https://chatapislackclone.herokuapp.com/v1/"

let URL_REGISTER = "\(BASE_URL)account/register"


//Segues
let TO_LOGIN = "toLogin"

let TO_CREATE_ACCOUNT = "toCreateAccount"

let UNWIND = "unwindToChannel"

//User defaults
let TOKEN_KEY = "token"

let LOGGED_IN_KEY = "loggedIn"

let USER_EMAIL = "userEmail"
