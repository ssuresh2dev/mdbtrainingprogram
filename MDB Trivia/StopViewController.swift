//
//  StopViewController.swift
//  MDB Trivia
//
//  Created by Shubham Goenka on 22/09/16.
//  Copyright © 2016 miniprojects. All rights reserved.
//

import UIKit

class StopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadStats()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadStats() {
        streak.text = String(longestStreak)
        last.text = lastAnswer
        secondLast.text = secondLastAnswer
        thirdLast.text = thirdLastAnswer
    }
    
    
    @IBOutlet weak var streak: UILabel!
    
    @IBOutlet weak var last: UILabel!
    
    @IBOutlet weak var secondLast: UILabel!
    
    @IBOutlet weak var thirdLast: UILabel!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
