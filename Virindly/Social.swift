//
//  Social.swift
//  Virindly
//
//  Created by Candice Ye on 10/19/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Social {
    
    struct postStruct {
        let fullname: String!
        let event: String!
        let details: String!
        let date: String!
    }
    
    var posts = [postStruct]()
    
//    let ref = FIRDatabase.database().reference()
//    // ref.child("posts").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
//    
//    let snapshotValue = snapshot.value as? NSDictionary
//    
//    let fullname = snapshotValue!["fullname"]
//    let event = snapshotValue!["event"]
//    let details = snapshotValue!["details"]
//    let date = snapshotValue!["date"]
//    
//    self.posts.insert(postStruct(fullname: fullname as! String, event: event as! String!, details: details as! String, date: date as! String), at: 0)
//    self.tableView.reloadData()
//    })
    
    
    // FUNCTIONS
    
    //Gets a list of users that are interested in the social
    func getInterestedUsers(withBlock: ([User]) -> Void) {
        
    }
    
    
    //When a user clicks “interested” on the social, call this method to add them as an interested user for that social in the database
    func addInterestedUser(withId: String) {
        
        
    }
    
    
}
