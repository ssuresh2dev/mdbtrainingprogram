//
//  NewSocialViewController.swift
//  MDBSocials
//
//  Created by Mohit Katyal on 10/2/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import Firebase

class NewSocialViewController: UIViewController {
    
    var navBarLabel : UILabel!
    var backButton : UIButton!
    var newEventLabel : UILabel!
    var eventNameLabel : UILabel!
    var eventNameTextField : UITextField!
    var eventLocationLabel : UILabel!
    var eventLocationTextField : UITextField!
    var eventDateLabel : UILabel!
    var eventDateTextField : UITextField!
    var eventStartTimeLabel : UILabel!
    var eventStartTimeTextField : UITextField!
    var eventEndTimeLabel : UILabel!
    var eventEndTimeTextField : UITextField!
    var nameLabel : UILabel!
    var nameTextField : UITextField!
    var eventDescLabel : UILabel!
    var eventDescTextField : UITextField!
    var eventPicLabel : UILabel!
    var eventPicButton : UIButton! //not done
    var createEventButton : UIButton!
    var ref : FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 207/255, green: 229/255, blue: 250/255, alpha: 1)
        ref = FIRDatabase.database().reference().child("events")
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI() {
        navBarLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 64))
        navBarLabel.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        view.addSubview(navBarLabel)
        
        backButton = UIButton(frame: CGRect(x: view.frame.width * 0, y: view.frame.height * 0.025, width: view.frame.width * 0.2, height: view.frame.height * 0.05))
        backButton.setTitle("<- Back", for: .normal)
        backButton.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1), for: .normal)
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        newEventLabel = UILabel(frame: CGRect(x: view.frame.width * 0.0375, y: 64 + view.frame.height * 0.025, width: view.frame.width * 0.925, height: view.frame.height * 0.1))
        newEventLabel.text = "Create a new Event"
        newEventLabel.textColor = UIColor.white
        newEventLabel.textAlignment = .center
        newEventLabel.font = UIFont(name: newEventLabel.font.fontName, size: 40)
        newEventLabel.backgroundColor = UIColor(red: 0/255, green: 115/255, blue: 230/255, alpha: 0.9)
        newEventLabel.layer.masksToBounds = true
        newEventLabel.layer.cornerRadius = 10
        view.addSubview(newEventLabel)
        
        eventNameLabel = UILabel(frame: CGRect(x: view.frame.width * 0.0375, y: 64 + view.frame.height * 0.15, width: view.frame.width * 0.35, height: view.frame.height * 0.05))
        eventNameLabel.text = "Name of Event:"
        eventNameLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        view.addSubview(eventNameLabel)
        
        eventNameTextField = UITextField(frame: CGRect(x: view.frame.width * 0.39, y: 64 + view.frame.height * 0.15, width: view.frame.width * 0.56, height: view.frame.height * 0.05))
        eventNameTextField.layer.masksToBounds = true
        eventNameTextField.layer.cornerRadius = 5
        eventNameTextField.layer.borderColor = UIColor.gray.cgColor
        eventNameTextField.layer.borderWidth = 1
        view.addSubview(eventNameTextField)
        
//        eventLocationLabel = UILabel(frame: CGRect(x: view.frame.width * 0.0375, y: 64 + view.frame.height * 0.225, width: view.frame.width * 0.2, height: view.frame.height * 0.05))
//        eventLocationLabel.text = "Location: "
//        eventLocationLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
//        view.addSubview(eventLocationLabel)
//        
//        eventLocationTextField = UITextField(frame: CGRect(x: view.frame.width * 0.25, y: 64 + view.frame.height * 0.225, width: view.frame.width * 0.7, height: view.frame.height * 0.05))
//        eventLocationTextField.layer.masksToBounds = true
//        eventLocationTextField.layer.cornerRadius = 5
//        eventLocationTextField.layer.borderColor = UIColor.gray.cgColor
//        eventLocationTextField.layer.borderWidth = 1
//        view.addSubview(eventLocationTextField)
        
        eventDateLabel = UILabel(frame: CGRect(x: view.frame.width * 0.3250, y: 64 + view.frame.height * 0.3, width: view.frame.width * 0.12, height: view.frame.height * 0.05))
        eventDateLabel.text = "Date: "
        eventDateLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        view.addSubview(eventDateLabel)
        
        eventDateTextField = UITextField(frame: CGRect(x: view.frame.width * 0.45, y: 64 + view.frame.height * 0.3, width: view.frame.width * 0.25, height: view.frame.height * 0.05))
        eventDateTextField.layer.masksToBounds = true
        eventDateTextField.layer.cornerRadius = 5
        eventDateTextField.layer.borderColor = UIColor.gray.cgColor
        eventDateTextField.layer.borderWidth = 1
        eventDateTextField.placeholder = " mm/dd/yyyy"
        view.addSubview(eventDateTextField)
        
        eventStartTimeLabel = UILabel(frame: CGRect(x: view.frame.width * 0.04, y: 64 + view.frame.height * 0.375, width: view.frame.width * 0.13, height: view.frame.height * 0.05))
        eventStartTimeLabel.text = "Start: "
        eventStartTimeLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        view.addSubview(eventStartTimeLabel)
        
        eventStartTimeTextField = UITextField(frame: CGRect(x: view.frame.width * 0.2, y: 64 + view.frame.height * 0.375, width: view.frame.width * 0.225, height: view.frame.height * 0.05))
        eventStartTimeTextField.layer.masksToBounds = true
        eventStartTimeTextField.layer.cornerRadius = 5
        eventStartTimeTextField.layer.borderColor = UIColor.gray.cgColor
        eventStartTimeTextField.layer.borderWidth = 1
        eventStartTimeTextField.placeholder = " hh:mm am"
        view.addSubview(eventStartTimeTextField)
        
        eventEndTimeLabel = UILabel(frame: CGRect(x: view.frame.width * 0.6, y: 64 + view.frame.height * 0.375, width: view.frame.width * 0.225, height: view.frame.height * 0.05))
        eventEndTimeLabel.text = "End: "
        eventEndTimeLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        view.addSubview(eventEndTimeLabel)
        
        eventEndTimeTextField = UITextField(frame: CGRect(x: view.frame.width * 0.725, y: 64 + view.frame.height * 0.375, width: view.frame.width * 0.225, height: view.frame.height * 0.05))
        eventEndTimeTextField.layer.masksToBounds = true
        eventEndTimeTextField.layer.cornerRadius = 5
        eventEndTimeTextField.layer.borderWidth = 1
        eventEndTimeTextField.layer.borderColor = UIColor.gray.cgColor
        eventEndTimeTextField.placeholder = " hh:mm pm"
        view.addSubview(eventEndTimeTextField)
        
        nameLabel = UILabel(frame: CGRect(x: view.frame.width * 0.0375, y: 64 + view.frame.height * 0.45, width: view.frame.width * 0.275, height: view.frame.height * 0.05))
        nameLabel.text = "Full Name: "
        nameLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        view.addSubview(nameLabel)
        
        nameTextField = UITextField(frame: CGRect(x: view.frame.width * 0.325, y: 64 + view.frame.height * 0.45, width: view.frame.width * 0.625, height: view.frame.height * 0.05))
        nameTextField.placeholder = "  Oski Bear"
        nameTextField.layer.masksToBounds = true
        nameTextField.layer.cornerRadius = 5
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(nameTextField)
        
        createEventButton = UIButton(frame: CGRect(x: view.frame.width * 0.0375, y: view.frame.height * 0.9, width: view.frame.width * 0.925, height: view.frame.height * 0.075))
        createEventButton.setTitle("Create Event!", for: .normal)
        createEventButton.setTitleColor(UIColor.white, for: .normal)
        createEventButton.layer.masksToBounds = true
        createEventButton.layer.cornerRadius = 10
        createEventButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)
        createEventButton.addTarget(self, action: #selector(createEvent), for: .touchUpInside)
        view.addSubview(createEventButton)
        
        eventDescLabel = UILabel(frame: CGRect(x: view.frame.width * 0.0375, y: 64 + view.frame.height * 0.5, width: view.frame.width * 0.275, height: view.frame.height * 0.05))
        eventDescLabel.text = "Even Description: "
        eventDescLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        view.addSubview(eventDescLabel)
        
        eventDescTextField = UITextField(frame: CGRect(x: view.frame.width * 0.325, y: 64 + view.frame.height * 0.52, width: view.frame.width * 0.625, height: view.frame.height * 0.2))
        eventDescTextField.placeholder = "Write a short description of your event"
        eventDescTextField.layer.masksToBounds = true
        eventDescTextField.layer.cornerRadius = 5
        eventDescTextField.layer.borderWidth = 1
        eventDescTextField.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(eventDescTextField)
        
        
//        eventPicLabel = UILabel(frame: CGRect(x: view.frame.width * 0.0375, y: 64 + view.frame.height * 0.73, width: view.frame.width * 0.275, height: view.frame.height * 0.05))
//        eventPicLabel.text = "Pick an Image!: "
//        eventPicLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
//        view.addSubview(eventPicLabel)
        
        
        
    }
    
    func createEvent() {
        let event : [String : String] = ["name":eventNameTextField.text!, "date":eventDateTextField.text!, "start":eventStartTimeTextField.text!, "end":eventEndTimeTextField.text!, "description":eventDescTextField.text!, "numPeople":"0", "user":nameTextField.text!]
        let ref = FIRDatabase.database().reference()
        ref.child("events").childByAutoId().setValue(event)
        dismiss(animated: true, completion: nil)
    }
    
    func backPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func selectImage(sender: UIButton)
    {
        
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
