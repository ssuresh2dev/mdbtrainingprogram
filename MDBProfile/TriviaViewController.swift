//
//  TriviaViewController.swift
//  MDBProfile
//
//  Created by Ben Goldberg on 9/19/16.
//  Copyright © 2016 Rochelle. All rights reserved.
//

import UIKit

class TriviaViewController: UIViewController {
    
    var picked: [String]!
    
    @IBOutlet weak var picture: UIImageView!
    
    
    @IBAction func answerChosen(_ sender: UIButton) {
        pickName(button: button0)
        pickName(button: button1)
        pickName(button: button2)
        pickName(button: button3)
        
        let correctButtonIndex = arc4random_uniform(4)
    }
    
    func pickName(button: UIButton) {
        let newName = names[Int(arc4random_uniform(60))]
        if picked.contains(newName) {
            pickName(button: button)
        } else {
            picked += [newName]
            button.setTitle(newName, for: .normal)
        }
    }
    
    let names = ["Aayush Tyagi", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa", "Alice Wang", "Ali Shelton", "Ally Koo", "Andy Wang", "Aneesh Jindal", "Anisha Salunkhe", "Ankur Mahesh", "Aparna Krishnan", "Ashwin Vaidyanathan", "Ben Goldberg", "Billy Lu", "Candice Ye", "Christine Munar", "Cody Hsieh", "Connor Killion", "Edward Liu", "Eliot Han", "Emaan Hariri", "Jared Gutierrez", "Jeffrey Zhang", "Jessica Chen", "Jessica Cherny", "Jessica Ji", "Justin Kim", "Katharine Jiang", "Kedar Thakkar", "Kenneth Steele", "Kevin Jiang", "Krishnan Rajiyah", "Kristin Ho", "Leon Kwak", "Lisa Lee", "Mansi Shah", "Mohit Katyal", "Mudit Mittal", "Peter Schafhalter", "Richard Chen", "Richard Hu", "Riley Edmunds", "Rochelle Shen", "Rohan Narayan", "Sahil Lamba", "Sameer Suresh", "Sayan Paul", "Shaan Appel", "Sharie Wang", "Shreya Reddy", "Shubham Goenka", "Sirjan Kafle", "Sona Jeswani", "Tarun Khasnavis", "Victor Sun", "Vidya Ravikumar", "Virindh Borra", "Wilbur Shi", "Young Lin"]
    
    let guyNames = ["Aayush Tyagi", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa", "Ali Shelton", "Andy Wang", "Aneesh Jindal", "Ankur Mahesh", "Ashwin Vaidyanathan", "Ben Goldberg", "Billy Lu", "Cody Hsieh", "Connor Killion", "Edward Liu", "Eliot Han", "Emaan Hariri", "Jared Guiterrez", "Jeffrey Zhang", "Justin Kim", "Kedar Thakkar", "Kenneth Steele", "Kevin Jiang", "Krishnan Rajiyah", "Leon Kwak", "Mohit Katyal", "Mudit Mittal", "Peter Schafhalter", "Richard Chen", "Richard Hu", "Riley Edmunds", "Rohan Narayan", "Sahil Lamba", "Sameer Suresh", "Sayan Paul", "Shaan Appel", "Shubham Goenka", "Sirjan Kafle", "Tarun Khasnavis", "Victor Sun", "Virindh Borra", "Wilbur Shi", "Young Lin"]
    
    let girlNames = ["Alice Wang", "Ally Koo", "Anisha Salunkhe", "Aparna Krishnan", "Candice Ye", "Christine Munar", "Jessica Chen", "Jessica Cherny", "Jessica Ji", "Katharine Jiang", "Kristin Ho", "Lisa Lee", "Mansi Shah", "Rochelle Shen", "Sharie Wang", "Shreya Reddy", "Sona Jeswani", "Vidya Ravikumar"]
    
    override func viewDidLoad() {
        <#code#>
    }
    
}
