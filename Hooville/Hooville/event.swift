//
//  event.swift
//  Hooville
//
//  Created by Elliott Kim on 4/24/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

class event {
    
    var name: String = "New Event"
    var address: String = "Address"
    var desc: String = "Temp description"
    var date: String = "00/00/0000"
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["Name"] as! String
        address = snapshotValue["Address"] as! String
        desc = snapshotValue["Description"] as! String
        date = snapshotValue["Date"] as! String
    }
    init() {
        self.name = ""
        self.address = ""
        self.desc = ""
        self.date = ""
    }
    
    init(name: String, address: String, desc: String, date: String) {
        self.name = name
        self.address = address
        self.desc = desc
        self.date = date
    }
    
    func setName(n: String){
        name = n
    }
    
    func setAddress(a: String){
        address = a
    }
    
    func setDesc(d: String){
        desc = d
    }
    
    func setDate(d: String){
        date = d
    }
}
