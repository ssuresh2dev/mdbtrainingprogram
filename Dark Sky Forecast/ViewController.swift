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
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    lazy var locationManager: CLLocationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    var weatherData: [String: AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
            
            latitude = (locationManager.location?.coordinate.latitude)!
            longitude = (locationManager.location?.coordinate.longitude)!
            
        }
        
        API(latitude: latitude!, longitude: longitude!).getCurrentForecast{
            (forecast) in
            self.weatherData = forecast
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

