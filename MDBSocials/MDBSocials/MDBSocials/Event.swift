//
//  Event.swift
//  MDBSocials
//
//  Created by Vidya Ravikumar on 10/13/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class Event {
    
    var user : String
    var eventName : String
    var description : String
    var date : String
    var startTime : String
    var endTime : String
    var numPeople : Int
    var imageURL: String
    var eventID: String
    var peopleInterested: [String]

    init (key: String, eventDict: [String: AnyObject]) {
        
        eventID = key
        
        if let myDate = eventDict["date"] as? String {
            date = myDate
        } else {
            date = "error"
        }
        if let myUser = eventDict["user"] as? String {
            user = myUser
        } else {
            user = "error"
        }
        if let myName = eventDict["name"] as? String{
            eventName = myName
        } else {
            eventName = "error"
        }
        if let myDescription = eventDict["description"] as? String{
            description = myDescription
        } else {
            description = "error"
        }
        if let end = eventDict["end"] as? String{
            endTime = end
        } else {
            endTime = "error"
        }
        if let start = eventDict["start"] as? String{
            startTime = start
        } else {
            startTime = "error"
        }
        if let attendance = eventDict["numPeople"] as? Int{
            numPeople = attendance
        } else {
            numPeople = 9999
        }
        if let image = eventDict["imageURL"] as? String{
            imageURL = image
        } else {
            imageURL = "error"
        }
        if let people = eventDict["usersInterested"] as? [String]{
            peopleInterested = people
        } else {
            peopleInterested = ["Error"]
        }
        
    }
    
    
    
    //    func addInterestedUser(){
    //
    //
    //        let eventRef = FIRDatabase.database().reference(withPath: "events")
    //        let interestedRef = eventRef.child("peopleInterested")
    //
    //
    //        interestedRef.observe(.value, with: { snapshot in
    //
    //
    //            var nameArray: [String]
    //
    //            nameArray = (snapshot.value as? [String])!
    //
    //            let user = FIRAuth.auth()?.currentUser
    //
    //            nameArray.append((user?.email!)!)
    //            interestedRef.setValue(nameArray)
    //
    //            print(nameArray)
    //            
    //        })
    //        


    
        

    
}
