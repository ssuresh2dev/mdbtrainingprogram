////
////  URLTester.swift
////  Pokedex
////
////  Created by Jessica Chen on 9/30/16.
////  Copyright © 2016 trainingprogram. All rights reserved.
//
//
//class URLTester: NSURLConnection {
//    
//    func fileExists(url : URL!) -> Bool {
//        
//        let req = NSMutableURLRequest(URL: url)
//        req.HTTPMethod = "HEAD"
//        req.timeoutInterval = 1.0 // Adjust to your needs
//        
//        var response : NSURLResponse?
//        NSURLConnection.sendSynchronousRequest(req, returningResponse: &response, error: nil)
//        
//        return ((response as? NSHTTPURLResponse)?.statusCode ?? -1) == 200
//    }}
