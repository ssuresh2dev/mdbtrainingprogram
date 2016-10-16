//
//  ViewController.swift
//  Weather
//
//  Created by Rochelle on 10/15/16.
//  Copyright © 2016 Rochelle. All rights reserved.
//

import UIKit
import CoreLocation

var latitude: CLLocationDegrees!
var longitude: CLLocationDegrees!

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        willRain()
        API().getWeatherData()
        setUI()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let userLocation = locations[0] as! CLLocation
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
    }
    
    func setUI() {
        
        view.backgroundColor = .black
        
        let locationLabel = UILabel(frame: CGRect(x: view.frame.width * 0.2, y: 40, width: view.frame.width * 0.6, height: 40))
        locationLabel.text = "San Francisco"
        print(Global.weatherData)
        //locationLabel.text = Global.weatherData[0].timezone
        locationLabel.font = UIFont(name: "AvenirNext-Regular", size: 36.0)
        locationLabel.textColor = UIColor(colorLiteralRed: 0, green: 204/255, blue: 204/255, alpha: 1)
        locationLabel.textAlignment = NSTextAlignment.center
        locationLabel.numberOfLines = 1
        locationLabel.adjustsFontSizeToFitWidth = true
        locationLabel.clipsToBounds = true
        view.addSubview(locationLabel)
        
        let container = UIImageView(frame: CGRect(x: view.frame.width * 0.15, y: 110, width: view.frame.width * 0.7, height: view.frame.height * 0.4))
        container.image = #imageLiteral(resourceName: "clearBox")
        container.contentMode = .scaleAspectFill
        view.addSubview(container)
        
        let iconImageView = UIImageView(frame: CGRect(x: view.frame.width * 0.15, y: 135, width: view.frame.width * 0.7, height: view.frame.height * 0.2 - 50))
        iconImageView.image = #imageLiteral(resourceName: "LocationPin")
        iconImageView.contentMode = .scaleAspectFit
        view.addSubview(iconImageView)
        
        let tempLabel = UILabel(frame: CGRect(x: view.frame.width * 0.35, y: view.frame.height * 0.2 + 115, width: view.frame.width * 0.3, height: view.frame.height * 0.13))
        tempLabel.text = "62 F"
        //tempLabel.text = String(Global.weatherData[0].temperature)
        tempLabel.font = UIFont(name: "AvenirNext-Regular", size: 75.0)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.textColor = .white
        tempLabel.numberOfLines = 1
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.clipsToBounds = true
        view.addSubview(tempLabel)
        
        let statusLabel = UILabel(frame: CGRect(x: view.frame.width * 0.4, y: view.frame.height * 0.33 + 120, width: view.frame.width * 0.2, height: 30))
        statusLabel.text = "Overcast"
        //statusLabel.text = Global.weatherData[0].willItRain
        statusLabel.font = UIFont(name: "AvenirNext-Regular", size: 34.0)
        statusLabel.textAlignment = NSTextAlignment.center
        statusLabel.textColor = .white
        statusLabel.numberOfLines = 1
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.clipsToBounds = true
        view.addSubview(statusLabel)
        
        let descTitleLabel = UILabel(frame: CGRect(x: view.frame.width * 0.125, y: view.frame.height * 0.4 + 140, width: view.frame.width * 0.75, height: 30))
        descTitleLabel.text = "Description:"
        descTitleLabel.font = UIFont(name: "AvenirNext-Regular", size: 24.0)
        descTitleLabel.textAlignment = NSTextAlignment.left
        descTitleLabel.textColor = UIColor(colorLiteralRed: 0, green: 204/255, blue: 204/255, alpha: 1)
        descTitleLabel.numberOfLines = 1
        descTitleLabel.adjustsFontSizeToFitWidth = true
        descTitleLabel.clipsToBounds = true
        view.addSubview(descTitleLabel)
        
        let descTextLabel = UILabel(frame: CGRect(x: view.frame.width * 0.125, y: view.frame.height * 0.4 + 185, width: view.frame.width * 0.75, height: 60))
       descTextLabel.text = "Light rain today through Monday, with temperatures bottoming out at 64°F on Wednesday."
        //descTextLabel.text = Global.weatherData[0].description
        descTextLabel.textAlignment = NSTextAlignment.justified
        descTextLabel.font = UIFont(name: "AvenirNext-Regular", size: 14.0)
        descTextLabel.numberOfLines = 5
        descTextLabel.adjustsFontSizeToFitWidth = true
        descTextLabel.textColor = .white
        view.addSubview(descTextLabel)
        
    }
    
    func willRain() {
        
        let timeTitleLabel = UILabel(frame: CGRect(x: view.frame.width * 0.125, y: view.frame.height * 0.4 + 260, width: view.frame.width * 0.75, height: 30))
        timeTitleLabel.text = "Time of rain:"
        timeTitleLabel.textAlignment = NSTextAlignment.left
        timeTitleLabel.font = UIFont(name: "AvenirNext-Regular", size: 24.0)
        timeTitleLabel.textColor = UIColor(colorLiteralRed: 0, green: 204/255, blue: 204/255, alpha: 1)
        timeTitleLabel.numberOfLines = 1
        timeTitleLabel.adjustsFontSizeToFitWidth = true
        timeTitleLabel.clipsToBounds = true
        
        let timeTextLabel = UILabel(frame: CGRect(x: view.frame.width * 0.125, y: view.frame.height * 0.4 + 260, width: view.frame.width * 0.75, height: 30))
        timeTextLabel.text = "10:52 PM"
        timeTextLabel.adjustsFontSizeToFitWidth = true
        timeTextLabel.textAlignment = NSTextAlignment.right
        timeTextLabel.font = UIFont(name: "AvenirNext-Regular", size: 24.0)
        timeTextLabel.textColor = .white
        timeTextLabel.numberOfLines = 1
        timeTextLabel.clipsToBounds = true
        
        // If it will rain, add the timeTitleLabel and timeTextLabel subviews to the current View:
        // view.addSubview(timeTitleLabel)
        // view.addSubview(timeTextLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

