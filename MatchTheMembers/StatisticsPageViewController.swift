//
//  StatisticsPageViewController.swift
//  MatchTheMembers
//
//  Created by Kevin Jiang on 9/21/16.
//  Copyright © 2016 Kevin Jiang. All rights reserved.
//

import UIKit

class StatisticsPageViewController: UIViewController {
    @IBOutlet var box: UIImageView!
    @IBOutlet var thirdRecentCorrect: UILabel!
    @IBOutlet var secondRecentCorrect: UILabel!
    @IBOutlet var mostRecentCorrect: UILabel!
    @IBOutlet var thirdRecentName: UILabel!
    @IBOutlet var secondRecentName: UILabel!
    @IBOutlet var mostRecentName: UILabel!
    @IBOutlet var longestStreak: UILabel!
    
    @IBOutlet var thirdRecent: UIImageView!
    @IBOutlet var secondRecent: UIImageView!
    @IBOutlet var mostRecent: UIImageView!
    
    var longestStreakValue: Int!
    var mostRecentString: String!
    var secondRecentString: String!
    var thirdRecentString: String!
    var mostRecentBool: Bool!
    var secondRecentBool: Bool!
    var thirdRecentBool: Bool!
    var buttonColor = UIColor.init(red: 45/255, green: 138/255, blue: 230/255, alpha: 1.0)
    var resultColor = UIColor.init(red: 55/255, green: 182/255, blue: 80/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg-2")!)
        box.layer.borderColor = buttonColor.cgColor
        box.layer.borderWidth = 1
        
        thirdRecentCorrect.isHidden = true
        secondRecentCorrect.isHidden = true
        mostRecentCorrect.isHidden = true
        mostRecentName.isHidden = true
        secondRecentName.isHidden = true
        thirdRecentName.isHidden = true
        
        longestStreak.text = String(longestStreakValue)
        
        if mostRecentString != nil {
            mostRecent.image = UIImage(named: mostRecentString.replacingOccurrences(of: " ", with: ""))!
            mostRecentName.text = mostRecentString
            
            if mostRecentBool == true {
                mostRecentCorrect.textColor = resultColor
                mostRecentCorrect.text = "Correct"
            } else {
                mostRecentCorrect.textColor = UIColor.red
                mostRecentCorrect.text = "Wrong"
            }
            
            mostRecentName.isHidden = false
            mostRecentCorrect.isHidden = false
        }
        
        if secondRecentString != nil {
            secondRecent.image = UIImage(named: secondRecentString.replacingOccurrences(of: " ", with: ""))!
            secondRecentName.text = secondRecentString
            
            if secondRecentBool == true {
                secondRecentCorrect.textColor = resultColor
                secondRecentCorrect.text = "Correct"
            } else {
                secondRecentCorrect.textColor = UIColor.red
                secondRecentCorrect.text = "Wrong"
            }
            
            secondRecentName.isHidden = false
            secondRecentCorrect.isHidden = false
        }
        
        if thirdRecentString != nil {
            thirdRecent.image = UIImage(named: thirdRecentString.replacingOccurrences(of: " ", with: ""))!
            thirdRecentName.text = thirdRecentString
            
            if thirdRecentBool == true {
                thirdRecentCorrect.textColor = resultColor
                thirdRecentCorrect.text = "Correct"
            } else {
                thirdRecentCorrect.textColor = UIColor.red
                thirdRecentCorrect.text = "Wrong"
            }
            
            thirdRecentName.isHidden = false
            thirdRecentCorrect.isHidden = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
