//
//  ListGridViewController.swift
//  Pokedex
//
//  Created by Candice Ye on 9/28/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ListGridViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white

        // Initializing
        let viewChoices = ["List", "Grid"]
        let segmentedControl = UISegmentedControl()
        segmentedControl.selectedSegmentIndex = 0
        
        // Setting up a frame and Segmented Control
        let frame = UIScreen.main.bounds
        segmentedControl.frame = CGRect(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height/12, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/16)
        
        // Editing the Segmented Control
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = UIColor.gray
        //segmentedControl.segm
        segmentedControl.setTitle("List", forSegmentAt: 0)
        segmentedControl.setTitle("Grid", forSegmentAt: 1)

        
        // Add this custom Segmented Control to our view
        self.view.addSubview(segmentedControl)
    }
    
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
