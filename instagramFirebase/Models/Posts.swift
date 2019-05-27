//
//  Posts.swift
//  instagramFirebase
//
//  Created by Егор Бамбуров on 01.08.2018.
//  Copyright © 2018 Егор Бамбуров. All rights reserved.
//

import Foundation

struct Post {
    
    var id: String?
    var hasLiked = false
    
    let user: User
    let imageUrl: String
    let caption: String
    let creationDate: NSNumber?
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.creationDate = dictionary["creationDate"] as? NSNumber
        
    }
}

