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

class NewSocialViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var inputFullNameTextField: UITextField!
    var newSocialBackground: UIImageView!
    var virindlyMiniLogoView: UIImageView!
    var inputEventNameTextField: UITextField!
    var inputDescriptionTextField: UITextField!
    var inputDateTextField: UITextField!
    var inputImageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNewSocial()

        // Do any additional setup after loading the view.
            }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ACTION
    
    func setUpNewSocial() {
        
        // Background
        newSocialBackground = UIImageView(image: #imageLiteral(resourceName: "orangeGradient"))
        newSocialBackground.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(newSocialBackground)
        
        
        // Navigation Bar
        let navBar2: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        let navTitle2 = UINavigationItem(title: "Create a new social!")
        
        let backButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(pressedBackButton))
        navTitle2.leftBarButtonItem = backButton
        
        let completeEventButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(pressedCompleteEventButton))
        navTitle2.rightBarButtonItem = completeEventButton
        
        
        navBar2.setItems([navTitle2], animated: false)
        self.view.addSubview(navBar2)
        
        
        // Input Full Name Textfield
        inputFullNameTextField = UITextField()
        
        let inputFullNameTextFieldPlaceholder = NSAttributedString(string: "Your full name", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputFullNameTextField.attributedPlaceholder = inputFullNameTextFieldPlaceholder
        
        inputFullNameTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/5, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        inputFullNameTextField.font = UIFont.systemFont(ofSize: 15)
        inputFullNameTextField.borderStyle = UITextBorderStyle.roundedRect
        
        inputFullNameTextField.autocorrectionType = UITextAutocorrectionType.no
        inputFullNameTextField.keyboardType = UIKeyboardType.default
        inputFullNameTextField.returnKeyType = UIReturnKeyType.done
        
        self.view.addSubview(inputFullNameTextField)

        
        // Input Event Name Textfield
        inputEventNameTextField = UITextField()
        
        let inputEventNamePlaceholder = NSAttributedString(string: "Event name", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
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
        
        let inputDescriptionPlaceholder = NSAttributedString(string: "Short description", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
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
        
        // Input Image Button
        inputImageButton = UIButton(frame: CGRect(x: view.frame.width * 0.3, y: view.frame.height / 1.6, width: view.frame.width * 0.4, height: view.frame.width * 0.4))
        inputImageButton.contentMode = .scaleToFill
        inputImageButton.addTarget(self, action: #selector(openCameraRoll), for: .touchUpInside)
        inputImageButton.backgroundColor = UIColor.black
        view.addSubview(inputImageButton)
        
        // Mini VIRINDLY Logo
        virindlyMiniLogoView = UIImageView(image: #imageLiteral(resourceName: "VIRINDLYLogoOrange"))
        virindlyMiniLogoView.frame = CGRect(x: view.frame.width/2 - 50, y: 100, width: 100, height: 25)
        self.view.addSubview(virindlyMiniLogoView)
        
        
        let addEvent = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.undo, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector))
        self.navigationItem.rightBarButtonItem = addEvent
    }
    
    
    func pressedBackButton(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    func pressedCompleteEventButton(sender: UIButton!) {
        if let fullname = inputFullNameTextField.text, let event = inputEventNameTextField.text, let details = inputDescriptionTextField.text, let date = inputDescriptionTextField.text {
            let post: [String: String] = ["fullname": fullname, "event": event, "details": details, "date": date]
        
            let db = FIRDatabase.database().reference()
            db.child("posts").childByAutoId().setValue(post)
        
            performSegue(withIdentifier: "segueBackToFeed", sender: self)
        }
    }
    
    
    func openCameraRoll() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        inputImageButton.setBackgroundImage(image, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }

}
