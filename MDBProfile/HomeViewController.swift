//
//  ViewController.swift
//  MDBProfile
//
//  Created by Rochelle on 9/19/16.
//  Copyright © 2016 Rochelle. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var topStreak = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if topStreak != 0 {
            let passTrivia = segue.destination as! TriviaViewController
            passTrivia.topStreak = topStreak
        }
    }
}

