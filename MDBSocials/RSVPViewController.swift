//
//  RSVPViewController.swift
//  MDBSocials
//
//  Created by Shubham Goenka on 19/10/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class RSVPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        
        view.backgroundColor = UIColor.white
        
        let backButton = UIButton(frame: CGRect(x: view.frame.width * 0, y: 0, width: view.frame.width * 0.2, height: view.frame.height * 0.1 ))
        backButton.setTitle("Back", for: .normal)
        backButton.backgroundColor = themeColor
        backButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        backButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        backButton.clipsToBounds = true
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        let titleLabel = UILabel(frame: CGRect(x: view.frame.width * 0.2, y: 0, width: view.frame.width * 0.6, height: view.frame.height * 0.1))
        titleLabel.text = "People Interested"
        titleLabel.textColor = UIColor.white
        titleLabel.backgroundColor = themeColor
        titleLabel.font = UIFont(name: "Avenir-Black", size: 24.0)
        titleLabel.clipsToBounds = true
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(titleLabel)
        
        let fillerLabel = UILabel(frame: CGRect(x: view.frame.width * 0.8 - 1, y: 0, width: view.frame.width * 0.2 + 1, height: view.frame.height * 0.1))
        fillerLabel.backgroundColor = themeColor
        fillerLabel.clipsToBounds = true
        view.addSubview(fillerLabel)
    }
    
    func backPressed() {
        dismiss(animated: true, completion: nil)
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
