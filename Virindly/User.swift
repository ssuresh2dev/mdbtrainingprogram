//
//  User.swift
//  Virindly
//
//  Created by Candice Ye on 10/19/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class User {
    
    var name: String?
    var chatIds: [String]?
    var uid: String?
    var imageUrl: String?
    
    init(key: String, userDict: [String: AnyObject]) {
        uid = key
        if let username = userDict["name"] as? String {
            name = username
        }
//        if let profPicUrl = userDict["profPicUrl"] as? String {
//            profPicUrl = imageUrl
//        }
        if let ids = userDict["chatIds"] as? [String] {
            chatIds = ids
        }
    }
    
    // Interested status of user
    enum GoingStatus {
        case interested
        case notResponded
    }
    
    // FUNCTIONS
    
    //Gets the user’s profile picture
    func getProfPic(withBlock: @escaping (UIImage) -> Void) {
        let storageRef = FIRStorage.storage().reference()
        let imageRef = storageRef.child(imageUrl!)
        imageRef.data(withMaxSize: 1*1024*1024) {(data, error) -> Void in
            if (error != nil) {
                print("Sorry, couldn't retrieve image. Error occurred: \(error)")
            } else {
                let image = UIImage(data: data!)
                withBlock(image!)
            }
        }
    }
    
    
}
