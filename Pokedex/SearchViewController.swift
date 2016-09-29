//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Candice Ye on 9/28/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchName: UILabel!
    @IBOutlet weak var searchNumber: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var HP: UITextField!
    @IBOutlet weak var attack: UITextField!
    @IBOutlet weak var defense: UITextField!
    
    @IBOutlet weak var typeText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
