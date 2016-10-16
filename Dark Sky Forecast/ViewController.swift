//
//  ViewController.swift
//  Dark Sky Forecast
//
//  Created by Jessica Chen on 10/14/16.
//  Copyright © 2016 Jessica Chen. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation
import Alamofire
import AddressBookUI

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let APIkey = "a8506a319a1d688083eceaab2313af10"
    lazy var locationManager: CLLocationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    var temperature: Double?
    var willItRain: Bool?
    var minRain: Int?
    var summary: String = ""
    var address: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
//        latitude = locationManager.location?.coordinate.latitude
//        longitude = locationManager.location?.coordinate.longitude
        latitude = 37.8755
        longitude = -122.2588
        
        
        print("lat:\(latitude)")
        print("long:\(longitude)")
        reverseGeocoding(latitude: latitude!, longitude: longitude!)
        getWeather()
    }
    
    func getWeather(){
        Alamofire.request("https://api.darksky.net/forecast/\(APIkey)/\(latitude!),\(longitude!)").responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            if let JSON = response.result.value as? [String: AnyObject]{
                
                let currentInfo = JSON["currently"] as? [String: AnyObject]
                let minutelyInfo = JSON["minutely"] as? [String: AnyObject]
                let hourlyInfo = JSON["hourly"] as? [String: AnyObject]
                let minutelyData = minutelyInfo?["data"] as? [[String: AnyObject]]
                
                self.temperature = currentInfo?["temperature"] as? Double
                self.willItRain = (minutelyInfo?["icon"] as! String == "rain")
                self.summary = hourlyInfo?["summary"] as! String!
                print(self.willItRain)
                print(self.temperature)
                
                if(self.willItRain)!{
                    for d in minutelyData!{
                        if(d["precipProbability"] as! Double == 1.0){
                            print(d)
                            print("it worked")
                            let hexTime: AnyObject = d["time"] as! AnyObject
                            print(hexTime)
                            let date = NSDate(timeIntervalSince1970: hexTime as! TimeInterval)
                            print(date)
                            let calendar = NSCalendar.current
                            self.minRain = calendar.component(.minute, from: date as Date)
                            print("minute: \(self.minRain)")
                            break
                        }
                    }
                }
                print(self.minRain)
            }
        }
    }

    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        print(coord.latitude)
        print(coord.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ViewController {
        func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
            let location = CLLocation(latitude: latitude, longitude: longitude)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                if error != nil {
                    print(error)
                    return
                }
                else if (placemarks?.count)! > 0 {
                    let pm = placemarks![0]
                    let address = ABCreateStringWithAddressDictionary(pm.addressDictionary!, false)
                    print("\n\(address)")
                }
                
            })
        }
    }

