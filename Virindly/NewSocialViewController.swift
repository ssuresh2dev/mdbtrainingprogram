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
    var virindlyMiniLogoView: UIImageView!
    var inputEventNameTextField: UITextField!
    var inputDescriptionTextField: UITextField!
    
    //let dateSelect: UIDatePicker =
    
    
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
        navTitle2.leftBarButtonItem = backButton
        
        let completeEventButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(pressedCompleteEventButton))
        navTitle2.rightBarButtonItem = completeEventButton
        
        
        navBar2.setItems([navTitle2], animated: false)
        self.view.addSubview(navBar2)
        
        
        // Input Full Name Textfield
        inputEventNameTextField = UITextField()
        
        let inputEventNamePlaceholder = NSAttributedString(string: "Event name here", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputEventNameTextField.attributedPlaceholder = inputEventNamePlaceholder
        
        inputEventNameTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/3.3, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        inputEventNameTextField.font = UIFont.systemFont(ofSize: 15)
        inputEventNameTextField.borderStyle = UITextBorderStyle.roundedRect
        
        inputEventNameTextField.autocorrectionType = UITextAutocorrectionType.no
        inputEventNameTextField.keyboardType = UIKeyboardType.default
        inputEventNameTextField.returnKeyType = UIReturnKeyType.done
        
        self.view.addSubview(inputEventNameTextField)
        
        
        // Input Description Textfield
        inputDescriptionTextField = UITextField()
        
        let inputDescriptionPlaceholder = NSAttributedString(string: "Short description here", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputDescriptionTextField.attributedPlaceholder = inputDescriptionPlaceholder
        
        inputDescriptionTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/2.5, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        inputDescriptionTextField.font = UIFont.systemFont(ofSize: 15)
        inputDescriptionTextField.borderStyle = UITextBorderStyle.roundedRect
        
        inputDescriptionTextField.autocorrectionType = UITextAutocorrectionType.no
        inputDescriptionTextField.keyboardType = UIKeyboardType.default
        inputDescriptionTextField.returnKeyType = UIReturnKeyType.done
        
        self.view.addSubview(inputDescriptionTextField)
        
        
        // Date Picker
        
        


        
        
        
        // Mini VIRINDLY Logo
        virindlyMiniLogoView = UIImageView(image: #imageLiteral(resourceName: "VIRINDLYLogoOrange"))
        virindlyMiniLogoView.frame = CGRect(x: 15, y: 100, width: 100, height: 25)
        self.view.addSubview(virindlyMiniLogoView)
        
        
        
        

        
        
        
        

        
        
        
        
        let addEvent = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.undo, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector))
        self.navigationItem.rightBarButtonItem = addEvent
        
        
        

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ACTION
    func pressedBackButton(sender: UIButton!) {
        performSegue(withIdentifier: "segueBackToFeed", sender: self)
    }
    
    func pressedCompleteEventButton(sender: UIButton!) {
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
