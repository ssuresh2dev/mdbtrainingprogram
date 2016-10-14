//
//  Event.swift
//  MDBSocials
//
//  Created by Vidya Ravikumar on 10/13/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Event {
    
    var user : String!
    var eventName : String!
    var description : String!
    var date : String!
    var startTime : String!
    var endTime : String!
    var numAtendees : String!
    var image : UIImage!
    var itemRef : FIRDatabaseReference?
    
    init (user : String, eventName : String, description : String, date : String,
          startTime : String, endTime : String) {
        self.user = user
        self.eventName = eventName
        self.description = description
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.numAtendees = "0"
//        self.image = image
        self.itemRef = nil
    }
    
}
