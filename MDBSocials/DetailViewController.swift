//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Rochelle on 10/12/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var eventImage: UIImageView!
    var modalView: UIButton!
    var numInterested: UILabel!
    var addToRSVP: UIButton!
    var titleOfEvent: UILabel!
    var paragraphText: UILabel!
    // hello worlddddddd hopefully this works pleaseseeseses

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI(){
        eventImage = UIImageView(frame: CGRect(x: 42, y: 83, width: 292, height: 237))
        eventImage.contentMode = UIViewContentMode.scaleAspectFill
        view.addSubview(eventImage)
        
        modalView = UIButton(frame: CGRect(x: 58, y: 534, width: 265, height: 33))
        modalView.setImage(#imageLiteral(resourceName: "PeopleInterested"), for: .normal)
        view.addSubview(modalView)
        
        numInterested = UILabel(frame: CGRect(x: 118.5, y: 540, width: 265, height: 21))
        numInterested.font = UIFont(name: "AvenirNext-Regular", size: 15.0)
        numInterested.textColor = UIColor.white
        view.addSubview(numInterested)
        
        addToRSVP = UIButton(frame: CGRect(x: 59, y: 585, width: 264, height: 33))
        addToRSVP.setImage(#imageLiteral(resourceName: "NotYetRsvp"), for: .normal)
        addToRSVP.addTarget(self, action:#selector(pressedCountMeIn), for: .touchUpInside)
        view.addSubview(addToRSVP)
        
        titleOfEvent = UILabel(frame: CGRect(x: 42, y: 326, width: 292, height: 29))
        titleOfEvent.font = UIFont(name: "Bebas", size: 22)
        titleOfEvent.textAlignment = NSTextAlignment.center
        view.addSubview(titleOfEvent)
        
        paragraphText = UILabel(frame: CGRect(x: 42, y: 361, width: 292, height: 144))
        paragraphText.textAlignment = NSTextAlignment.center
        view.addSubview(paragraphText)
    }
    
    func pressedCountMeIn() {
        addToRSVP.setImage(#imageLiteral(resourceName: "Rsvped"), for: .normal)
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
