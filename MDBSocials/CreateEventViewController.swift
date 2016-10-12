//
//  CreateEventViewController.swift
//  MDBSocials
//
//  Created by Eliot Han on 10/5/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    var eventTitleLabel: UILabel!
    var eventDescriptonTextField: UITextView!
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
        let postEventButton = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(CreateEventViewController.postButtonClicked))
        self.navigationItem.rightBarButtonItem = postEventButton
    }
    
    func postButtonClicked(){
        
        performSegue(withIdentifier: "unwindToFeedVC", sender: self)
    }
}
