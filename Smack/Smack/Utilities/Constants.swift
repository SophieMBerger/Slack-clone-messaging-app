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

let URL_LOGIN = "\(BASE_URL)account/login"

let URL_USER_ADD = "\(BASE_URL)user/add"

let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"

let URL_GET_CHANNELS = "\(BASE_URL)channel/"

let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"

let URL_CHANGE_USERNAME = "\(BASE_URL)user/\(UserDataService.instance.id)"

//Colors
let SMACKPURPLEPLACEHOLDER = #colorLiteral(red: 0.3254901961, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5)

//Notifications
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelselected")

//Segues
let TO_LOGIN = "toLogin"

let TO_CREATE_ACCOUNT = "toCreateAccount"

let UNWIND = "unwindToChannel"

let TO_AVATAR_PICKER = "toAvatarPicker"

//User defaults
let TOKEN_KEY = "token"

let LOGGED_IN_KEY = "loggedIn"

let USER_EMAIL = "userEmail"

//Headers

//creating a header
//creating JSON object
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

//creating header which contains authorization token
let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]











