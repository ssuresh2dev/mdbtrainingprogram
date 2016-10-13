//
//  NewSocialViewController.swift
//  Virindly
//
//  Created by Candice Ye on 10/4/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import UIKit

class NewSocialViewController: UIViewController {

    var newSocialBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Background
        newSocialBackground = UIImageView(image: #imageLiteral(resourceName: "orangeGradient"))
        newSocialBackground.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(newSocialBackground)
        
        
        // Navigation Bar
        let navBar2: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        let navTitle2 = UINavigationItem(title: "Create a new social!")
        let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.undo, target: nil, action: #selector(pressedBackButton))
        navTitle2.rightBarButtonItem = backButton
        navBar2.setItems([navTitle2], animated: false)
        
        self.view.addSubview(navBar2)

        
        
        
        /*
        // Navigation Bar
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        let navTitle2 = UINavigationItem(title: "Create a new social!")
        
        let addEvent = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.undo, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector))
        navTitle2.rightBarButtonItem = addEvent
        
        navBar.setItems([navTitle2], animated: false)
        self.view.addSubview(navBar)
        */
        

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ACTION
    func pressedBackButton(sender: UIButton!) {
        performSegue(withIdentifier: "segueBackToFeed", sender: self)
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
