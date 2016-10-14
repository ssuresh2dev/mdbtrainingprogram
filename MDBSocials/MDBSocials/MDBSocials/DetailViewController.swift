//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Mohit Katyal on 10/2/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    
    var eventImage : UIImage!
    var imageView : UIImageView!
    var navBarLabel : UILabel!
    var backButton : UIButton!
    var eventName : UILabel!
    var eventDate : UILabel!
    var eventOrganizerAndNumPpl : UILabel!
    var eventDescription : UILabel!
    var event : Event!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 207/255, green: 229/255, blue: 250/255, alpha: 1)
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        eventImage = #imageLiteral(resourceName: "eventImage")
        imageView = UIImageView(frame: CGRect(x: 0, y: 60, width: view.frame.width, height: view.frame.height * 0.3))
        imageView.image = eventImage
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        navBarLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 64))
        navBarLabel.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        view.addSubview(navBarLabel)
        
        backButton = UIButton(frame: CGRect(x: view.frame.width * 0, y: view.frame.height * 0.025, width: view.frame.width * 0.2, height: view.frame.height * 0.05))
        backButton.setTitle("<- Back", for: .normal)
        backButton.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1), for: .normal)
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        eventName = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.4, width: view.frame.width * 0.9, height: view.frame.height * 0.1))
        eventName.clipsToBounds = true
        eventName.layer.cornerRadius = 10
        eventName.text = "Event: " + event.eventName
//        eventName.backgroundColor = UIColor.black
        view.addSubview(eventName)
        
        eventDate = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.525, width: view.frame.width * 0.9, height: view.frame.height * 0.1))
//        eventDate.backgroundColor = UIColor.black
        eventDate.text = "Date: " + event.date
        eventDate.clipsToBounds = true
        eventDate.layer.cornerRadius = 10
        view.addSubview(eventDate)
        
        eventOrganizerAndNumPpl = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.65, width: view.frame.width * 0.9, height: view.frame.height * 0.1))
//        eventOrganizerAndNumPpl.backgroundColor = UIColor.black
        eventOrganizerAndNumPpl.text = "Organizer: " + event.user + "  RSVP'd: " + event.numAtendees
        eventOrganizerAndNumPpl.clipsToBounds = true
        eventOrganizerAndNumPpl.layer.cornerRadius = 10
        eventOrganizerAndNumPpl.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventOrganizerAndNumPpl.numberOfLines = 0
        view.addSubview(eventOrganizerAndNumPpl)
        
        eventDescription = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.725, width: view.frame.width * 0.9, height: view.frame.height * 0.225))
        eventDescription.text = event.description
        eventDescription.clipsToBounds = true
        eventDescription.layer.cornerRadius = 10
        eventDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventDescription.numberOfLines = 0
        view.addSubview(eventDescription)
    }
    
    func backPressed() {
        dismiss(animated: true, completion: nil)
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
