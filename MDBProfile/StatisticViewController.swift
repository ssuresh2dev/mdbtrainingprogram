//
//  StatisticViewController.swift
//  MDBProfile
//
//  Created by Ben Goldberg on 9/22/16.
//  Copyright © 2016 Rochelle. All rights reserved.
//

import UIKit

class StatisticViewController: UIViewController {
    
    var topStreak: Int!
    var mostRecent: [String]!
    var score: Int!
    var name: String!
    var picked: [String]!
    var girlsImages: [String]!
    var guysImages: [String]!
    var gender: UInt32!
    var seconds: Int!
    var buttonNames: [String]!
    var imageName: String!
    var recentNames: [String]!
    
    @IBOutlet weak var streakNum: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var name3: UILabel!
    
    override func viewDidLoad() {
        if recentNames[2] != "" {
            image1.image = UIImage(named: mostRecent[2])
            name1.text = recentNames[2]
            if recentNames[1] != "" {
                image2.image = UIImage(named: mostRecent[1])
                name2.text = recentNames[1]
                if recentNames[0] != "" {
                    image1.image = UIImage(named: mostRecent[0])
                    name1.text = recentNames[0]
                }
            }
        }
        streakNum.text = String(topStreak)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trivia = segue.destination as! TriviaViewController
        trivia.topStreak = topStreak
        trivia.score = score
        trivia.mostRecent = mostRecent
        trivia.name = name
        trivia.picked = picked
        trivia.girlsImages = girlsImages
        trivia.guysImages = guysImages
        trivia.gender = gender
        trivia.seconds = seconds
        trivia.back = true
        trivia.buttonNames = buttonNames
        trivia.imageName = imageName
    }
}
