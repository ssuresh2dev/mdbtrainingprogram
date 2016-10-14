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
    var testPeopleRSVP: String! = "TestNumber"
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
        backButton = UIButton(frame: CGRect(x: view.frame.width/10, y: view.frame.height/10, width: view.frame.width/5, height: view.frame.height/8 ))
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    
        self.navigationItem.title = titleToBeSet
        view.backgroundColor = themeColor
        
        let eventImageView = UIImageView(frame: CGRect(x: (view.frame.width - view.frame.height * 0.3)/2, y: 20, width: view.frame.height * 0.3, height: view.frame.height * 0.3))
        eventImageView.image = UIImage(named: "IMG_2469")
        eventImageView.clipsToBounds = true
        view.addSubview(eventImageView)
        
        let whoPostedLabel = UILabel(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.3 + 30, width: view.frame.width * 0.6, height: 30))
        whoPostedLabel.text = "Created by: \(whoPostedName)"
        whoPostedLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 16.0)
        whoPostedLabel.textAlignment = NSTextAlignment.center
        view.addSubview(whoPostedLabel)
        
        let whoInterestedButton = UIButton(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height + 70, width: view.frame.width * 0.6, height: 30))
        whoInterestedButton.setTitle("\(testPeopleRSVP) people interested", for: UIControlState.normal)
        whoInterestedButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        whoInterestedButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        whoInterestedButton.addTarget(self, action: #selector(DetailViewController.showPeople), for: UIControlEvents.touchUpInside)
        view.addSubview(whoInterestedButton)
        
    }
    func backPressed(){
        performSegue(withIdentifier: "backToFeed", sender: self)
    }
    
    func showPeople(_ sender: UIButton!) {
        // Modal View of people who are interested.
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
