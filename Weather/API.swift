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
    var weatherData: [Weather] = []
    var time: String!
    var temp: Double!
    var rainStatus: String!
    var rainMinute: String!
    var desc: String!
    
    typealias JSONStandard = [String : AnyObject]
    
//    func getLocation() {
//        var locManager = CLLocationManager()
//        locManager.requestWhenInUseAuthorization()
//        
//        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
//            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
//            latitude = (locManager.location?.coordinate.latitude)!
//            longitude = (locManager.location?.coordinate.longitude)!
//            
//        }
//    }
    
    func getWeatherData() {
        //getLocation()
        latitude = 37.866602
        longitude = -122.257757
        let urlString = "https://api.darksky.net/forecast/295a15b47e1a3e4649c5f43bfa41a17e/\(latitude),\(longitude)"
        Alamofire.request(urlString).responseJSON { response in
            self.parseData(JSONData: response.data!)
        }
        
    }
    
    func parseData(JSONData : Data) {
        do {
            var readJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            
            let des = readJSON["alerts"]
            //desc = des?["description"] as! String!
//            if let zone = readJSON["timezone"] as? JSONStandard {
//                time = zone as! String
//            }
//            if let currTemp = readJSON["currently"]?["temperature"] as? JSONStandard {
//                temp = currTemp as! Double
//            }
            //print(readJSON)
            print(des)
            //print(desc)
//            print(time)
//            print(temp)
        } catch {
            print(error)
        }
    }
}
