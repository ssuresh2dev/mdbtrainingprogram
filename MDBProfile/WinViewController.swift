//
//  WinViewController.swift
//  MDBProfile
//
//  Created by Ben Goldberg on 9/20/16.
//  Copyright © 2016 Rochelle. All rights reserved.
//

import UIKit

class WinViewController: UIViewController {

    var score: Int!
    
    @IBOutlet weak var winOrLose: UIImageView!
    @IBOutlet weak var finalScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if score == 59 {
            winOrLose.image = UIImage(named: "winning text")
        } else {
            winOrLose.image = UIImage(named: "lose text")
        }
        finalScore.text = String(score)
    }
}
