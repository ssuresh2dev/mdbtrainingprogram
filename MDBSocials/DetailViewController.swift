//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Rochelle on 10/12/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class DetailViewController: UIViewController {
    var passedEvent: Event!
    var eventIds: [NSString]!
    var indexPath: Int!
    
    var eventImage: UIImageView!
    var modalView: UIButton!
    var numInterested: UIButton!
    var numInterestText: UILabel!
    var addToRSVP: UIButton!
    var titleOfEvent: UILabel!
    var paragraphText: UILabel!
    var displayImg: UIImage!
    
    var namesToDisplay: [String] = []
    
    var allRsvp: [NSString] = []

    var users: [User] = []
    
    
    let currUser = FIRAuth.auth()?.currentUser?.uid

    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        setUpUI()
        displayImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI(){
        eventImage = UIImageView(frame: CGRect(x: 42, y: 112, width: 292, height: 237))
        eventImage.contentMode = UIViewContentMode.scaleAspectFit
        eventImage.layer.cornerRadius = 7.0
        view.addSubview(eventImage)
        
        modalView = UIButton(frame: CGRect(x: 55, y: 504, width: 265, height: 33))
        modalView.setImage(#imageLiteral(resourceName: "PeopleInterested"), for: .normal)
        view.addSubview(modalView)
        

//        numInterestText = UILabel(frame: CGRect(x: 55, y: 510, width: 265, height: 21))
//        numInterestText.font = UIFont(name: "AvenirNext-Regular", size: 15.0)!
//        numInterestText.textAlignment = NSTextAlignment.center
//        numInterestText.text = "\(passedEvent.rsvp.count) people interested"
//        numInterestText.textColor = UIColor.white
        
        numInterested = UIButton(frame: CGRect(x: 55, y: 510, width: 265, height: 21))
        numInterested.setTitle("\(passedEvent.rsvp.count) people interested", for: .normal)
        numInterested.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 15.0)!
        numInterested.titleLabel?.textAlignment = NSTextAlignment.center
        numInterested.titleLabel?.textColor = UIColor.white
        numInterested.addTarget(self, action:#selector(pressedViewInterested), for: .touchUpInside)
        view.addSubview(numInterested)
        
        addToRSVP = UIButton(frame: CGRect(x: 55, y: 555, width: 264, height: 33))
        let ref = FIRDatabase.database().reference().child("events").child(eventIds[indexPath] as String)
        ref.observe(.value, with: { (snapshot) in
            if snapshot.hasChild("userRsvp") {
                let dict = snapshot.value as? [String : AnyObject]
                self.passedEvent.rsvp = dict?["userRsvp"] as! [NSString]
                if self.passedEvent.rsvp.contains((self.currUser as NSString?)!) {
                    self.addToRSVP.setImage(#imageLiteral(resourceName: "Rsvped"), for: .normal)
                } else {
                    self.addToRSVP.setImage(#imageLiteral(resourceName: "NotYetRsvp"), for: .normal)
                }
            } else {
                self.addToRSVP.setImage(#imageLiteral(resourceName: "NotYetRsvp"), for: .normal)
            }
            
        })

        addToRSVP.addTarget(self, action:#selector(pressedCountMeIn), for: .touchUpInside)
        view.addSubview(addToRSVP)
        
        titleOfEvent = UILabel(frame: CGRect(x: 48, y: 369, width: 292, height: 29))
        titleOfEvent.font = UIFont(name: "Bebas", size: 22)
        titleOfEvent.text = passedEvent?.eventTitle
        titleOfEvent.textAlignment = NSTextAlignment.center
        view.addSubview(titleOfEvent)
        
        paragraphText = UILabel(frame: CGRect(x: 42, y: 408, width: 292, height: 48))
        paragraphText.textAlignment = NSTextAlignment.center
        paragraphText.numberOfLines = 0
        paragraphText.font = UIFont(name: "AvenirNext-Regular", size: 12)
        paragraphText.text = passedEvent?.eventDescription
        view.addSubview(paragraphText)
    }
    
    func pressedCountMeIn() {
        if (addToRSVP.currentImage == #imageLiteral(resourceName: "NotYetRsvp")) {
            passedEvent.rsvp.append((currUser as NSString?)!)
            addToRSVP.setImage(#imageLiteral(resourceName: "Rsvped"), for: .normal)
        } else if (addToRSVP.currentImage == #imageLiteral(resourceName: "Rsvped")) {
            for (index, value) in passedEvent.rsvp.enumerated() {
                if value == (currUser as NSString?)! {
                    passedEvent.rsvp.remove(at: index)
                }
            }
            addToRSVP.setImage(#imageLiteral(resourceName: "NotYetRsvp"), for: .normal)
        }
        
        let eventsRef = FIRDatabase.database().reference().child("events")
        let uniqueEventRef = eventsRef.child(eventIds[indexPath] as String)
        uniqueEventRef.child("userRsvp").setValue(passedEvent.rsvp)
        
        
        numInterested.setTitle("\(passedEvent.rsvp.count) people interested", for: .normal)

    }
    
    func displayImage() {
        if (passedEvent.downloadURL != nil) {
            // Obtain URL from the FIRDatabase reference
            // postPhoto URL
            let obtainURL = NSURL(string: passedEvent.downloadURL!)
            // this URL convert into Data
            let picChosen = NSData(contentsOf: obtainURL as! URL)
            
            if picChosen != nil {
                self.eventImage.image = UIImage(data: picChosen as! Data)
            } else {
                print("An error occured while retrieving your uploaded picture")
            }
        }
    }
    
    func pressedViewInterested() {
        performSegue(withIdentifier: "aModal", sender: self)
    }
    
    func getUsers() {
        let usersRef = FIRDatabase.database().reference().child("users")
        let eventRef = FIRDatabase.database().reference().child("events").child(eventIds[indexPath] as String)

        eventRef.observe(.value, with: { (snapshot) in
            if snapshot.hasChild("userRsvp") {
                let dict = snapshot.value as? [String : AnyObject]
                self.allRsvp = dict?["userRsvp"] as! [NSString]
                
                usersRef.observe(.value, with: { (snapshot) in
                    let dictionary = snapshot.value as? [String : AnyObject]
                    for stringIds in self.allRsvp {
                        let user = User()
                        let userInfo = dictionary?[stringIds as String]
                        let firstName = (userInfo?["firstName"])!
                        let lastName = (userInfo?["lastName"])!

                        user.name = "\(firstName!) \(lastName!)"
                        self.users.append(user)
                    }
                    
                })
            
            }
            
        })
    }



//        
//        let ref = rootRef.child("events").child("\(events[indexPath.row])")
//        ref.observe(.value, with: { (snapshot) in
//            if let dictionary = snapshot.value as? [String: AnyObject]{
//                let event = Event()
//                event.eventTitle = dictionary["eventTitle"] as! String?
//                event.eventDate = dictionary["eventDate"] as! String?
//                event.eventDescription = dictionary["eventDescription"] as! String?
//                event.downloadURL = dictionary["downloadURL"] as! String?
//                event.poster = dictionary["poster"] as! String?
//                event.posterName = dictionary["posterName"] as! String?
//                
//                if  snapshot.hasChild("userRsvp") {
//                    event.rsvp = dictionary["userRsvp"] as! [NSString]
//                }
//                
//                self.eventsArray.append(event)
//        
        
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
   
        if segue.identifier == "aModal" {
            let dest = segue.destination as? ModalViewController
            
            dest?.users = self.users
        }
        
    }
    
    
    
 
}
