//
//  ChatRoom.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/20/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation

/// Represents a instance of a chat room
class ChatRoom {
    
    /// The unique identifier for this chat room
    let id: String
    
    /// The users in this chat room
    var users: [PerimeterUserProfile]
    
    /// The beacon major identifer
    let beaconIdMajor: String
    
    /// The beacon minor identifier
    let beaconIdMinor: String
    
    /// The location for this chat room
    let location: String
    
    /// The messages in the chatroom
    let messages: [Message]
    
    init(id: String, users: [PerimeterUserProfile], beaconIdMajor: String, beaconIdMinor: String, location: String, messages: [Message]) {
        self.id = "1"
        self.users = users
        self.beaconIdMajor = beaconIdMajor
        self.beaconIdMinor = beaconIdMinor
        self.location = "ECS"
        self.messages = Message.testMessages()
    }
    
    /// Gets some test chat rooms
    ///
    /// - Returns: Returns some test chat rooms
    static func testChatRooms() -> [ChatRoom] {
        let chatRoomOne = ChatRoom(id: "1", users: [PerimeterUserProfile.testUser()], beaconIdMajor: "4234", beaconIdMinor: "4242", location: "ECS", messages: Message.testMessages())
        return [chatRoomOne]
    }
}
