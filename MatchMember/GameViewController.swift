//
//  GameViewController.swift
//  MatchMember
//
//  Created by Candice Ye on 9/19/16.
//  Copyright © 2016 Candice Ye. All rights reserved.
//

import UIKit

var longestStreak: Int! = 0
var getResult1: String! = "Unanswered"
var getResult2: String! = "Unanswered"
var getResult3: String! = "Unanswered"

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        assignMember()
        assignOptions()
        timerExternal = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameViewController.updateTimer), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // OUTLETS
    @IBOutlet weak var imageMemberPicture: UIImageView!
    
    @IBOutlet weak var labelTimeRemaining: UILabel!
    @IBOutlet weak var valueTimeRemaining: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var scoreString: UILabel!
    
    @IBOutlet weak var buttonChoiceA: UIButton!
    @IBOutlet weak var buttonChoiceB: UIButton!
    @IBOutlet weak var buttonChoiceC: UIButton!
    @IBOutlet weak var buttonChoiceD: UIButton!
    
    
    // STATIC VARIABLES
    var memberPics = ["Jessica Cherny", "Mansi Shah", "Alice Wang", "Jessica Ji", "Kevin Jiang", "Jared Gutierrez", "Kristin Ho", "Christine Munar", "Mudit Mittal", "Ali Shelton", "Richard Hu", "Shaan Appel", "Ankur Mahesh", "Edward Liu", "Wilbur Shi", "Young Lin", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa", "Ally Koo", "Andy Wang", "Richard Chen", "Aneesh Jindal", "Anisha Salunkhe", "Aparna Krishnan", "Ashwin Vaidyanathan", "Cody Hsieh", "Connor Killion", "Jeffrey Zhang", "Justin Kim", "Kenneth Steele", "Krishnan Rajiyah", "Lisa Lee", "Peter Schafhalter", "Riley Edmunds", "Rohan Narayan", "Sahil Lamba", "Sameer Suresh", "Sona Jeswani", "Sirjan Kafle", "Tarun Khasnavis", "Virindh Borra", "Billy Lu", "Aayush Tyagi", "Ben Goldberg", "Candice Ye", "Eliot Han", "Emaan Hariri", "Jessica Chen", "Katharine Jiang", "Kedar Thakkar", "Leon Kwak", "Mohit Katyal", "Rochelle Shen", "Sayan Paul", "Sharie Wang", "Shreya Reddy", "Shubham Goenka", "Victor Sun", "Vidya Ravikumar"]
    
    var currentMember: String!
    var incorrectMember: String!
    var correctOptionNumber: Int!
    var incorrectOptions: [String] = []
    
    var scoreValue: Int! = 0
    
    var timerExternal: Timer!
    var counterExternal = 6
    
    var currentStreak: Int! = 0
    
    
    // ACTIONS
    
    // Timer
    internal func updateTimer() {
        counterExternal = counterExternal - 1
        if (counterExternal > -1) {
            valueTimeRemaining.text = String(counterExternal)
        }
        else {
            counterExternal = 6
            assignMember()
            assignOptions()
        }
    }
    
    
    // Reset Button Colors
    func resetButtons() {
        buttonChoiceA.backgroundColor = UIColor.lightGray
        buttonChoiceB.backgroundColor = UIColor.lightGray
        buttonChoiceC.backgroundColor = UIColor.lightGray
        buttonChoiceD.backgroundColor = UIColor.lightGray
    }
    
    
    // Random Number Generator
    func generateRandomNumber(min: Int, max: Int) -> Int {
        let randomNum = Int(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
        return randomNum
    }
    
    // Button Actions Upon Click
    @IBAction func pressChoiceA(_ sender: AnyObject) {
        getResult3 = getResult2
        getResult2 = getResult1
        if correctOptionNumber == 1 {
            buttonChoiceA.backgroundColor = UIColor.green
            scoreString.text = String(scoreValue + 1)
            scoreValue = Int(scoreString.text!)
            getResult1 = "Correct!"
            currentStreak = currentStreak + 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
            
        }
        else {
            buttonChoiceA.backgroundColor = UIColor.red
            getResult1 = "Incorrect!"
            currentStreak = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.counterExternal = 6
            self.assignMember()
            self.assignOptions()
            self.resetButtons()
        }
        
    }
    @IBAction func pressChoiceB(_ sender: AnyObject) {
        getResult3 = getResult2
        getResult2 = getResult1
        if correctOptionNumber == 2 {
            buttonChoiceB.backgroundColor = UIColor.green
            scoreString.text = String(scoreValue + 1)
            scoreValue = Int(scoreString.text!)
            getResult1 = "Correct!"
            currentStreak = currentStreak + 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
        }
        else {
            buttonChoiceB.backgroundColor = UIColor.red
            getResult1 = "Incorrect!"
            currentStreak = 0
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.counterExternal = 6
            self.assignMember()
            self.assignOptions()
            self.resetButtons()
        }
        
    }
    @IBAction func pressChoiceC(_ sender: AnyObject) {
        getResult3 = getResult2
        getResult2 = getResult1
        if correctOptionNumber == 3 {
            buttonChoiceC.backgroundColor = UIColor.green
            scoreString.text = String(scoreValue + 1)
            scoreValue = Int(scoreString.text!)
            getResult1 = "Correct!"
            currentStreak = currentStreak + 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
        }
        else {
            buttonChoiceC.backgroundColor = UIColor.red
            getResult1 = "Incorrect!"
            currentStreak = 0
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.counterExternal = 6
            self.assignMember()
            self.assignOptions()
            self.resetButtons()
        }
        
    }
    @IBAction func pressChoiceD(_ sender: AnyObject) {
        getResult3 = getResult2
        getResult2 = getResult1
        if correctOptionNumber == 4 {
            buttonChoiceD.backgroundColor = UIColor.green
            scoreString.text = String(scoreValue + 1)
            scoreValue = Int(scoreString.text!)
            getResult1 = "Correct!"
            currentStreak = currentStreak + 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
        }
        else {
            buttonChoiceD.backgroundColor = UIColor.red
            getResult1 = "Incorrect!"
            currentStreak = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.counterExternal = 6
            self.assignMember()
            self.assignOptions()
            self.resetButtons()
        }
        
    }
    
    
    // New Member Picture
    func assignMember() {
        currentMember = memberPics[generateRandomNumber(min:0, max: memberPics.count)]
        imageMemberPicture.image = UIImage(named: currentMember.replacingOccurrences(of: " ", with: ""))
    }

    // New Options
    func assignOptions() {
        correctOptionNumber = generateRandomNumber(min: 1, max: 5)
        while incorrectOptions.count != 3 {
            incorrectMember = memberPics[generateRandomNumber(min: 0, max: memberPics.count)]
            if (incorrectMember != currentMember) && !(incorrectOptions.contains(incorrectMember)) {
                incorrectOptions.append(incorrectMember)
            }
        }
        
        if correctOptionNumber == 1 {
            buttonChoiceA.setTitle(currentMember, for: .normal)
        }
        else {
            buttonChoiceA.setTitle(incorrectOptions[0], for: .normal)
            incorrectOptions.remove(at: 0)
        }
        
        if correctOptionNumber == 2 {
            buttonChoiceB.setTitle(currentMember, for: .normal)
        }
        else {
            buttonChoiceB.setTitle(incorrectOptions[0], for: .normal)
            incorrectOptions.remove(at: 0)
        }
        
        if correctOptionNumber == 3 {
            buttonChoiceC.setTitle(currentMember, for: .normal)
        }
        else {
            buttonChoiceC.setTitle(incorrectOptions[0], for: .normal)
            incorrectOptions.remove(at: 0)
        }
        
        if correctOptionNumber == 4 {
            buttonChoiceD.setTitle(currentMember, for: .normal)
        }
        else {
            buttonChoiceD.setTitle(incorrectOptions[0], for: .normal)
            incorrectOptions.remove(at: 0)
        }
    }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

