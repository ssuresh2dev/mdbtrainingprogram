//
//  WeatherParser.swift
//  Dark Sky Forecast
//
//  Created by Jessica Chen on 10/15/16.
//  Copyright © 2016 Jessica Chen. All rights reserved.
//

import Foundation

class WeatherParser {
    
    static func getWeatherDict(request: String) -> [String: String]{
        var weatherDict: [String: String] = [:]
        if let path = Bundle.main.path(forResource: request, ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path) {
                do {
                    let weatherInfo = try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) as! [String:AnyObject]
                    let currentlyInfo = weatherInfo["currently"] as? [String: AnyObject]
                    let currTemp = currentlyInfo?["temperature"] as! String
                } catch {
                    NSLog("Could not retrieve weather data from DarkSky API")
                }
                
            }
        }
        return weatherDict
    }
    
    
}
