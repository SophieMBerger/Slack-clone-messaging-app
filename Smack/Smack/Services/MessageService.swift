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
    
    //    func with web request to API to return channels
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                //create JSON object from data (parse-out JSON)
                guard let data = response.data else { return }
                //using decodable protocol to unwrapp JSON data
                do {
                    self .channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }

                //give array of JSON objects (dictated by Postamn as return type)
//                if let json = JSON(data: data).array {
//                    for item in  json {
//                        let name = item["name"].stringValue
//                        let channelDescription = item["description"].stringValue
//                        let id = item["_id"].stringValue
//                        //create new Channel object with data
//                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
//                        //store object in array
//                        self.channels.append(channel)
//                    }
//                    completion(true)
//                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
}
