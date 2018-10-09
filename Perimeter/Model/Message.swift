//
//  Message.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/20/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation

/// Represents a single message
struct Message: Codable {
    
    /// The date the message was sent
    let dateSent: Date
    
    /// The message that was sent
    let message: String?
    
    /// The senderId aka the id of the user who sent the messge
    let senderId: String
    
    /// The type of message, audio, video, text
    let messageType: String
    
    /// The link to the audio message
    let audioLink: String?
    
    /// The link to the image
    let imageLink: String?
    
    /// The link to the video
    let videoLink: String?
    
    /// The Id for this chat room
    let chatRoomId: String
    
    /// The unique identifier for the message
    let messageId: String
    
<<<<<<< HEAD
 
    
=======
>>>>>>> a88fced31fec050739d9bb4eef23ca2aff3a326c
    /// Returns an array of test messages
    ///
    /// - Returns: An array of messages
    static func testMessages() -> [Message] {
        let messageOne = Message(dateSent: Date(), message: "Hey when are you coming to the library", senderId: "WTYeGambWghxX7K11IWLVS7Odmh2", messageType: "text", audioLink: nil, imageLink: nil, videoLink: nil, chatRoomId: "ECS", messageId: "1")
        let messageTwo = Message(dateSent: Date() + 1, message: "Hey when are you coming to the library", senderId: "HCB17P4Rm4VAOanT9tggOWtWJMo1", messageType: "text", audioLink: nil, imageLink: nil, videoLink: nil, chatRoomId: "ECS", messageId: "2")
        let messageThree = Message(dateSent: Date() + 2, message: "Hey when are you coming to the library", senderId: "WTYeGambWghxX7K11IWLVS7Odmh2", messageType: "text", audioLink: nil, imageLink: nil, videoLink: nil, chatRoomId: "ECS", messageId: "3")
        let messageFour = Message(dateSent: Date() + 3, message: "Hey when are you coming to the library", senderId: "WTYeGambWghxX7K11IWLVS7Odmh2", messageType: "text", audioLink: nil, imageLink: nil, videoLink: nil, chatRoomId: "ECS", messageId: "4")
        let messageFive = Message(dateSent: Date() + 4, message: "Hey when are you coming to the library", senderId: "HCB17P4Rm4VAOanT9tggOWtWJMo1", messageType: "text", audioLink: nil, imageLink: nil, videoLink: nil, chatRoomId: "ECS", messageId: "5")
        let messageSix = Message(dateSent: Date() + 5, message: "Hey when are you coming to the library", senderId: "WTYeGambWghxX7K11IWLVS7Odmh2", messageType: "text", audioLink: nil, imageLink: nil, videoLink: nil, chatRoomId: "ECS", messageId: "6")
        return [messageOne, messageTwo, messageThree, messageFour, messageFive, messageSix]
    }
}

