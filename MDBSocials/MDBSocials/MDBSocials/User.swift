//
//  User.swift
//  MDBSocials
//
//  Created by Vidya Ravikumar on 10/13/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import Foundation
import FirebaseAuth

class User {
    
    let uid : String
    let email : String
    
    
    init(userData : FIRUser) {
        uid = userData.uid
        
        if let mail = userData.providerData.first?.email {
            email = mail
        } else {
            email = "error"
        }
        
    }
    
    init (uid : String, email : String) {
        self.uid = uid
        self.email = email
    }
    
}
