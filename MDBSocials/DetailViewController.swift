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
    var numInterested: UILabel!
    var addToRSVP: UIButton!
    var titleOfEvent: UILabel!
    var paragraphText: UILabel!
    var displayImg: UIImage!

    
    let currUser = FIRAuth.auth()?.currentUser?.uid

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        numInterested = UILabel(frame: CGRect(x: 55, y: 510, width: 265, height: 21))
        numInterested.font = UIFont(name: "AvenirNext-Regular", size: 15.0)
        numInterested.textAlignment = NSTextAlignment.center
        numInterested.text = "\(passedEvent.rsvp.count) people interested"
        numInterested.textColor = UIColor.white
        view.addSubview(numInterested)
        
        addToRSVP = UIButton(frame: CGRect(x: 55, y: 555, width: 264, height: 33))
        print("this is what currrsvp has")
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
            print("this ran...")
            passedEvent.rsvp.append((currUser as NSString?)!)
            addToRSVP.setImage(#imageLiteral(resourceName: "Rsvped"), for: .normal)
        } else if (addToRSVP.currentImage == #imageLiteral(resourceName: "Rsvped")) {
            for (index, value) in passedEvent.rsvp.enumerated() {
                print("this the value :")
                print(value)
                if value == (currUser as NSString?)! {
                    passedEvent.rsvp.remove(at: index)
                }
            }
            addToRSVP.setImage(#imageLiteral(resourceName: "NotYetRsvp"), for: .normal)
        }
        
        let eventsRef = FIRDatabase.database().reference().child("events")
        let uniqueEventRef = eventsRef.child(eventIds[indexPath] as String)
        uniqueEventRef.child("userRsvp").setValue(passedEvent.rsvp)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
