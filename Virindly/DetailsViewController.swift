//
//  DetailsViewController.swift
//  Virindly
//
//  Created by Candice Ye on 10/20/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController {

    var detailsBackground: UIImageView!
    var eventImage: UIImageView!
    var eventName: UILabel!
    var eventDescription: UILabel!
    var eventPoster: UILabel!
    var eventDate: UILabel!
    var rsvpButton: UIButton!
    var numAttendees: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetails()
        setUpNavBar()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // SET UP NAVIGATION BAR
    func setUpNavBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        let navTitle = UINavigationItem(title: "What's this event about?")
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(pressedDetailsBack))
        navTitle.leftBarButtonItem = backButton
        navBar.setItems([navTitle], animated: true)
        self.view.addSubview(navBar)
    }
    
    
    // SET UP DETAILS SCREEN
    func setUpDetails() {
        // Background
        detailsBackground = UIImageView(image: #imageLiteral(resourceName: "orangeGradient"))
        detailsBackground.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        // Event Image
        eventImage = UIImageView(frame: CGRect(x: 0, y: 85, width: view.frame.width, height: view.frame.height/2 - 40))
        eventImage.backgroundColor = UIColor.green.withAlphaComponent(0.4)
        
        // Event Name Label
        eventName = UILabel(frame: CGRect(x: 20, y: view.frame.height/2 + 40, width: view.frame.width - 40, height: 80))
        eventName.text = "Event Name" // temporary data
        eventName.font = UIFont(name: "AvenirNext-Bold", size: 30)
        eventName.textColor = UIColor.black.withAlphaComponent(0.8)
        
        // Event Date
        eventDate = UILabel(frame: CGRect(x: 20, y: view.frame.height/2 + 70, width: view.frame.width - 40, height: 80))
        eventDate.text = "07/11/2016" // temporary data
        eventDate.font = UIFont(name: "AvenirNext", size: 15)
        
        // Event Poster
        eventPoster = UILabel(frame: CGRect(x: 20, y: view.frame.height/2 + 100, width: view.frame.width - 40, height: 80))
        eventPoster.text = "Hosted by: \("Candice Ye")" // temporary data
        eventPoster.font = UIFont(name: "AvenirNext", size: 15)
        
         // Event Description
        eventDescription = UILabel(frame: CGRect(x: 20, y: view.frame.height/2 + 150, width: view.frame.width - 40, height: 80))
        eventDescription.clipsToBounds = true
        eventDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventDescription.numberOfLines = 2
        eventDescription.minimumScaleFactor = 0.5
        eventDescription.font = UIFont(name: "AvenirNext", size: 12)
        eventDescription.adjustsFontSizeToFitWidth = true
        eventDescription.text = "Really cool event please come! I hope this works. I want to sleep! :)"
        
        // RSVP Button
        rsvpButton = UIButton(frame: CGRect(x: 30, y: view.frame.height/2 + 230, width: view.frame.width/4, height: 25))
        rsvpButton.setTitle("RSVP", for: .normal)
        rsvpButton.titleLabel!.font = UIFont(name: "AvenirNext", size: 20)
        rsvpButton.titleLabel!.textColor = UIColor.white
        rsvpButton.tintColor = UIColor.white
        rsvpButton.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        rsvpButton.layer.cornerRadius = 5
        // rsvpButton.addTarget(self, action: #selector(changeToInterested), for: .touchUpInside)

        // Number of People RSVP'd
        numAttendees = UILabel(frame: CGRect(x: view.frame.width/2 - 40, y: view.frame.height/2 + 203, width: view.frame.width - 40, height: 80))
        numAttendees.textColor = UIColor.white
        numAttendees.text = "\(10) people are interested" // temporary data
        numAttendees.font = UIFont(name: "AvenirNext", size: 15)

        // Add Subviews
        self.view.addSubview(detailsBackground)
        self.view.addSubview(eventImage)
        self.view.addSubview(eventName)
        self.view.addSubview(eventPoster)
        self.view.addSubview(eventDate)
        self.view.addSubview(eventDescription)
        self.view.addSubview(rsvpButton)
        self.view.addSubview(numAttendees)
    }
    
    
    // ACTIONS
    
    func pressedDetailsBack(Sender: UIButton!) {
        performSegue(withIdentifier: "segueDetailsToFeed", sender: self)
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


