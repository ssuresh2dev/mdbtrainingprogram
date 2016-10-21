//
//  User.swift
//  MDBSocials
//
//  Created by Shubham Goenka on 19/10/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class User {
    let user = FIRAuth.auth()?.currentUser!
    var name: String!
    var profileImageUrl: String!
    //var currentUser: FIRUser!
    
    func getProfPic(name: String!){
        
    }
    
    
    
}
