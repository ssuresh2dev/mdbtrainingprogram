//
//  imageLoadingWithCache.swift
//  Pokedex
//
//  Created by Jessica Chen on 9/29/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//
import UIKit

class ImageLoadingWithCache {
    
    var imageCache = [String:UIImage]()
    
    func getImage(url: String, imageView: UIImageView, defaultImage: String) {
        if let img = imageCache[url] {
            imageView.image = img
        } else {
            let request: URLRequest = URLRequest(url: URL(string: url)!)
            let mainQueue = OperationQueue.main
            
            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                if error == nil {
                    let image = UIImage(data: data!)
                    self.imageCache[url] = image
                    
                    DispatchQueue.main.asynchronously(execute: {
                        imageView.image = image
                    })
                }
                else {
                    imageView.image = UIImage(named: defaultImage)
                }
            })
        }
    }
}
