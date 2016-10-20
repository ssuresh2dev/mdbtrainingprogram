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
    
    var name: String!
    var userPhoto: UIImage!
    //var currentUser: FIRUser!

    init(uName: String, photo: UIImage) {
        name = uName
        userPhoto = photo
        
        //currentUser = (FIRAuth.auth()?.currentUser)!
    }
    
//    func getName() -> String {
//        if currentUser != nil:
//            return currentUser.displayName!
//
//    }
    
    
}
