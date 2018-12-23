//
//  MessageService.swift
//  Smack
//
//  Created by Sophie Berger on 19.12.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    //    singleton
    static let instance = MessageService()
    
    //    an array of objects of Channel modle
    var channels = [Channel]()
    //    array of messages
    var messages = [Message]()
    //    Array of unread channel ids
    var unreadChannels = [String]()
    //    the currently selected channel (optional)
    var selectedChannel: Channel?
    
    //    func with web request to API to return channels
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                //create JSON object from data (parse-out JSON)
                guard let data = response.data else { return }
                //using decodable protocol to unwrapp JSON data
//                do {
//                    self .channels = try JSONDecoder().decode([Channel].self, from: data)
//                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
//                } catch let error {
//                    debugPrint(error as Any)
//                }

//                give array of JSON objects (dictated by Postamn as return type)
                let json = try! JSON(data: data).array
                for item in json! {
                    let name = item["name"].stringValue
                    let channelDescription = item["description"].stringValue
                    let id = item["_id"].stringValue
                    //create new Channel object with data
                    let channel = Channel(name: name, channelDescription: channelDescription, id: id)
                    //store object in array
                    self.channels.append(channel)
                }
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                completion(true)
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else {return}
                let json = try! JSON(data: data).array
                for item in json! {
                    let messageBody = item["messageBody"].stringValue
                    let channelId = item["channelId"].stringValue
                    let id = item["_id"].stringValue
                    let userName = item["userName"].stringValue
                    let userAvatar = item["userAvatar"].stringValue
                    let userAvatarColor = item["userAvatarColor"].stringValue
                    let timeStamp = item["timeStamp"].stringValue
                    
                    let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                    
                    self.messages.append(message)
                }
                print(self.messages)
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
}
