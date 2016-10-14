//
//  NewSocialViewController.swift
//  MDBSocials
//
//  Created by Jessica Chen on 10/2/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit
import Firebase


class NewSocialViewController: UIViewController {
    var nameTextField: UITextField!
    var pic: UILabel!
    var img: UIImageView!
    var picUploadButton: UIButton!
    var descTextField: UITextField!
    var dateTextField: UITextField!
    var timeTextField: UITextField!
    var createEventButton: UIButton!
    

    
    override func viewDidLoad() {
        setUI()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func uploadImage() {
        
    }
    
    
    func newSocial(){
        let social: [String: String] = ["name": nameTextField.text!, "date": dateTextField.text!, "time" : timeTextField.text!, "description": descTextField.text!, "numRSVPs": "0"]
        let ref = FIRDatabase.database().reference()
        ref.child("events").childByAutoId().setValue(social)
    }
    
    
    func setUI(){
        
        let margin = view.frame.width * 0.125
        
        let backButton = UIButton(frame: CGRect(x: view.frame.width * 0, y: 0, width: view.frame.width * 0.2, height: view.frame.height * 0.1 ))
        backButton.setTitle("Back", for: .normal)
        backButton.backgroundColor = themeColor
        backButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        backButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        backButton.clipsToBounds = true
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        let newSocialLabel = UILabel(frame: CGRect(x: view.frame.width * 0.2, y: 0, width: view.frame.width * 0.6, height: view.frame.height * 0.1))
        newSocialLabel.text = "New Social"
        newSocialLabel.textColor = UIColor.white
        newSocialLabel.backgroundColor = themeColor
        newSocialLabel.font = UIFont(name: "Avenir-Black", size: 24.0)
        newSocialLabel.clipsToBounds = true
        newSocialLabel.textAlignment = NSTextAlignment.center
        newSocialLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(newSocialLabel)
        
        let fillerLabel = UILabel(frame: CGRect(x: view.frame.width * 0.8 - 1, y: 0, width: view.frame.width * 0.2 + 1, height: view.frame.height * 0.1))
        fillerLabel.backgroundColor = themeColor
        fillerLabel.clipsToBounds = true
        view.addSubview(fillerLabel)
        
        
        nameTextField = UITextField(frame: CGRect(x: margin, y: view.frame.height * 0.1 + 50, width: view.frame.width * 0.75, height: 30))
        nameTextField.placeholder = "Event Name"
        nameTextField.clipsToBounds = true
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.font = UIFont(name: "Helvetica-Bold", size: 16.0)
        view.addSubview(nameTextField)
        
        picUploadButton = UIButton(frame: CGRect(x: margin, y: view.frame.height * 0.1 + 100, width: view.frame.width * 0.25, height: view.frame.height * 0.25))
        picUploadButton.setBackgroundImage(UIImage(named: "uploading"), for: .normal)
        picUploadButton.imageView!.contentMode = .scaleAspectFit
        picUploadButton.clipsToBounds = true
        picUploadButton.layer.cornerRadius = 5
        view.addSubview(picUploadButton)
        
        descTextField = UITextField(frame: CGRect(x: margin, y: view.frame.height * 0.35 + 120, width: view.frame.width - 2 * margin, height: view.frame.height * 0.3))
        descTextField.placeholder = "Event description"
        descTextField.font = UIFont(name: "HelveticaNeue", size: 14.0)
        descTextField.textRect(forBounds: CGRect(x: 5, y: 5, width: descTextField.frame.width - 10, height: descTextField.frame.height - 10))
        descTextField.borderStyle = .roundedRect
        descTextField.textAlignment = NSTextAlignment.justified
        descTextField.clipsToBounds = true
        view.addSubview(descTextField)
        
        dateTextField = UITextField(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.35 + 30, width: view.frame.width * 0.5 - margin, height: 30))
        dateTextField.placeholder = "Date"
        dateTextField.font = UIFont(name: "Helvetica-Bold", size: 16.0)
        dateTextField.textAlignment = NSTextAlignment.left
        dateTextField.adjustsFontSizeToFitWidth = true
        dateTextField.clipsToBounds = true
        view.addSubview(dateTextField)
        
        timeTextField = UITextField(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.35 + 70, width: view.frame.width * 0.5 - margin, height: 30))
        timeTextField.placeholder = "Time"
        timeTextField.font = UIFont(name: "Helvetica-Bold", size: 16.0)
        timeTextField.textAlignment = NSTextAlignment.left
        timeTextField.adjustsFontSizeToFitWidth = true
        timeTextField.clipsToBounds = true
        view.addSubview(timeTextField)
        
        createEventButton = UIButton(frame: CGRect(x: view.frame.width * 0.4, y: view.frame.height * 0.65 + 150, width: view.frame.width * 0.2, height: 30))
        createEventButton.setTitle("Create Event", for: .normal)
        createEventButton.backgroundColor = themeColor
        createEventButton.titleLabel!.font = UIFont(name: "Helvetica-Bold", size: 16.0)
        createEventButton.titleLabel!.adjustsFontSizeToFitWidth = true
        createEventButton.setTitleColor(UIColor.white, for: .normal)
        createEventButton.setTitleColor(UIColor.black, for: .highlighted)
        createEventButton.layer.cornerRadius = 5
        createEventButton.addTarget(self, action: #selector(newSocial), for: .touchUpInside)
        view.addSubview(createEventButton)
        
    }
    
    func backPressed(){
        performSegue(withIdentifier: "back2Feed", sender: self)
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
