//
//  PerimerterUserProfile.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/20/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let profileImageUrl: String?
    let displayName: String
    
    static func testUser() -> UserProfile {
        let profile = UserProfile(firstName: "Jim", lastName: "Brown", email: "jimBrown@yahoo.com", profileImageUrl: nil, displayName: "jb98")
        return profile
    }
}
