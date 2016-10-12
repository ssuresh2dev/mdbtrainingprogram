//
//  CreateEventViewController.swift
//  MDBSocials
//
//  Created by Eliot Han on 10/5/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    var eventTitleField: UITextField!
    var eventDescriptonTextField: UITextField!
    var imageView: UIImageView!
    var eventDateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        view.backgroundColor = Constants.Colors.purpleColor
        
        let postEventButton = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(CreateEventViewController.postButtonClicked))
        self.navigationItem.rightBarButtonItem = postEventButton
        
        eventTitleField = UITextField(frame: CGRect(x: 20, y: (self.navigationController?.navigationBar.frame.height)! + 20, width: view.frame.width - 20, height: 50))
        eventTitleField.placeholder = "What is the title of your event?"
        view.addSubview(eventTitleField)
        
        eventDescriptonTextField = UITextField(frame: CGRect(x: 20, y: eventTitleField.frame.maxY + 25, width: view.frame.width - 20, height: 50))
        eventDescriptonTextField.placeholder = "Describe your event."
        view.addSubview(eventDescriptonTextField)
        
        //photopicker cocoapod here
        
        
    }
    
    func postButtonClicked(){
        
        performSegue(withIdentifier: "unwindToFeedVC", sender: self)
    }
}
