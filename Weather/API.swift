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
    var rainMinute: Int!
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
            var readJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! NSDictionary
            print(readJSON)
            desc = (((readJSON["alerts"] as! NSArray)[0] as! NSDictionary)["description"] as! String)
            temp = ((readJSON["currently"] as! NSDictionary)["temperature"] as! Double)
            time = readJSON["timezone"] as! String
            rainStatus = ((readJSON["currently"] as! NSDictionary)["summary"] as! String)
            
            if (rainStatus == "Rain") {
                rainMinute = ((((readJSON["minutely"] as! NSDictionary)["data"] as! NSArray)[0] as! NSDictionary)[1] as! Int!)
            }
            
            let addWeather = Weather(timezone: time, temperature: temp, willItRain: rainStatus, minuteRain: rainMinute, description: desc)
            
            weatherData.append(addWeather)
            
            print(desc)
            print(temp)
            print(time)
            print(rainStatus)
        } catch {
            print(error)
        }
    }
}
