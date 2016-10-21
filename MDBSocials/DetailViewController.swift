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
    let user = FIRAuth.auth()?.currentUser
    var event: Event!
    var titleToBeSet: String!
    var whoPostedName: String!
    var usersInterested: [String: String]!
    var dateTimeLabel: UITextView!
    var RSVPButton: UIButton!
    var interestedButton: UIButton!
    var backButton: UIButton!
    var descriptionLabel: UITextView!
    var descriptionText: String!
    var status: GoingStatus = GoingStatus.notResponded
    var date: String!
    var time: String!
    
    override func viewDidLoad() {
        titleToBeSet = event.name
        whoPostedName = event.poster
        date = event.date
        time = event.time
        usersInterested = event.getUsersInterested()
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
        interestedButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        interestedButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        interestedButton.backgroundColor = themeColor
        interestedButton.addTarget(self, action: #selector(showPeople), for: UIControlEvents.touchUpInside)
        interestedButton.layer.cornerRadius = 5
        view.addSubview(interestedButton)
        
        RSVPButton = UIButton(frame: CGRect(x: view.frame.width * 0.45, y: view.frame.height * 0.4 + 130, width: view.frame.width * 1/4, height: 30))
        RSVPButton.setTitle("Interested", for: UIControlState.normal)
        RSVPButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        RSVPButton.titleLabel!.adjustsFontSizeToFitWidth = false
        RSVPButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        RSVPButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        RSVPButton.backgroundColor = themeColor
        RSVPButton.addTarget(self, action: #selector(modifyPeople), for: UIControlEvents.touchUpInside)
        RSVPButton.layer.cornerRadius = 5
        view.addSubview(RSVPButton)

        descriptionLabel = UITextView(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.4 + 160, width: view.frame.width * 0.7, height: view.frame.height * 0.6 - 190))
        descriptionLabel.text = descriptionText
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.textAlignment = NSTextAlignment.justified
        descriptionLabel.clipsToBounds = true
        descriptionLabel.textAlignment = NSTextAlignment.center
        
        dateTimeLabel = UITextView(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.4 + 250, width: view.frame.width * 0.7, height: view.frame.height * 0.6 - 190))
        dateTimeLabel.text = "\(time!)\n\(date!)"
        dateTimeLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        dateTimeLabel.textColor = UIColor.black
        dateTimeLabel.textAlignment = NSTextAlignment.justified
        dateTimeLabel.clipsToBounds = true
        dateTimeLabel.textAlignment = NSTextAlignment.center
        
        view.addSubview(descriptionLabel)
        view.addSubview(dateTimeLabel)
        
    }
    
    func backPressed() {
        performSegue(withIdentifier: "backToFeed", sender: self)
    }
    
    func showPeople(_ sender: UIButton!) {
        performSegue(withIdentifier: "showRSVP", sender: self)
    }
    
    func modifyPeople(_ sender: UIButton!) {
        switch event.status {
        case .notResponded:
                event.status = .interested
                RSVPButton.backgroundColor = UIColor.green
                event.usersInterested[user!.uid] = user!.displayName
                event.updateInterestedUser(user: user!)
                dismiss(animated: false, completion: nil)
            
        case .interested:
                event.status = .notResponded
                RSVPButton.backgroundColor = themeColor
                event.usersInterested.removeValue(forKey: user!.uid)
                event.updateInterestedUser(user: user!)
                dismiss(animated: false, completion: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRSVP"{
            let next = segue.destination as! RSVPViewController
            next.event = self.event
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
