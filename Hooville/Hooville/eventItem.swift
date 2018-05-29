//
//  eventItem.swift
//  Hooville
//
//  Created by Elliott Kim on 4/16/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

class eventItem {
    
    var name: String = "New Event"
    var address: String = "Address"
    var city: String = "Charlottesville"
    var state: String = "Virginia"
    //var zipcode: String = "22903"
    var desc: String = "Temp description"
    var ID: String = "key"
    
    init(snapshot: DataSnapshot) {
        ID = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["Name"] as! String
        address = snapshotValue["Address"] as! String
        city = snapshotValue["City"] as! String
        state = snapshotValue["State"] as! String
        //zipcode = snapshotValue["Zip Code"] as! BinaryInteger
        desc = snapshotValue["Description"] as! String
    }
    
    init(name: String) {
        self.name = name
    }
    
    func setName(n: String){
        name = n
    }
}
