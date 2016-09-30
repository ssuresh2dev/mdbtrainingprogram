//
//  WebViewController.swift
//  Pokedex
//
//  Created by Kevin Jiang on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    let webV:UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width,
                                                 height: UIScreen.main.bounds.height))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webV.delegate = self;
        webV.layer.borderColor = UIColor.black.cgColor
        webV.layer.borderWidth = 0
        self.view.addSubview(webV)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension WebViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Error")
    }
}
