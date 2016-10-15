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
class ViewController: UIViewController {
    
    lazy var locationManager: CLLocationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    var weatherData: [String: AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestLocation()
        
        
      

    }
    func setupUI(){
        let temperatureLabel: UILabel = UILabel(frame: CGRect(x: view.frame.width/2, y: view.frame.height/2, width: 70, height: 50))
        temperatureLabel.text = weatherData?["temperature"] as! String ?? "yo"
        view.addSubview(temperatureLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        print("1919")
        API(latitude: latitude!, longitude: longitude!).getCurrentForecast({ (forecast) in
            self.weatherData = forecast
            print(self.weatherData)
            self.setupUI()
            
        })
        //print(weatherData)

    }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("hi")
        latitude = (locationManager.location?.coordinate.latitude)!
        longitude = (locationManager.location?.coordinate.longitude)!
        print(latitude!,longitude!)
        getData()
        
    }
}

