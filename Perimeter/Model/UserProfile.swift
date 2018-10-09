//
//  PerimerterUserProfile.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/20/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var profileImageUrl: String?
    var displayName: String
    
   
    static func testUser() -> UserProfile {
        let profile = UserProfile(firstName: "Jim", lastName: "Brown", email: "jimBrown@yahoo.com", profileImageUrl: nil, displayName: "jb98")
        return profile
    }
    
    var dictionary: [String: Any] {
        var dictionary = [String: Any]()
        dictionary["firstName"] = firstName
        dictionary["lastName"] = lastName
        dictionary["email"] = email
        dictionary["profileImageUrl"] = profileImageUrl
        dictionary["displayName"] = displayName
        return dictionary
    }
    
    
}
