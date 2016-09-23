//
//  TriviaViewController.swift
//  MDBProfile
//
//  Created by Ben Goldberg on 9/19/16.
//  Copyright © 2016 Rochelle. All rights reserved.
//

import UIKit

class TriviaViewController: UIViewController {
    
    var name = ""
    var picked: [String] = []
    var girlsImages: [String] = []
    var guysImages: [String] = []
    var gender = arc4random_uniform(2)
    var clicked: UIButton!
    var score = 0
    var streak = 0
    var topStreak = 0
    var seconds = 5
    var timer = Timer()
    var mostRecent = ["", "", ""]
    var back = false
    var imageName = ""
    var buttonNames = ["", "", "", ""]
    
    let guyNames = ["Aayush Tyagi", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa", "Ali Shelton", "Andy Wang", "Aneesh Jindal", "Ankur Mahesh", "Ashwin Vaidyanathan", "Ben Goldberg", "Billy Lu", "Cody Hsieh", "Connor Killion", "Edward Liu", "Eliot Han", "Emaan Hariri", "Jared Gutierrez", "Jeffrey Zhang", "Justin Kim", "Kedar Thakkar", "Kenneth Steele", "Kevin Jiang", "Krishnan Rajiyah", "Leon Kwak", "Mohit Katyal", "Mudit Mittal", "Peter Schafhalter", "Richard Hu", "Riley Edmunds", "Rohan Narayan", "Sahil Lamba", "Sameer Suresh", "Sayan Paul", "Shaan Appel", "Shubham Goenka", "Sirjan Kafle", "Tarun Khasnavis", "Victor Sun", "Virindh Borra", "Wilbur Shi", "Young Lin"]
    
    let girlNames = ["Alice Wang", "Ally Koo", "Anisha Salunkhe", "Aparna Krishnan", "Candice Ye", "Christine Munar", "Jessica Chen", "Jessica Cherny", "Jessica Ji", "Katharine Jiang", "Kristin Ho", "Lisa Lee", "Mansi Shah", "Rochelle Shen", "Sharie Wang", "Shreya Reddy", "Sona Jeswani", "Vidya Ravikumar"]
    
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var startStop: UIButton!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var scoreTracker: UILabel!
    @IBOutlet weak var timeSeconds: UILabel!
    
    //let ok = segue.destination as! (nameofviewcontroller)
    //ok.___ = variable
    
    @IBAction func next(_ sender: UIButton) {
        timer.invalidate()
        clicked = sender
        if sender.currentTitle! == name {
            streak += 1
            sender.tintColor = UIColor.green
            score += 1
            scoreTracker.text = String(score)
        } else {
            if streak > topStreak {
                topStreak = streak
            }
            streak = 0
            sender.tintColor = UIColor.red
        }
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: delay)
    }
    
    func delay(timer: Timer) {
        pickImage()
        makeButtons()
        clicked.tintColor = UIColor(red: 0.0, green: 0.478, blue: 1.0, alpha: 1.0)
    }
    
    func updateTimer(timer: Timer) {
        if seconds == 1 {
            timer.invalidate()
            seconds = 6
            pickImage()
            makeButtons()
        } else {
            seconds -= 1
            timeSeconds.text = "\(seconds)"
        }
    }
    
    func pickImage() {
        if guysImages.count + girlsImages.count == 5 {
            performSegue(withIdentifier: "toEnd", sender: nil)
        }
        timeSeconds.text = "5"
        seconds = 5
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: updateTimer)
        if girlsImages.count == 18 {
            gender = 1
        } else if guysImages.count == 41 {
            gender = 0
        }
        if gender == 1 {
            name = guyNames[Int(arc4random_uniform(41))]
            while guysImages.contains(name) {
                name = guyNames[Int(arc4random_uniform(41))]
            }
            guysImages += [name]
        } else {
            name = girlNames[Int(arc4random_uniform(18))]
            while girlsImages.contains(name) {
                name = girlNames[Int(arc4random_uniform(18))]
            }
            girlsImages += [name]
        }
        let image = String(name.characters.filter {$0 != " "})
        imageName = image
        picture.image = UIImage(named: image)
        mostRecent = mostRecent[1...2] + [image]
    }
    
    func makeButtons() {
        var buttonArray = [button0, button1, button2, button3]
        let correctButtonIndex = Int(arc4random_uniform(4))
        buttonNames[correctButtonIndex] = name
        buttonArray.remove(at: correctButtonIndex)
        
        switch correctButtonIndex {
        case 0:
            button0.setTitle(name, for: .normal)
        case 1:
            button1.setTitle(name, for: .normal)
        case 2:
            button2.setTitle(name, for: .normal)
        case 3:
            button3.setTitle(name, for: .normal)
        default:
            break
        }
        
        var randomName = ""
        for button in buttonArray {
            if gender == 1 {
                randomName = guyNames[Int(arc4random_uniform(41))]
                while randomName == name || picked.contains(randomName) {
                    randomName = guyNames[Int(arc4random_uniform(41))]
                }
                for i in 0...3 {
                    if buttonNames[i] == "" {
                        buttonNames[i] = randomName
                        break
                    }
                }
            } else {
                randomName = girlNames[Int(arc4random_uniform(18))]
                while randomName == name || picked.contains(randomName) {
                    randomName = girlNames[Int(arc4random_uniform(18))]
                }
                for i in 0...3 {
                    if buttonNames[i] == "" {
                        buttonNames[i] = randomName
                        break
                    }
                }
            }
            picked += [randomName]
            button!.setTitle(randomName, for: .normal)
        }
        gender = arc4random_uniform(2)
        picked = []
    }
    
    override func viewDidLoad() {
        picture.contentMode = .scaleAspectFit
        if back {
            picture.image = UIImage(named: imageName)
            timeSeconds.text = "\(seconds)"
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: updateTimer)
            button0.setTitle(buttonNames[0], for: .normal)
            button1.setTitle(buttonNames[1], for: .normal)
            button2.setTitle(buttonNames[2], for: .normal)
            button3.setTitle(buttonNames[3], for: .normal)
            buttonNames = ["", "", "", ""]
            back = false
        } else {
            pickImage()
            makeButtons()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEnd" {
            let passScore = segue.destination as! WinViewController
            passScore.score = score
        } else if segue.identifier == "toStat"{
            let passStats = segue.destination as! StatisticViewController
            passStats.buttonNames = buttonNames
            passStats.topStreak = topStreak
            passStats.score = score
            passStats.mostRecent = mostRecent
            passStats.name = name
            passStats.picked = picked
            passStats.girlsImages = girlsImages
            passStats.guysImages = guysImages
            passStats.gender = gender
            passStats.seconds = seconds
            passStats.imageName = imageName
        } else if segue.identifier == "toHome"{
            let passHome = segue.destination as! HomeViewController
            passHome.topStreak = topStreak
        }
    }
}
