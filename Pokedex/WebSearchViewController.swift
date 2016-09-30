//
//  WebSearchViewController.swift
//  Pokedex
//
//  Created by Vidya Ravikumar on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class WebSearchViewController: UIViewController {

    var poke : Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webV:UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        webV.loadRequest(NSURLRequest(url: NSURL(string: "https://google.com/search?q=" + poke.name!) as! URL) as URLRequest)
        self.view.addSubview(webV)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
