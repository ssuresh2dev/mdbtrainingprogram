//
//  ViewController.swift
//  MatchTheMembers
//
//  Created by Kevin Jiang on 9/19/16.
//  Copyright © 2016 Kevin Jiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var howToPlay: UIButton!
    @IBOutlet var statisticsButton: UIButton!
    @IBOutlet var startStatisticsButton: UIButton!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var background: UIImageView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var triviaIcon: UIImageView!
    @IBOutlet var mdbTitle: UILabel!
    @IBAction func startStopAction(_ sender: AnyObject) {
        if isStart {
            startStop.setTitleColor(UIColor.white, for: .normal)
            isStart = false
            startStop.backgroundColor = UIColor.red
            startStop.setTitle("Stop", for: .normal)
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = false
            memberImage.isHidden = false
            timerbutton.isHidden = false
            mdbTitle.isHidden = true
            triviaIcon.isHidden = true
            score.isHidden = false
            scoreLabel.isHidden = false
            startButton.isHidden = true
            startStatisticsButton.isHidden = true
            startStop.isHidden = false
            statisticsButton.isHidden = false
            howToPlay.isHidden = true
            update()
        } else {
            isStart = true
            startStop.setTitleColor(UIColor.black, for: .normal)
            startStop.backgroundColor = UIColor.green
            startStop.setTitle("Start", for: .normal)
            answerTimer.invalidate()
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            button4.isHidden = true
            memberImage.isHidden = true
            timerbutton.isHidden = true
            mdbTitle.isHidden = false
            triviaIcon.isHidden = true
            score.isHidden = true
            scoreLabel.isHidden = true
            startButton.isHidden = false
            startStatisticsButton.isHidden = false
            startStop.isHidden = true
            statisticsButton.isHidden = true
            howToPlay.isHidden = false
        }
    }
    @IBOutlet var startStop: UIButton!
    @IBOutlet var timerbutton: UIButton!
    
    @IBOutlet var score: UILabel!
    @IBAction func button4action(_ sender: AnyObject) {
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        if button4.titleLabel!.text == randomImage {
            correctButton = button4
            correct()
        } else {
            wrongButton = button4
            wrong()
        }
    }
    @IBAction func button3action(_ sender: AnyObject) {
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        if button3.titleLabel!.text == randomImage {
            correctButton = button3
            correct()
        } else {
            wrongButton = button3
            wrong()
        }
    }
    @IBAction func button2action(_ sender: AnyObject) {
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        if button2.titleLabel!.text == randomImage {
            correctButton = button2
            correct()
        } else {
            wrongButton = button2
            wrong()
        }
    }
    @IBAction func button1action(_ sender: AnyObject) {
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        if button1.titleLabel!.text == randomImage {
            correctButton = button1
            correct()
        } else {
            wrongButton = button1
            wrong()
        }
    }

    @IBOutlet var button4: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button2: UIButton!

    
    let memberNames: [String] = ["Aayush Tyagi", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa",
                                 "Alice Wang", "Ali Shelton", "Ally Koo", "Andy Wang", "Aneesh Jindal",
                                 "Anisha Salunkhe", "Ankur Mahesh", "Aparna Krishnan", "Ashwin Vaidyanathan",
                                 "Ben Goldberg", "Billy Lu", "Candice Ye", "Christine Munar", "Cody Hsieh",
                                 "Connor Killion", "Edward Liu", "Eliot Han", "Emaan Hariri", "Jared Gutierrez",
                                 "Jeffrey Zhang", "Jessica Chen", "Jessica Cherny", "Jessica Ji", "Justin Kim",
                                 "Katharine Jiang", "Kedar Thakkar", "Kenneth Steele", "Kevin Jiang",
                                 "Krishnan Rajiyah", "Kristin Ho", "Leon Kwak", "Lisa Lee", "Mansi Shah",
                                 "Mohit Katyal", "Mudit Mittal", "Peter Schafhalter", "Richard Chen",
                                 "Richard Hu", "Riley Edmunds", "Rochelle Shen", "Rohan Narayan", "Sameer Suresh",
                                 "Sayan Paul", "Shaan Appel", "Sharie Wang", "Shreya Reddy", "Shubham Goenka",
                                 "Sirjan Kafle", "Sona Jeswani", "Tarun Khasnavis", "Victor Sun",
                                 "Vidya Ravikumar", "Virindh Borra", "Wilbur Shi", "Young Lin"]
    
    @IBOutlet var memberImage: UIImageView!
    @IBOutlet var button1: UIButton!
    
    var randomImage: String!
    var playerScore: Int = 0
    var options: [String]!
    var colorTimer: Timer!
    var answerTimer: Timer!
    var count: Int = 0
    var correctButton: UIButton!
    var wrongButton: UIButton!
    var isStart: Bool = true
    var longestStreak: Int = -1
    var streak: Int = 0
    var mostRecent: String!
    var secondRecent: String!
    var thirdRecent: String!
    var mostRecentCorrect: Bool!
    var secondRecentCorrect: Bool!
    var thirdRecentCorrect: Bool!
    var calls: Int = 0
    var countdown: Int = 5
    var countdownTimer: Timer!
    var buttonColor: UIColor = UIColor.init(red: 45/255, green: 138/255, blue: 230/255, alpha: 1.0   )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        score.text = String(playerScore)
        
        startStop.backgroundColor = UIColor.clear
        startStop.setTitle("Play", for: .normal)
        startStop.isHidden = true
        
        startButton.backgroundColor = UIColor.clear
        startButton.layer.borderColor = UIColor.init(red: 55/255, green: 182/255, blue: 80/255, alpha: 1.0).cgColor
        startButton.layer.borderWidth = 1
        
        triviaIcon.image = UIImage(named: "MDBTriviaIcon")
        triviaIcon.isHidden = true
        score.isHidden = true
        scoreLabel.isHidden = true
        timerbutton.isHidden = true
        
        statisticsButton.isHidden = true
        
        button1.layer.borderColor = buttonColor.cgColor
        button1.layer.borderWidth = 1
        button1.titleLabel!.font = UIFont(name: "Corki", size: 20)!
        button2.layer.borderColor = buttonColor.cgColor
        button2.layer.borderWidth = 1
        button2.titleLabel!.font = UIFont(name: "Corki", size: 20)!
        button3.layer.borderColor = buttonColor.cgColor
        button3.layer.borderWidth = 1
        button3.titleLabel!.font = UIFont(name: "Corki", size: 20)!
        button4.layer.borderColor = buttonColor.cgColor
        button4.layer.borderWidth = 1
        button4.titleLabel!.font = UIFont(name: "Corki", size: 20)!
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg-2")!)
        
        
        /*button1.backgroundColor = UIColor.blue
        button2.backgroundColor = UIColor.blue
        button3.backgroundColor = UIColor.blue
        button4.backgroundColor = UIColor.blue*/
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Corki", size: 20)!]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateRandomImage() -> String {
        let index: Int = Int(arc4random_uniform(UInt32(memberNames.count)))
        return memberNames[index]
    }
    
    func generateOptions(answer: String) -> [String] {
        var options: [String] = [answer]
        while options.count < 4 {
            let index: Int = Int(arc4random_uniform(UInt32(memberNames.count)))
            if(memberNames[index] != answer && !options.contains(memberNames[index])) {
                options.append(memberNames[index])
            }
        }
        return options.shuffled()
    }
    
    func correct() {
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        countdownTimer.invalidate()
        colorTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.flashGreen), userInfo: nil, repeats: true)
        if answerTimer != nil {
            answerTimer.invalidate()
        }
        
        streak += 1
        calls += 1
        
        if streak > longestStreak {
            longestStreak = streak
        }
        
        if calls == 1 {
            mostRecent = randomImage
            mostRecentCorrect = true
        }
        
        else if calls == 2 {
            secondRecent = mostRecent
            mostRecent = randomImage
            
            secondRecentCorrect = mostRecentCorrect
            mostRecentCorrect = true
        }
        
        else if calls >= 3 {
            thirdRecent = secondRecent
            secondRecent = mostRecent
            mostRecent = randomImage
            
            thirdRecentCorrect = secondRecentCorrect
            secondRecentCorrect = mostRecentCorrect
            mostRecentCorrect = true
        }
    }
    
    func wrong() {
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        countdownTimer.invalidate()
        colorTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.flashRed), userInfo: nil, repeats: true)
        if answerTimer != nil {
            answerTimer.invalidate()
        }
        
        streak = 0
        
        calls += 1
        
        if calls == 1 {
            mostRecent = randomImage
            mostRecentCorrect = false
        }
            
        else if calls == 2 {
            secondRecent = mostRecent
            mostRecent = randomImage
            
            secondRecentCorrect = mostRecentCorrect
            mostRecentCorrect = false
        }
            
        else if calls >= 3 {
            thirdRecent = secondRecent
            secondRecent = mostRecent
            mostRecent = randomImage
            
            thirdRecentCorrect = secondRecentCorrect
            secondRecentCorrect = mostRecentCorrect
            mostRecentCorrect = false
        }
    }
    
    func update() {
        if countdownTimer != nil {
            countdownTimer.invalidate()
            countdown = 5
        }
        
        if answerTimer != nil {
            answerTimer.invalidate()
        }
        randomImage = generateRandomImage()
        options = generateOptions(answer: randomImage)
        
        memberImage.image = UIImage(named: randomImage.replacingOccurrences(of: " ", with: ""))!
        button1.setTitle(options[0], for: .normal)
        button2.setTitle(options[1], for: .normal)
        button3.setTitle(options[2], for: .normal)
        button4.setTitle(options[3], for: .normal)
        
        timerbutton.setTitleColor(UIColor.black, for: .normal)
        timerbutton.setTitle("Time left: 5", for: .normal)
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countingDown), userInfo: nil, repeats: true)
        
        answerTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.timesUp), userInfo: nil, repeats: false)
    }
    
    func timesUp() {
        wrongButton = timerbutton
        timerbutton.setTitle("Time's Up!!", for: .normal)
        timerbutton.setTitleColor(UIColor.white, for: .normal)
        wrong()
    }
    
    func countingDown() {
        if countdown <= 0 {
            countdown = 6
            countdownTimer.invalidate()
        }
        
        countdown -= 1
        timerbutton.setTitle("Time left: " + String(countdown), for: .normal)
    }
    
    func flashGreen() {
        if count >= 5 {
            count = 0
            colorTimer.invalidate()
            playerScore += 1
            score.text = String(playerScore)
            update()
        }
        count += 1
        UIView.animate(withDuration: 0.1, delay: 0.1, options: [],
                       animations: {
                        
                        self.correctButton.backgroundColor = UIColor.green
            })
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: [],
                       animations: {
                        
                        self.correctButton.backgroundColor = UIColor.clear
            })
    }
    
    func flashRed() {
        if count >= 5 {
            count = 0
            colorTimer.invalidate()
            update()
        }
        count += 1
        UIView.animate(withDuration: 0.1, delay: 0.1, options: [],
                       animations: {
                        
                        self.wrongButton.backgroundColor = UIColor.red
        })
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: [],
                       animations: {
                        
                        self.wrongButton.backgroundColor = UIColor.clear
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "statisticsSegue" {
            if let destination = segue.destination as? StatisticsPageViewController {
                if longestStreak == -1 {
                    longestStreak = streak
                }
                
                if answerTimer != nil {
                    answerTimer.invalidate()
                }
                
                isStart = true
                startStop.setTitleColor(UIColor.black, for: .normal)
                startStop.backgroundColor = UIColor.green
                startStop.setTitle("Start", for: .normal)
                button1.isHidden = true
                button2.isHidden = true
                button3.isHidden = true
                button4.isHidden = true
                memberImage.isHidden = true
                timerbutton.isHidden = true
                mdbTitle.isHidden = false
                triviaIcon.isHidden = true
                score.isHidden = true
                scoreLabel.isHidden = true
                startButton.isHidden = false
                startStatisticsButton.isHidden = false
                startStop.isHidden = true
                statisticsButton.isHidden = true
                
                destination.longestStreakValue = longestStreak
                
                destination.mostRecentString = mostRecent
                destination.secondRecentString = secondRecent
                destination.thirdRecentString = thirdRecent
                
                destination.mostRecentBool = mostRecentCorrect
                destination.secondRecentBool = secondRecentCorrect
                destination.thirdRecentBool = thirdRecentCorrect
            }
        }
    }

}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

