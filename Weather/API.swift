//
//  API.swift
//  Weather
//
//  Created by Rochelle on 10/15/16.
//  Copyright © 2016 Rochelle. All rights reserved.
//

import CoreLocation
import Foundation
import Alamofire

class API {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    func getLocation() {
        var locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            latitude = (locManager.location?.coordinate.latitude)!
            longitude = (locManager.location?.coordinate.longitude)!
            
        }
    }
    
    func getWeatherData() {
        let url = "https://api.darksky.net/forecast/295a15b47e1a3e4649c5f43bfa41a17e/\(latitude),\(longitude)"

        
        if let url = NSURL(string: url) {
            if let data = try? Data(contentsOf: url as URL) {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                    
                    //Store response in NSDictionary for easy access
                    let dict = parsedData as? NSDictionary
                    
                    let currentConditions = "\(dict!["currently"]!)"
                    
                    //This produces an error, Type 'Any' has no subscript members
//                    let currentTemperatureF = ("\(dict!["currently"]!["temperature"]!!)" as NSString).doubleValue
                    
                    //Display all current conditions from API
                    print(currentConditions)
                    
                    //Output the current temperature in Fahrenheit
                    //print(currentTemperatureF)
                    
                }
                    //else throw an error detailing what went wrong
                catch let error as NSError {
                    print("Details of JSON parsing error:\n \(error)")
                }
            }
        }

    }
}
