//
//  API.swift
//  Dark Sky Forecast
//
//  Created by Eliot Han on 10/15/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import CoreLocation

class API {
    var latitude: Double
    var longitude: Double
    static let key = "36224cc08d61238c45e6b46ff48cc651"
    
    init(latitude: Double, longitude: Double){
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getCurrentForecast(_ completion: @escaping (_ forecast: [String: AnyObject]) -> Void){
        
        let url = "https://api.darksky.net/forecast/\(API.key)/\(latitude),\(longitude)"

        Alamofire.request(url).responseJSON { response in
            
            if let json = response.result.value as? [String: AnyObject] {
                var forecast: [String: AnyObject] = [:]
                let currently = json["currently"] as! [String: AnyObject]
                
                let temperature = currently["temperature"]
                forecast["temperature"] = temperature as AnyObject?
            
                
                let summary = currently["summary"]
                forecast["summary"] = summary as AnyObject?
                
                
                let hourly = json["hourly"] as! [String: AnyObject]
                
                let hourlySummary = hourly["icon"] as AnyObject?
                forecast["hourlySummary"] = hourlySummary
                
                let minutely = json["minutely"] as! [String: AnyObject]
                let minutelyData = minutely["data"] as! [AnyObject]
                var whenItRains : [Int] = []
                
                for currMinute in minutelyData {
                    if (currMinute["precipIntensity"] as! Int) != 0 {
                        whenItRains.append(currMinute["time"] as! Int)
                    }
                }
                forecast["willRainAt"] = whenItRains as AnyObject?
                
                
                
                completion(forecast)
            }
            
        }

    
    }
}
