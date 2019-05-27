//
//  Comments.swift
//  instagramFirebase
//
//  Created by Егор Бамбуров on 03.08.2018.
//  Copyright © 2018 Егор Бамбуров. All rights reserved.
//

import Foundation

struct Comment {
    
    var user: User
    
    let text: String
    let uid: String
    let creationDate: NSNumber?
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["commentText"] as? String ?? ""
        self.creationDate = dictionary["creationDate"] as? NSNumber
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
