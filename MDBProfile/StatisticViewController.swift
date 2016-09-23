//
//  StatisticViewController.swift
//  MDBProfile
//
//  Created by Ben Goldberg on 9/22/16.
//  Copyright © 2016 Rochelle. All rights reserved.
//

import UIKit

class StatisticViewController: UIViewController {
    
    var topScore = 0
    var mostRecent: [String]!
    var score: Int!
    var name: String!
    var picked: [String]!
    var girlsImages: [String]!
    var guysImages: [String]!
    var gender: UInt32!
    var seconds: Int!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trivia = segue.destination as! TriviaViewController
        trivia.topScore = topScore
        trivia.score = score
        trivia.mostRecent = mostRecent
        trivia.name = name
        trivia.picked = picked
        trivia.girlsImages = girlsImages
        trivia.guysImages = guysImages
        trivia.gender = gender
        trivia.seconds = seconds
    }
    
    override func viewDidLoad() {
        if score > topScore {
            topScore = score
        }
    }
}
