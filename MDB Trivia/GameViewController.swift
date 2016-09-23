//
//  GameViewController.swift
//  MDB Trivia
//
//  Created by Shubham Goenka on 20/09/16.
//  Copyright © 2016 miniprojects. All rights reserved.
//

import UIKit

var longestStreak: Int! = 0
var lastAnswer: String! = "Unanswered"
var secondLastAnswer: String! = "Unanswered"
var thirdLastAnswer: String! = "Unanswered"

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
    
    // Static Variables
    
    var memberPics: [String] = ["Jessica Cherny", "Mansi Shah", "Alice Wang", "Jessica Ji", "Kevin Jiang", "Jared Gutierrez", "Kristin Ho", "Christine Munar", "Mudit Mittal", "Ali Shelton", "Richard Hu", "Shaan Appel", "Ankur Mahesh", "Edward Liu", "Wilbur Shi", "Young Lin", "Abhinav Koppu", "Abhishek Mangla",  "Akkshay Khoslaa", "Ally Koo", "Andy Wang", "Aneesh Jindal", "Anisha Salunkhe", "Aparna Krishnan", "Ashwin Vaidyanathan", "Cody Hsieh", "Connor Killion", "Jeffrey Zhang", "Justin Kim", "Kenneth Steele", "Krishnan Rajiyah", "Lisa Lee", "Peter Schafhalter", "Riley Edmunds", "Rohan Narayan", "Sahil Lamba", "Sameer Suresh", "Sona Jeswani", "Sirjan Kafle", "Tarun Khasnavis", "Virindh Borra", "Billy Lu", "Aayush Tyagi", "Ben Goldberg", "Candice Ye", "Eliot Han", "Emaan Hariri", "Jessica Chen", "Katharine Jiang", "Kedar Thakkar", "Leon Kwak", "Mohit Katyal", "Rochelle Shen", "Sayan Paul", "Sharie Wang", "Shreya Reddy", "Shubham Goenka", "Victor Sun", "Vidya Ravikumar"];
    
    // Generates a random number between MIN (incl.) and MAX (excl.)
    func generateRandomNumber(min: Int, max: Int) -> Int {
        let randomNum = Int(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
        return randomNum
    }
    
    var currentMember: String!
    var incorrectMember: String!
    var correctOptionNumber: Int!
    var scoreValue: Int! = 0
    var incorrectOptions: [String] = []
    var counterExternal: Int! = 6
    var timerExternal: Timer!
    var currentStreak: Int! = 0
    
    
    func assignMember() {
        currentMember = memberPics[generateRandomNumber(min: 0, max: memberPics.count)]
        Image.image = UIImage(named: currentMember.replacingOccurrences(of: " ", with: ""))
    }
    
    func assignOptions() {
        correctOptionNumber = generateRandomNumber(min: 1, max: 5)
        while incorrectOptions.count != 3 {
            incorrectMember = memberPics[generateRandomNumber(min: 0, max: memberPics.count)]
            if (incorrectMember != currentMember) && !(incorrectOptions.contains(incorrectMember)) {
                incorrectOptions.append(incorrectMember)
            }
        }
        if correctOptionNumber == 1 {
            option1.setTitle(currentMember, for: .normal)
        }
        else {
            option1.setTitle(incorrectOptions[0], for: .normal)
            incorrectOptions.remove(at: 0)
        }
        if correctOptionNumber == 2 {
            option2.setTitle(currentMember, for: .normal)
        }
        else {
            option2.setTitle(incorrectOptions[0], for: .normal)
            incorrectOptions.remove(at: 0)
        }
        if correctOptionNumber == 3 {
            option3.setTitle(currentMember, for: .normal)
        }
        else {
            option3.setTitle(incorrectOptions[0], for: .normal)
            incorrectOptions.remove(at: 0)
        }
        if correctOptionNumber == 4 {
            option4.setTitle(currentMember, for: .normal)
        }
        else {
            option4.setTitle(incorrectOptions[0], for: .normal)
            incorrectOptions.remove(at: 0)
        }
    }
    
    internal func updateTimer() {
        counterExternal = counterExternal - 1
        if counterExternal > -1 {
            timeRemaining.text = String(counterExternal)
        }
        else {
            counterExternal = 6
            currentStreak = 0
            assignMember()
            assignOptions()
        }
    }
    
     func resetButtons() {
        option1.backgroundColor = UIColor(red:0.2470588235, green:0.59999999999999998, blue:1, alpha:1)
        option2.backgroundColor = UIColor(red:0.2470588235, green:0.59999999999999998, blue:1, alpha:1)
        option3.backgroundColor = UIColor(red:0.2470588235, green:0.59999999999999998, blue:1, alpha:1)
        option4.backgroundColor = UIColor(red:0.2470588235, green:0.59999999999999998, blue:1, alpha:1)
    }
    
    
    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var option1: UIButton!
    
    @IBOutlet weak var option2: UIButton!
    
    @IBOutlet weak var option3: UIButton!
    
    @IBOutlet weak var option4: UIButton!
    
    @IBOutlet weak var scoreString: UILabel!
    
    @IBOutlet weak var timeRemaining: UILabel!
    
    
    @IBAction func clickOption1(_ sender: UIButton) {
        thirdLastAnswer = secondLastAnswer
        secondLastAnswer = lastAnswer
        if correctOptionNumber == 1 {
            option1.backgroundColor = UIColor.green
            scoreString.text = String(scoreValue + 1)
            scoreValue = Int(scoreString.text!)
            lastAnswer = "Correct!"
            currentStreak = currentStreak + 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
        }
        else {
            option1.backgroundColor = UIColor.red
            lastAnswer = "Incorrect!"
            currentStreak = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.counterExternal = 6
            self.assignMember()
            self.assignOptions()
            self.resetButtons()
        }
    }
    
    @IBAction func clickOption2(_ sender: UIButton) {
        thirdLastAnswer = secondLastAnswer
        secondLastAnswer = lastAnswer
        if correctOptionNumber == 2 {
            option2.backgroundColor = UIColor.green
            scoreString.text = String(scoreValue + 1)
            scoreValue = Int(scoreString.text!)
            lastAnswer = "Correct!"
            currentStreak = currentStreak + 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
        }
        else {
            option2.backgroundColor = UIColor.red
            lastAnswer = "Incorrect!"
            currentStreak = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.counterExternal = 6
            self.assignMember()
            self.assignOptions()
            self.resetButtons()
        }
    }
    
    @IBAction func clickOption3(_ sender: UIButton) {
        thirdLastAnswer = secondLastAnswer
        secondLastAnswer = lastAnswer
        if correctOptionNumber == 3 {
            option3.backgroundColor = UIColor.green
            scoreString.text = String(scoreValue + 1)
            scoreValue = Int(scoreString.text!)
            lastAnswer = "Correct!"
            currentStreak = currentStreak + 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
        }
        else {
            option3.backgroundColor = UIColor.red
            lastAnswer = "Incorrect!"
            currentStreak = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.counterExternal = 6
            self.assignMember()
            self.assignOptions()
            self.resetButtons()
        }
    }
    
    @IBAction func clickOption4(_ sender: UIButton) {
        thirdLastAnswer = secondLastAnswer
        secondLastAnswer = lastAnswer
        if correctOptionNumber == 4 {
            option4.backgroundColor = UIColor.green
            scoreString.text = String(scoreValue + 1)
            scoreValue = Int(scoreString.text!)
            lastAnswer = "Correct!"
            currentStreak = currentStreak + 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
        }
        else {
            option4.backgroundColor = UIColor.red
            lastAnswer = "Incorrect!"
            currentStreak = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.counterExternal = 6
            self.assignMember()
            self.assignOptions()
            self.resetButtons()
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

}
