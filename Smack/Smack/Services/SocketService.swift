//
//  SocketService.swift
//  Smack
//
//  Created by Sophie Berger on 19.12.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    //    initializer required for NSObject
    override init() {
        super.init()
    }
    
    let manager = SocketManager(socketURL: URL(string: "\(BASE_URL)")!)
    lazy var socket: SocketIOClient = manager.defaultSocket
    
    //    connect to server
    func establishConnection() {
        socket.connect()
    }
    
    //    disconnect from server
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        //        emit from app to API
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            //            parse data out of array (order given in API documentation)
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let newChannel = Channel(_id: channelId, name: channelName, description: channelDesc, __v: nil)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    //    when a new message is created --> adds messages to API
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        //        to save typing effort
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
}
