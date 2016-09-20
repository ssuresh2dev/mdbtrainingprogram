//
//  TriviaViewController.swift
//  MDBProfile
//
//  Created by Ben Goldberg on 9/19/16.
//  Copyright © 2016 Rochelle. All rights reserved.
//

import UIKit

class TriviaViewController: UIViewController {
    
    var name = ""
    var picked: [String] = []
    var images: [String] = []
    var gender = arc4random_uniform(2)
    let guyNames = ["Aayush Tyagi", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa", "Ali Shelton", "Andy Wang", "Aneesh Jindal", "Ankur Mahesh", "Ashwin Vaidyanathan", "Ben Goldberg", "Billy Lu", "Cody Hsieh", "Connor Killion", "Edward Liu", "Eliot Han", "Emaan Hariri", "Jared Guiterrez", "Jeffrey Zhang", "Justin Kim", "Kedar Thakkar", "Kenneth Steele", "Kevin Jiang", "Krishnan Rajiyah", "Leon Kwak", "Mohit Katyal", "Mudit Mittal", "Peter Schafhalter", "Richard Chen", "Richard Hu", "Riley Edmunds", "Rohan Narayan", "Sahil Lamba", "Sameer Suresh", "Sayan Paul", "Shaan Appel", "Shubham Goenka", "Sirjan Kafle", "Tarun Khasnavis", "Victor Sun", "Virindh Borra", "Wilbur Shi", "Young Lin"]
    
    let girlNames = ["Alice Wang", "Ally Koo", "Anisha Salunkhe", "Aparna Krishnan", "Candice Ye", "Christine Munar", "Jessica Chen", "Jessica Cherny", "Jessica Ji", "Katharine Jiang", "Kristin Ho", "Lisa Lee", "Mansi Shah", "Rochelle Shen", "Sharie Wang", "Shreya Reddy", "Sona Jeswani", "Vidya Ravikumar"]


    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var startStop: UIButton!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBAction func next(_ sender: UIButton) {
        pickImage()
        makeButtons()
    }
    
    func pickImage() {
        if gender == 1 {
            name = guyNames[Int(arc4random_uniform(42))]
            while images.contains(name) {
                name = guyNames[Int(arc4random_uniform(42))]
            }
            images += [name]
            let imageName = String(name.characters.filter {$0 != " "})
            picture.image = UIImage(named: imageName)
        } else {
            name = girlNames[Int(arc4random_uniform(18))]
            while images.contains(name) {
                name = girlNames[Int(arc4random_uniform(18))]
            }
            images += [name]
            let imageName = String(name.characters.filter {$0 != " "})
            picture.image = UIImage(named: imageName)
        }
    }
    
    func makeButtons() {
        var buttonArray = [button0, button1, button2, button3]
        let correctButtonIndex = Int(arc4random_uniform(4))
        buttonArray.remove(at: correctButtonIndex)
        
        switch correctButtonIndex {
        case 0:
            button0.setTitle(name, for: .normal)
        case 1:
            button1.setTitle(name, for: .normal)
        case 2:
            button2.setTitle(name, for: .normal)
        case 3:
            button3.setTitle(name, for: .normal)
        default:
            break
        }
        
        var randomName = ""
        for button in buttonArray {
            if gender == 1 {
                randomName = guyNames[Int(arc4random_uniform(42))]
                while randomName == name || picked.contains(randomName) {
                    randomName = guyNames[Int(arc4random_uniform(42))]
                }
            } else {
                randomName = girlNames[Int(arc4random_uniform(18))]
                while randomName == name || picked.contains(randomName) {
                    randomName = girlNames[Int(arc4random_uniform(18))]
                }
            }
            picked += [randomName]
            button!.setTitle(randomName, for: .normal)
        }
        gender = arc4random_uniform(2)
    }

    override func viewDidLoad() {
        pickImage()
        makeButtons()
    }
}
