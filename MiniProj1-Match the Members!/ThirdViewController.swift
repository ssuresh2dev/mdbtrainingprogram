//
//  ThirdViewController.swift
//  MiniProj1-Match the Members!
//
//  Created by Vidya Ravikumar on 9/21/16.
//  Copyright © 2016 Vidya Ravikumar. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var streak: UILabel!
    @IBOutlet weak var prevAns1: UILabel!
    @IBOutlet weak var prevAns2: UILabel!
    @IBOutlet weak var prevAns3: UILabel!
    var streakStr: String  = ""
    var playersArray: [String] = []
    var currScore: Int! = 0
    var highScore: Int! = 0

    override func viewDidLoad(){
        super.viewDidLoad()
        streak.text = streakStr
        if(playersArray.count == 4){
            prevAns1.text = playersArray[2]
            prevAns2.text = playersArray[1]
            prevAns3.text = playersArray[0]
        }
        else if(playersArray.count == 3 ){
            prevAns1.text = playersArray[1]
            prevAns1.text = playersArray[0]
        }
        else if (playersArray.count == 2){
            prevAns1.text = playersArray[0]
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueBack") {
            //get a reference to the destination view controller
            let gameVC = segue.destination as! SecondViewController
            //set properties on the destination view controller
            gameVC.currentScore = currScore
            gameVC.lastThreeAndCurr = playersArray
            gameVC.hiScore = highScore
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
