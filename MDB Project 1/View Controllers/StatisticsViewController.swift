//
//  StatisticsViewController.swift
//  MDB Project 1
//
//  Created by Eliot Han on 9/19/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController{
    var streakNum = 0
    @IBOutlet weak var streakLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        streakLabel.text = "Streak: \(streakNum)"
        
        
        // Do any additional setup after loading the view.
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
