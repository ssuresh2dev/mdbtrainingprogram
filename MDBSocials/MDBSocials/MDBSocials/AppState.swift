//
//  AppState.swift
//  MDBSocials
//
//  Created by Vidya Ravikumar on 10/13/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import Foundation

class AppState: NSObject {
    
    static let sharedInstance = AppState()
    
    var signedIn = false
    var events : [Event]! = []
    
}
