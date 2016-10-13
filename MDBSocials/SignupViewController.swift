//
//  SignupViewController.swift
//  MDBSocials
//
//  Created by Eliot Han on 10/4/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupViewController: UIViewController {
    var firstName: UILabel!
    var lastName: UILabel!
    
    var firstNameField: UITextField!
    var lastNameField: UITextField!
    
    var usernameDisplay: UILabel!
    var usernameField: UITextField!
    
    var passwordDisplay: UILabel!
    var passwordField: UITextField!
    
    var emailDisplay: UILabel!
    var emailField: UITextField!
    
    var registerBox: UIButton!
    
    var password: String = ""
    var username: String = ""
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setUpUI() {
        firstName = UILabel(frame: CGRect(x: 48, y: 162, width: 200, height: 19))
        firstName.text = "First Name"
        view.addSubview(firstName)
        lastName = UILabel(frame: CGRect(x: 205, y: 163, width: 200, height: 19))
        lastName.text = "Last Name"
        view.addSubview(lastName)
        
        firstNameField = UITextField(frame: CGRect(x: 47, y: 181, width: 122, height: 33))
        firstNameField.placeholder = "lemme see"
        view.addSubview(firstNameField)
        lastNameField = UITextField(frame: CGRect(x: 204, y: 181, width: 122, height: 33))
        lastNameField.placeholder = "YAS"
        view.addSubview(lastNameField)
        
        usernameDisplay = UILabel(frame: CGRect(x: 45.5, y: 227, width: 200, height: 19))
        usernameDisplay.text = "Username"
        view.addSubview(usernameDisplay)
        usernameField = UITextField(frame: CGRect(x: 46, y: 246, width: 273, height: 33))
        usernameField.placeholder = "OK"
        view.addSubview(usernameField)
        
        passwordDisplay = UILabel(frame: CGRect(x: 46, y: 299, width: 200, height: 19))
        passwordDisplay.text = "Password"
        view.addSubview(passwordDisplay)
        passwordField = UITextField(frame: CGRect(x: 46, y: 318, width: 279, height: 33))
        passwordField.placeholder = "PASS"
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)
        
        emailDisplay = UILabel(frame: CGRect(x: 48, y: 373, width: 200, height: 19))
        emailDisplay.text = "Email"
        view.addSubview(emailDisplay)
        emailField = UITextField(frame: CGRect(x: 47, y: 389, width: 279, height: 33))
        emailField.placeholder = "HAAHHA"
        view.addSubview(emailField)
        
        registerBox = UIButton(frame: CGRect(x: 106, y: 456, width: 165, height: 33))
        registerBox.setTitle("Register", for: .normal)
        registerBox.backgroundColor = UIColor(red:0.60, green:0.83, blue:0.82, alpha:1.0)
        registerBox.setTitleColor(UIColor.white, for: .normal)
        registerBox.addTarget(self, action:#selector(pressRegister(_:)), for: .touchUpInside)
        view.addSubview(registerBox)
    }
    
    func pressRegister(_ sender: UIButton!) {
        print("hi")
        guard let emailAdd = emailField.text, let pass = passwordField.text else { return }
        FIRAuth.auth()?.createUser(withEmail: emailAdd, password: pass, completion: { (user, error) in
            if let error = error {
                print(error)
                return
            } else {
                print("User registered!")
                FIRAuth.auth()?.signIn(withEmail: emailAdd, password: pass, completion: { (user, error) in
                    if let error = error {
                        print(error)
                        return
                    } else {
                        //self.signedIn(user)
                        print("signed in!")
                        self.performSegue(withIdentifier: "toFeedAfterRegister", sender: self)
                    }
                })
            }
        })
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
