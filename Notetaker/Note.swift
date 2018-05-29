//
//  Note.swift
//  Note Taker
//
//  Created by sherriff on 9/15/16.
//  Copyright © 2016 Mark Sherriff. All rights reserved.
//

import Foundation

class Note {
    
    var name: String = "New Note"
    var date: Date
    var noteText: String = ""
    
    init(name: String, date: Date, noteText: String) {
        self.name = name
        self.date = date
        self.noteText = noteText
    }
    
}
