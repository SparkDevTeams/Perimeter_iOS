//
//  PerimerterUserProfile.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/20/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation

struct PerimeterUserProfile {
    let firstName: String
    let lastName: String
    let email: String
    let profileImageUrl: String?
    let displayName: String
    
    static func testUser() -> PerimeterUserProfile {
        let profile = PerimeterUserProfile(firstName: "Jim", lastName: "Brown", email: "jimBrown@aol.com", profileImageUrl: nil, displayName: "jb98")
        return profile
    }
    
}