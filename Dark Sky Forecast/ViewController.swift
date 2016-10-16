//
//  ViewController.swift
//  Dark Sky Forecast
//
//  Created by Eliot Han on 10/14/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation
import AddressBookUI

class ViewController: UIViewController {
    
    lazy var locationManager: CLLocationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    var weatherData: [String: String]?
    var backgroundView : UIImageView!
    var locationLabel : UILabel!
    var summaryLabel: UILabel!
    var temperatureLabel: UILabel!
    var rainLabel : UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestLocation()
    }
    
    func setupUI(){
        backgroundView = UIImageView(frame: view.frame)
        backgroundView.image = #imageLiteral(resourceName: "background")
        view.addSubview(backgroundView)
        
//        etCurrentForecast({ (forecast) in
//            self.weatherData = forecast
//            self.setupUI()
//        })

        reverseGeocoding(latitude: latitude!, longitude: longitude!)
        
     
        
        
        temperatureLabel = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.2, width: view.frame.width * 0.9, height: view.frame.height * 0.05))
        temperatureLabel.text = "Current temperature: \(weatherData!["temperature"]!)"
        setUILabel(label: temperatureLabel)
        setLabelFontSize(label: temperatureLabel, size: 25)
        view.addSubview(temperatureLabel)
        
        summaryLabel = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: temperatureLabel.frame.maxY + 5, width: view.frame.width * 0.9, height: view.frame.height * 0.05))
        summaryLabel.text = weatherData?["summary"]
        setLabelFontSize(label: summaryLabel, size: 30)
        setUILabel(label: summaryLabel)
        view.addSubview(summaryLabel)
        rainLabel = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: summaryLabel.frame.maxY + 5, width: view.frame.width * 0.9, height: view.frame.height * 0.1))
        setUILabel(label: rainLabel)
        if let min = weatherData?["willStartRainingAt"] {
            let unixTime = weatherData?["willStartRainingAt"]!
            let time = NSDate(timeIntervalSince1970: Double(unixTime!)!)
            rainLabel.text = "It will start raining at: \(time)))"
            setLabelFontSize(label: rainLabel, size: 40)
        } else {
            rainLabel.text = "No rain!"
            setLabelFontSize(label: rainLabel, size: 40)
        }
        view.addSubview(rainLabel)
        
        
        
        
        
    }
    
    func setUILabel(label : UILabel) {
        label.textColor = UIColor.white
        label.textAlignment = .center
    }
    
    func setLabelFontSize(label : UILabel, size : CGFloat) {
        label.font = UIFont(name: label.font.fontName, size: size)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        API(latitude: latitude!, longitude: longitude!).getCurrentForecast({ (forecast) in
            self.weatherData = forecast
            self.setupUI()
        })

    }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latitude = (locationManager.location?.coordinate.latitude)!
        longitude = (locationManager.location?.coordinate.longitude)!
        getData()
        
    }
}

extension ViewController{
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print(error)
                
            }
            else if (placemarks?.count)! > 0 {
                let pm = placemarks![0]
                let address = ABCreateStringWithAddressDictionary(pm.addressDictionary!, false)
                print(address)
                self.createLocationLabels(address: address)
               
                
            }
        })
        
        
    }
    
    func createLocationLabels(address: String){
        
        let newlineChars = NSCharacterSet.newlines
        let lineArray = address.components(separatedBy: newlineChars).filter{!$0.isEmpty}
        
        self.locationLabel = UILabel(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height * 0.15))
        self.locationLabel.text = lineArray[1]  //get city name
        self.setUILabel(label: self.locationLabel)
        self.setLabelFontSize(label: self.locationLabel, size: 30)
        self.view.addSubview(self.locationLabel)

    }
    
    
}


