//
//  PerimerterUserProfile.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/20/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation

struct PerimerterUserProfile {
    let firstName: String
    let lastName: String
    let email: String
    let profileImageUrl: String?
    let displayName: String
    
    static func testUser() -> PerimerterUserProfile {
        let profile = PerimerterUserProfile(firstName: "Jim", lastName: "Brown", email: "jimBrown@aol.com", profileImageUrl: nil, displayName: "jb98")
        return profile
    }
    
}
