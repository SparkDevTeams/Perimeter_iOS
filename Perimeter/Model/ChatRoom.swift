//
//  ChatRoom.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/20/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation

/// Represents a instance of a chat room
class ChatRoom: Codable{
    
    /// The unique identifier for this chat room
    let id: String
    
    /// The users in this chat room
    var usersId: [String]
    
    /// The beacon major identifer
    let beaconIdMajor: String
    
    /// The beacon minor identifier
    let beaconIdMinor: String
    
    /// The location for this chat room
    let location: String
    
    /// The id for the document holding the current messages
    var currentMessagesId: String
    
    /// The ids for the documents that contain all the messages ever written in the chat
    var messagesIds:[String]
    
    /// A description for the chat room
    let description: String
    
    // The chatroom image
    let chatRoomImageUrl: String?
    
    /// The last message in this chat room
    var lastMessage: Message?
    
    init(id: String, users: [String], beaconIdMajor: String, beaconIdMinor: String, location: String, description: String, messages: [Message], currentMessagesId: String, messagesIds: [String]) {
        self.id = "1"
        self.usersId = users
        self.beaconIdMajor = beaconIdMajor
        self.beaconIdMinor = beaconIdMinor
        self.location = "ECS"
        self.description = description
        //self.messages = nil
        self.chatRoomImageUrl = nil
        self.currentMessagesId = currentMessagesId
        self.messagesIds = messagesIds
    }
}
