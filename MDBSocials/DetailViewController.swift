//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Jessica Chen on 10/2/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    var event: Event!
    var titleToBeSet: String!
    var whoPostedName: String!
    var usersInterested: [FIRUser]!
    var dateLabel: UILabel!
    var RSVPButton: UIButton!
    var interestedButton: UIButton!
    var backButton: UIButton!
    var descriptionLabel: UILabel!
    var descriptionText: String!

    
    override func viewDidLoad() {
        titleToBeSet = event.name
        whoPostedName = "Jessica Chen"
        usersInterested = event.usersInterested
        descriptionText = event.description
        
        super.viewDidLoad()
        setUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI() {
    
        view.backgroundColor = UIColor.white
        
        let backButton = UIButton(frame: CGRect(x: view.frame.width * 0, y: 0, width: view.frame.width * 0.2, height: view.frame.height * 0.1 ))
        backButton.setTitle("Back", for: .normal)
        backButton.backgroundColor = themeColor
        backButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        backButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        backButton.clipsToBounds = true
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        let eventTitleLabel = UILabel(frame: CGRect(x: view.frame.width * 0.2, y: 0, width: view.frame.width * 0.6, height: view.frame.height * 0.1))
        eventTitleLabel.text = titleToBeSet
        eventTitleLabel.textColor = UIColor.white
        eventTitleLabel.backgroundColor = themeColor
        eventTitleLabel.font = UIFont(name: "Avenir-Black", size: 24.0)
        eventTitleLabel.clipsToBounds = true
        eventTitleLabel.textAlignment = NSTextAlignment.center
        eventTitleLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(eventTitleLabel)
        
        
        let fillerLabel = UILabel(frame: CGRect(x: view.frame.width * 0.8 - 1, y: 0, width: view.frame.width * 0.2 + 1, height: view.frame.height * 0.1))
        fillerLabel.backgroundColor = themeColor
        fillerLabel.clipsToBounds = true
        view.addSubview(fillerLabel)
        
        let eventImageView = UIImageView(frame: CGRect(x: (view.frame.width - view.frame.height * 0.3)/2, y: view.frame.height * 0.1 + 30, width: view.frame.height * 0.3, height: view.frame.height * 0.3))
        eventImageView.image = UIImage(named: "IMG_2469")
        eventImageView.clipsToBounds = true
        view.addSubview(eventImageView)
        
        let whoPostedLabel = UILabel(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.4 + 50, width: view.frame.width * 0.6, height: 30))
        whoPostedLabel.text = "Created by: \(whoPostedName!)"
        whoPostedLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 16.0)
        whoPostedLabel.textAlignment = NSTextAlignment.center
        view.addSubview(whoPostedLabel)
        
        interestedButton = UIButton(frame: CGRect(x: (view.frame.width - view.frame.height * 0.3)/2, y: view.frame.height * 0.4 + 90, width: view.frame.height * 0.3, height: 30))
        //interestedButton.setTitle("\(usersInterested.count) people interested", for: UIControlState.normal)
        interestedButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        interestedButton.titleLabel!.adjustsFontSizeToFitWidth = true
        interestedButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        interestedButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        interestedButton.backgroundColor = themeColor
        interestedButton.addTarget(self, action: #selector(showPeople), for: UIControlEvents.touchUpInside)
        interestedButton.layer.cornerRadius = 5
        view.addSubview(interestedButton)
        
        RSVPButton = UIButton(frame: CGRect(x: view.frame.width * 0.45, y: view.frame.height * 0.4 + 130, width: view.frame.width * 0.1, height: 30))
        RSVPButton.setTitle("Not interested", for: UIControlState.normal)
        RSVPButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        RSVPButton.titleLabel!.adjustsFontSizeToFitWidth = true
        RSVPButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        RSVPButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        RSVPButton.backgroundColor = themeColor
        RSVPButton.addTarget(self, action: #selector(modifyPeople), for: UIControlEvents.touchUpInside)
        RSVPButton.layer.cornerRadius = 5
        view.addSubview(RSVPButton)

        descriptionLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.4 + 160, width: view.frame.width * 0.7, height: view.frame.height * 0.6 - 190))
        descriptionLabel.text = descriptionText
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 14.0)
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.textAlignment = NSTextAlignment.justified
        descriptionLabel.clipsToBounds = true
        view.addSubview(descriptionLabel)
        
    }
    
    func backPressed() {
        performSegue(withIdentifier: "backToFeed", sender: self)
    }
    
    func showPeople(_ sender: UIButton!) {
        performSegue(withIdentifier: "showRSVP", sender: self)
    }
    
    func modifyPeople(_ sender: UIButton!) {
        let user = FIRAuth.auth()?.currentUser
        if sender.titleLabel?.text == "Not interested" {
            usersInterested.append((user)!)
            sender.setTitle("Interested", for: .normal)
        } else {
//            let i = usersInterested.index(of: user?.displayName)
//            usersInterested.remove(at: i)
            sender.setTitle("Not interested", for: .normal)
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
