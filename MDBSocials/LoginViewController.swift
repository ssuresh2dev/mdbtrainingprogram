//
//  LoginViewController.swift
//  MDBSocials
//
//  Created by Eliot Han on 10/4/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    var titleLabel: UILabel!
    var emailField: UITextField!
    var passwordField: UITextField!
    var createAccountButton: UIButton!
    var loginButton: UIButton!
    
    
    var username: String?
    var password: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
       FIRAuth.auth()?.addStateDidChangeListener{ auth, user in
            if user != nil {
                // User is signed in.
               
               
                let fvc = self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
                let navigationController = UINavigationController(rootViewController: fvc)
                self.present(navigationController, animated: true, completion: nil)

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
        
        emailField = UITextField(frame: CGRect(x: view.frame.width/2 - 25, y: view.frame.height/2, width: view.frame.width, height: 50))
        emailField.placeholder = "Enter your email"
        emailField.keyboardType = UIKeyboardType.emailAddress
        emailField.font = UIFont(name: "Avenir-Light", size: 13.0)
        view.addSubview(emailField)
        
        passwordField = UITextField(frame: CGRect(x: view.frame.width/2 - 25, y: view.frame.height/2 + 30, width: view.frame.width, height: 50))
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.font = UIFont(name: "Avenir-Light", size: 13.0)
        view.addSubview(passwordField)
        
        createAccountButton = UIButton(frame: CGRect(x: 20, y: passwordField.frame.maxY + 25, width: view.frame.width - 20, height: 50))
        createAccountButton.setTitle("Register for a new account", for: .normal)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonPressed(_:)), for: .touchUpInside)
        createAccountButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        createAccountButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        view.addSubview(createAccountButton)
        
        
        loginButton = UIButton(frame: CGRect(x: 20, y: createAccountButton.frame.maxY + 25, width: view.frame.width - 20, height: 50))
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action:#selector(loginButtonPressed(_:)), for: .touchUpInside)
        loginButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        loginButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        view.addSubview(loginButton)
        
        
    }
    func createAccountButtonPressed(_ sender: UIButton!){
        //segue to create account screen
        self.performSegue(withIdentifier: "segueToSignupVC", sender: self)
        
    }
    
    func loginButtonPressed(_ _sender: UIButton!){
        guard let email = emailField.text, let password = passwordField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error)
                return
            } else {
                //self.signedIn(user)
                print("signed in!")
                self.performSegue(withIdentifier: "segueToFeedVC", sender: self)
            }
        })
    }
    

}
