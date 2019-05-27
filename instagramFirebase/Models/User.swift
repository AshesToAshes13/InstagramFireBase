//
//  User.swift
//  instagramFirebase
//
//  Created by Егор Бамбуров on 01.08.2018.
//  Copyright © 2018 Егор Бамбуров. All rights reserved.
//

import Foundation

struct User {
    
    let uid: String
    let username: String
    let profileImageUrl: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}

