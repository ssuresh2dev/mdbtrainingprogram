//
//  NewSocialViewController.swift
//  Virindly
//
//  Created by Candice Ye on 10/4/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NewSocialViewController: UIViewController {

    var newSocialBackground: UIImageView!
    var virindlyMiniLogoView: UIImageView!
    var inputEventNameTextField: UITextField!
    var inputDescriptionTextField: UITextField!
    var inputDateTextField: UITextField!
    
    
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
        
        
        // Input Date Textfield
        inputDateTextField = UITextField()
        
        let inputDatePlaceholder = NSAttributedString(string: "Date of event", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputDateTextField.attributedPlaceholder = inputDatePlaceholder
        
        inputDateTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        inputDateTextField.font = UIFont.systemFont(ofSize: 15)
        inputDateTextField.borderStyle = UITextBorderStyle.roundedRect
        
        inputDateTextField.autocorrectionType = UITextAutocorrectionType.no
        inputDateTextField.keyboardType = UIKeyboardType.default
        inputDateTextField.returnKeyType = UIReturnKeyType.done
        
        self.view.addSubview(inputDateTextField)
        
        
        
        
        
        
        
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
        dismiss(animated: true, completion: nil)
    }
    
    func pressedCompleteEventButton(sender: UIButton!) {
        if let event = inputEventNameTextField.text, let details = inputDescriptionTextField.text, let date = inputDescriptionTextField.text {
            let post: [String: String] = ["event": event, "details": details, "date": date]
        
            let db = FIRDatabase.database().reference()
            db.child("posts").childByAutoId().setValue(post)
        
            performSegue(withIdentifier: "segueBackToFeed", sender: self)
        }
    }

}
