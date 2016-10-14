//
//  AppState.swift
//  Virindly
//
//  Created by Ben Goldberg on 10/13/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import Foundation

class AppState: NSObject {
    
    static let sharedInstance = AppState()
    
    var signedIn = false
    
}
