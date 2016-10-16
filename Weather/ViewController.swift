//
//  ViewController.swift
//  Weather
//
//  Created by Rochelle on 10/15/16.
//  Copyright © 2016 Rochelle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUI() {
        
        view.backgroundColor = .black
        
        let locationLabel = UILabel(frame: CGRect(x: view.frame.width * 0.2, y: 40, width: view.frame.width * 0.6, height: 40))
        locationLabel.text = "Location"
        locationLabel.font = UIFont(name: "AvenirNext-Regular", size: 36.0)
        locationLabel.textColor = UIColor(colorLiteralRed: 0, green: 204/255, blue: 204/255, alpha: 1)
        locationLabel.textAlignment = NSTextAlignment.center
        locationLabel.numberOfLines = 1
        locationLabel.adjustsFontSizeToFitWidth = true
        locationLabel.clipsToBounds = true
        view.addSubview(locationLabel)
        
        let container = UIImageView(frame: CGRect(x: view.frame.width * 0.15, y: 110, width: view.frame.width * 0.7, height: view.frame.height * 0.4))
        container.image = #imageLiteral(resourceName: "clearBox")
        view.addSubview(container)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

