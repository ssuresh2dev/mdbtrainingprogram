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

struct Global {
    static var weatherData: [Weather] = []

}
class API {
    var time: String!
    var temp: Double!
    var rainStatus: String!
    var rainMinute: Int! = 0
    var desc: String!
    
    typealias JSONStandard = [String : AnyObject]
    
    func getWeatherData() {
        let latitude = 37.866602
        let longitude = -122.257757
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
            
            print(addWeather)
            print(Global.weatherData)
            Global.weatherData.append(addWeather)
            print(Global.weatherData)
            
//            print(desc)
//            print(temp)
//            print(time)
//            print(rainStatus)
        } catch {
            print(error)
        }
    }
}
