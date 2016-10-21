//
//  Event.swift
//  MDBSocials
//
//  Created by Eliot Han on 10/13/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit

class Event: NSObject {
    var eventTitle: String?
    var eventDate: String?
    var eventDescription: String?
    var downloadURL: String?
    var poster: String?
    var rsvp: [NSString] = []
    var posterName: String?
}
