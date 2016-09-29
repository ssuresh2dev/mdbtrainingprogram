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
        let segmentedControl = UISegmentedControl()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.insertSegment(withTitle: "List", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Grid", at: 1, animated: true)
        
        
        // Setting up a frame and Segmented Control
        segmentedControl.frame = CGRect(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height/10, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/20)
        
        // Editing the Segmented Control
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = UIColor.gray
        segmentedControl.tintColor = UIColor.white

        
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
