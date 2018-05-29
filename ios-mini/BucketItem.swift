//
//  BucketItem.swift
//  Bucket List
//
//  Created by sherriff on 9/15/16.
//  Copyright © 2016 Mark Sherriff. All rights reserved.
//

import Foundation

class BucketItem {
    
    var name: String = "New Note"
    var date: Date
    var description: String = ""
    var longitude: String = ""
    var latitude: String = ""
    var complete: Bool = false
    
    init(name: String, date: Date, description: String, longitude: String, latitude: String, complete: Bool) {
        self.name = name
        self.date = date
        self.description = description
        self.longitude = longitude
        self.latitude = latitude
        self.complete = false
    }
    
    func setName(n: String){
        name = n
    }
    
    func setDescription(d: String){
        description = d
    }
    
    func setLatitude(l: String){
        latitude = l
    }
    
    func setLongitude(l: String){
        longitude = l
    }
    
    func setDate(d: Date){
        date = d
    }
    
    func setComplete(c: Bool){
        complete = c
    }
    
}
