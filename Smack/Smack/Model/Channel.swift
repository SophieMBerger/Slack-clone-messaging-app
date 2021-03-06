//
//  Channel.swift
//  Smack
//
//  Created by Sophie Berger on 19.12.18.
//  Copyright © 2018 SophieMBerger. All rights reserved.
//

import Foundation

//channel conforms to decodable protocol to make JSON unwrapping easier
struct Channel : Decodable {
    
    public private(set) var name: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
    
}
