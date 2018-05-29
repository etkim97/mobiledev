//
//  review.swift
//  Hooville
//
//  Created by Amanda Nguyen on 4/25/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase
class review {
    
    var username: String = "Username"
    var review: String = "review"

    
    init() {
        self.username = ""
        self.review = ""
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.username = snapshotValue["Username"] as! String
        self.review = snapshotValue["Review"] as! String
    }
    
    init(user: String, review: String) {
        self.username = user
        self.review = review
    }
}
