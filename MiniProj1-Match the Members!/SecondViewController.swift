//
//  SecondViewController.swift
//  MiniProj1-Match the Members!
//
//  Created by Vidya Ravikumar on 9/20/16.
//  Copyright © 2016 Vidya Ravikumar. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var stopButtonPressed = false
    let members: [String] = ["Jessica Cherny", "Mansi Shah", "Alice Wang", "Jessica Ji", "Kevin Jiang", "Jared Gutierrez", "Kristin Ho", "Christine Munar", "Mudit Mittal", "Ali Shelton", "Richard Hu", "Shaan Appel", "Ankur Mahesh", "Edward Liu", "Wilbur Shi", "Young Lin", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa", "Ally Koo", "Andy Wang", "Aneesh Jindal", "Anisha Salunkhe", "Aparna Krishnan", "Ashwin Vaidyanathan", "Cody Hsieh", "Connor Killion", "Jeffrey Zhang", "Justin Kim", "Kenneth Steele", "Krishnan Rajiyah", "Lisa Lee", "Peter Schafhalter", "Riley Edmunds", "Rohan Narayan", "Sahil Lamba", "Sameer Suresh", "Sona Jeswani", "Sirjan Kafle", "Tarun Khasnavis", "Virindh Borra", "Billy Lu", "Aayush Tyagi", "Ben Goldberg", "Candice Ye", "Eliot Han", "Emaan Hariri", "Jessica Chen", "Katharine Jiang", "Kedar Thakkar", "Leon Kwak", "Mohit Katyal", "Rochelle Shen", "Sayan Paul", "Sharie Wang", "Shreya Reddy", "Shubham Goenka", "Victor Sun", "Vidya Ravikumar"]
    var imageNames: [String] = []
    var correctName: String = ""
    var currentScore: Int! = 0 
    var timer = Timer()
    var colorTimer = Timer()
    var hiScore: Int! = 0
    var currStreak: Int! = 0
    var lastThreeAndCurr: [String] = ["","","", ""]
    
    @IBOutlet weak var memberImage: UIImageView!
    
    @IBOutlet weak var name1: UIButton!
    @IBOutlet weak var name2: UIButton!
    @IBOutlet weak var name3: UIButton!
    @IBOutlet weak var name4: UIButton!
    @IBOutlet weak var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for name in members{
            imageNames.append(name.replacingOccurrences(of: " ", with: ""))
        }
        loadNewImageAndOptions()
    }
    
    func loadNewImageAndOptions() {
        timer.invalidate()
        colorTimer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: (#selector(SecondViewController.loadNewImageAndOptions)), userInfo: nil, repeats: true)
        score.text = String(currentScore)
        var options: [Int] = []
        var rand: Int
        var i: Int = 1
        while i < 5 {
            rand = Int(arc4random_uniform(UInt32(members.count)))
            if !options.contains(rand) {
                if i == 1 {
                    name1.setTitle(members[rand], for: UIControlState.normal)
                    options.append(rand)
                } else if i == 2 {
                    name2.setTitle(members[rand], for: UIControlState.normal)
                    options.append(rand)
                } else if i == 3 {
                    name3.setTitle(members[rand], for: UIControlState.normal)
                    options.append(rand)
                } else {
                    name4.setTitle(members[rand], for: UIControlState.normal)
                    options.append(rand)
                }
                i = i + 1
            }
        }
        rand = Int(arc4random_uniform(UInt32(4)))
        correctName = members[options[rand]]
        if(lastThreeAndCurr.count < 4){
            lastThreeAndCurr.append(correctName)
        }
        else{
            lastThreeAndCurr.remove(at: 0)
            lastThreeAndCurr.append(correctName)
        }
        
        memberImage.image = UIImage(named: imageNames[options[rand]])
        memberImage.contentMode = UIViewContentMode.scaleAspectFit
        name1.titleLabel?.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        name2.titleLabel?.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        name3.titleLabel?.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        name4.titleLabel?.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        name1.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        name2.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        name3.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        name4.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
    }
    
    @IBAction func name1ButtonPressed(_ sender: AnyObject) {
        buttonPressed(msg: "name1")
    }
    
    @IBAction func name2ButtonPressed(_ sender: AnyObject) {
        buttonPressed(msg: "name2")
    }
    
    @IBAction func name3ButtonPressed(_ sender: AnyObject) {
        buttonPressed(msg: "name3")
    }
    
    @IBAction func name4ButtonPressed(_ sender: AnyObject) {
        buttonPressed(msg: "name4")
    }
    
    func buttonPressed(msg: String) {
        colorTimer.invalidate()
        switch msg {
        case "name1":
            if name1.currentTitle == correctName {
                name1.titleLabel?.backgroundColor = UIColor.green
                name1.backgroundColor = UIColor.green
                currentScore = currentScore + 1
                currStreak = currStreak + 1 
            } else {
                name1.titleLabel?.backgroundColor = UIColor.red
                name1.backgroundColor = UIColor.red
                currStreak = 0
            }
        case "name2":
            if self.name2.currentTitle == self.correctName {
                self.name2.titleLabel?.backgroundColor = UIColor.green
                currentScore = currentScore + 1
                currStreak = currStreak + 1
                name2.backgroundColor = UIColor.green
            } else {
                self.name2.titleLabel?.backgroundColor = UIColor.red
                name2.backgroundColor = UIColor.red
                currStreak = 0
            }
        case "name3":
            if name3.currentTitle == correctName {
                name3.titleLabel?.backgroundColor = UIColor.green
                currentScore = currentScore + 1
                currStreak = currStreak + 1
                name3.backgroundColor = UIColor.green
            } else {
                name3.titleLabel?.backgroundColor = UIColor.red
                name3.backgroundColor = UIColor.red
                currStreak = 0
            }
        default:
            if name4.currentTitle == correctName {
                name4.titleLabel?.backgroundColor = UIColor.green
                currentScore = currentScore + 1
                currStreak = currStreak + 1
                name4.backgroundColor = UIColor.green
            } else {
                name4.titleLabel?.backgroundColor = UIColor.red
                name4.backgroundColor = UIColor.red
                currStreak = 0
            }
        }
        score.text = "\(currentScore!)"
        colorTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SecondViewController.loadNewImageAndOptions)), userInfo: nil, repeats: true)
        if (currStreak > hiScore){
            hiScore = currStreak
        }
        correctName = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToStats") {
            //get a reference to the destination view controller
            let statsVC = segue.destination as! ThirdViewController
            //set properties on the destination view controller
            statsVC.streakStr = String(hiScore!)
            statsVC.playersArray = lastThreeAndCurr
            statsVC.currScore = currentScore
            statsVC.highScore = hiScore
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
