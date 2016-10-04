//
//  LoginViewController.swift
//  MDBSocials
//
//  Created by Eliot Han on 10/4/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    var titleLabel: UILabel!
    var emailField: UITextField!
    var passwordField: UITextField!
    var createAccountButton: UIButton!
    
    
    var username: String?
    var password: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
       FIRAuth.auth()?.addStateDidChangeListener{ auth, user in
            if let user = user {
                // User is signed in.
            } else {
                // No user is signed in.
            }
        }
    }

    func setupUI(){
        titleLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height/2 - 80, width: view.frame.width, height: 100))
        titleLabel.font = UIFont(name: "Avenir-Light", size: 30.0)
        titleLabel.isUserInteractionEnabled = false
        titleLabel.text = "Mobile Developers of Berkeley"
        view.addSubview(titleLabel)
        
        emailField = UITextField(frame: CGRect(x: view.frame.width/2 - 30, y: view.frame.height/2, width: view.frame.width, height: 50))
        emailField.placeholder = "Username"
        emailField.keyboardType = UIKeyboardType.emailAddress
        emailField.font = UIFont(name: "Avenir-Light", size: 13.0)
        view.addSubview(emailField)
        
        passwordField = UITextField(frame: CGRect(x: view.frame.width/2 - 30, y: view.frame.height/2 + 30, width: view.frame.width, height: 50))
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.font = UIFont(name: "Avenir-Light", size: 13.0)
        view.addSubview(passwordField)
        
        
        createAccountButton = UIButton(frame: CGRect(x: view.frame.width/2, y: passwordField.frame.maxY + 25, width: 100, height: 50))
        createAccountButton.setTitle("Register for a new account", for: .normal)
        view.addSubview(createAccountButton)
        
        
    }
    
    

}
