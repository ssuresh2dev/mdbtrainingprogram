//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Jessica Chen on 10/2/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var titleToBeSet: String! = "TestTitleOfEvent"
    var whoPostedName: String! = "TestPerson"
    var testPeopleRSVP: String! = "17"
    var backButton: UIButton!
    
    override func viewDidLoad() {
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
        
        let whoInterestedButton = UIButton(frame: CGRect(x: (view.frame.width - view.frame.height * 0.3)/2, y: view.frame.height * 0.4 + 90, width: view.frame.height * 0.3, height: 30))
        whoInterestedButton.setTitle("\(testPeopleRSVP!) people interested", for: UIControlState.normal)
        whoInterestedButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        whoInterestedButton.titleLabel!.adjustsFontSizeToFitWidth = true
        whoInterestedButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        whoInterestedButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        whoInterestedButton.backgroundColor = themeColor
        whoInterestedButton.addTarget(self, action: #selector(DetailViewController.showPeople), for: UIControlEvents.touchUpInside)
        whoInterestedButton.layer.cornerRadius = 5
        view.addSubview(whoInterestedButton)
        
        let RSVPButton = UIButton(frame: CGRect(x: view.frame.width * 0.45, y: view.frame.height * 0.4 + 130, width: view.frame.width * 0.1, height: 30))
        RSVPButton.setTitle("RSVP", for: UIControlState.normal)
        RSVPButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        RSVPButton.titleLabel!.adjustsFontSizeToFitWidth = true
        RSVPButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        RSVPButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        RSVPButton.backgroundColor = themeColor
        RSVPButton.addTarget(self, action: #selector(DetailViewController.modifyPeople), for: UIControlEvents.touchUpInside)
        RSVPButton.layer.cornerRadius = 5
        view.addSubview(RSVPButton)
        
    }
    
    func backPressed(){
        performSegue(withIdentifier: "backToFeed", sender: self)
    }
    
    func showPeople(_ sender: UIButton!) {
        // Modal View of people who are interested.
    }
    
    func modifyPeople(_ sender: UIButton!) {
        // Add the current user to the list of people who are interested if the user is currently not interested, or remove the current user from the list of people who are interested if the user is currently interested.
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
