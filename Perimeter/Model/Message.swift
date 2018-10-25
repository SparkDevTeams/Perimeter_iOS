//
//  Message.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/20/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import Firebase

/// Represents a single message
struct Message: Codable {
    
    /// The date the message was sent
    let timestamp: Timestamp
    
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
    
    let senderDisplayName: String
    
    var dictionary: [String: Any] {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.dateEncodingStrategy = .secondsSince1970
            let jsonData = try jsonEncoder.encode(self)
            var json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
            json["timestamp"] = timestamp
            return json
        } catch {
            print("Error converting to json \(error.localizedDescription)")
            return [:]
        }
    }
    
}

