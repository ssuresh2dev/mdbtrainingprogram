//
//  PauseViewController.swift
//  MatchMember
//
//  Created by Candice Ye on 9/21/16.
//  Copyright © 2016 Candice Ye. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {

    // OUTLETS
    @IBOutlet weak var labelStreak: UILabel!
    @IBOutlet weak var explainStreak: UILabel!
    @IBOutlet weak var valueStreak: UILabel!
    
    @IBOutlet weak var labelPrevMem: UILabel!
    @IBOutlet weak var explainPrevMem: UILabel!
    
    @IBOutlet weak var result1: UILabel!
    @IBOutlet weak var result2: UILabel!
    @IBOutlet weak var result3: UILabel!
    
    
    @IBOutlet weak var buttonGiveUp: UIButton!
    @IBOutlet weak var explainGiveUp: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStats()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ACTIONS
    
    func loadStats() {
        valueStreak.text = String(longestStreak)
        result1.text = getResult1
        result2.text = getResult2
        result3.text = getResult3
        
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
