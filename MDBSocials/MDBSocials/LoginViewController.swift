
//
//  ViewController.swift
//  MDBSocials
//
//  Created by Mohit Katyal on 10/2/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //All Variables
    var loginBackground: UIImageView!
    var MDBLabel: UILabel!
    var userLabel: UILabel!
    var passLabel: UILabel!
    var logInButton: UIButton!
    var createButton: UIButton!
    var userText: UITextField!
    var passText: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Creates Background
        loginBackground = UIImageView(frame: view.frame)
        loginBackground.image = #imageLiteral(resourceName: "background")
        view.addSubview(loginBackground)
        
        
        //Creates Title
        MDBLabel = UILabel(frame: CGRect(x: view.frame.width*0.1, y: view.frame.height*0.1, width: view.frame.width*0.8, height: view.frame.height*0.15))
        MDBLabel.text = "MDB Socials"
        MDBLabel.textColor = UIColor.white
        MDBLabel.textAlignment = .center
        MDBLabel.font = UIFont(name: MDBLabel.font.fontName, size: 45)
        MDBLabel.backgroundColor = UIColor(red: 41/255, green: 70/255, blue: 164/255, alpha: 0.9)
        MDBLabel.layer.masksToBounds = true
        MDBLabel.layer.cornerRadius = 10
        view.addSubview(MDBLabel)
        
        
        //Creates UserName
        userLabel = UILabel(frame: CGRect(x: view.frame.width*0.15, y: MDBLabel.frame.height+view.frame.height*0.2, width: view.frame.width*0.4, height: view.frame.height*0.1))
        userLabel.text = "Username:"
        userLabel.textColor = UIColor.white
        userLabel.font = UIFont(name: MDBLabel.font.fontName, size: 40)
        userLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        view.addSubview(userLabel)
        
        
        //Creates Password
        passLabel = UILabel(frame: CGRect(x: view.frame.width*0.15, y: MDBLabel.frame.height+view.frame.height*0.3, width: view.frame.width*0.4, height: view.frame.height*0.1))
        passLabel.text = "Password:"
        passLabel.textColor = UIColor.white
        passLabel.font = UIFont(name: MDBLabel.font.fontName, size: 40)
        passLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        view.addSubview(passLabel)
        
        //Creates Username Text Field
        userText = UITextField(frame: CGRect(x: view.frame.width*0.46, y: MDBLabel.frame.height+view.frame.height*0.23, width: view.frame.width*0.4, height: view.frame.height*0.04))
        userText.backgroundColor = UIColor.white
        userText.layer.masksToBounds = true
        userText.layer.cornerRadius = 10
        view.addSubview(userText)
        
        //Creates Password Text Field
        passText = UITextField(frame: CGRect(x: view.frame.width*0.46, y: MDBLabel.frame.height+view.frame.height*0.33, width: view.frame.width*0.4, height: view.frame.height*0.04))
        passText.backgroundColor = UIColor.white
        passText.layer.masksToBounds = true
        passText.layer.cornerRadius = 10
        view.addSubview(passText)
        
        //Creates Login Button
        logInButton = UIButton(frame: CGRect(x: view.frame.width*0.2, y: view.frame.height*0.6, width: view.frame.width*0.6, height: view.frame.height*0.1))
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(UIColor.white, for: .normal)
        logInButton.backgroundColor = UIColor(red: 255/255, green: 191/255, blue: 0/255, alpha: 0.9)
        logInButton.layer.masksToBounds = true
        logInButton.layer.cornerRadius = 10
        view.addSubview(logInButton)
        //Sets button to the function logInClicked
        logInButton.addTarget(self, action: #selector(logInClicked), for: UIControlEvents.touchUpInside)
        
        //Creates CreateAnAccount Button
        createButton = UIButton(frame: CGRect(x: view.frame.width*0.25, y: view.frame.height*0.7, width: view.frame.width*0.5, height: view.frame.height*0.1))
        createButton.setTitle("Create An Account", for: .normal)
        createButton.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(createButton)
        //Sets button to function createClicked
        createButton.addTarget(self, action:#selector(createClicked), for: UIControlEvents.touchUpInside)
        
         //Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //When Log In Button is clicked, the FeedViewController opens
    func logInClicked(sender: UIButton)
    {
        performSegue(withIdentifier: "loginToFeed", sender: self)
    }
    
    //When Create An Account is clicked, the SignUpViewControlelr opens
    func createClicked(sender:UIButton)
    {
        performSegue(withIdentifier: "toSignUp", sender:self)
    }
    

}

