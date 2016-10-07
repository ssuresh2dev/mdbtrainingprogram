//
//  SignupViewController.swift
//  MDBSocials
//
//  Created by Eliot Han on 10/4/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit
import Firebase

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
    
    var password: String = ""
    var username: String = ""
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
//        let moreDisplay = RectangleSignUp(frame: CGRect(x: 30, y: view.frame.height/4, width: view.frame.width - 60, height: view.frame.height/3), firstName: firstName, lastName: lastName, firstNameField: firstNameField, lastNameField: lastNameField, usernameDisplay: usernameDisplay, usernameField: usernameField, passwordDisplay: passwordDisplay, passwordField: passwordField, emailDisplay: emailDisplay, emailField: emailField)
//        view.addSubview(moreDisplay)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: <#T##FIRAuthResultCallback?##FIRAuthResultCallback?##(FIRUser?, Error?) -> Void#>)
    }
    
    func display() {
        firstName = UILabel(frame: CGRect(x: 10, y: 15, width: 200, height: 30))
        firstName.text = "First Name"
        view.addSubview(firstName)
        lastName = UILabel(frame: CGRect(x: view.frame.width + 20, y: 15, width: 200, height: 30))
        lastName.text = "Last Name"
        view.addSubview(lastName)
        
        firstNameField = UITextField(frame: CGRect(x: 10, y: 47, width: 300, height: 60))
        firstNameField.placeholder = "lemme see"
        view.addSubview(firstNameField)
        lastNameField = UITextField(frame: CGRect(x: view.frame.width + 20, y: 47, width: 300, height: 60))
        lastNameField.placeholder = "YAS"
        view.addSubview(lastNameField)
        
        usernameDisplay = UILabel(frame: CGRect(x: 10, y: 117, width: view.frame.width - 40, height: 30))
        usernameDisplay.text = "Username"
        view.addSubview(usernameDisplay)
        usernameField = UITextField(frame: CGRect(x: 10, y: 153, width: view.frame.width-40, height: 60))
        usernameField.placeholder = "OK"
        view.addSubview(usernameField)
        
        emailDisplay = UILabel(frame: CGRect(x: 10, y: 228, width: view.frame.width-40, height: 30))
        emailDisplay.text = "Email"
        view.addSubview(emailDisplay)
        
        emailField = UITextField(frame: CGRect(x: 10, y: 263, width: view.frame.width-40, height: 60))
        emailField.placeholder = "HAAHHA"
        view.addSubview(emailField)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    class RectangleSignUp: UIView {
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
        
        init(frame: CGRect, firstName: UILabel, lastName: UILabel, firstNameField: UITextField, lastNameField: UITextField, usernameDisplay: UILabel, usernameField: UITextField, passwordDisplay: UILabel, passwordField: UITextField, emailDisplay: UILabel, emailField: UITextField) {
            super.init(frame: frame)
            self.firstNameField = firstNameField
            self.firstName = firstName
            self.lastNameField = lastNameField
            self.lastName = lastName
            self.usernameDisplay = usernameDisplay
            self.usernameField = usernameField
            self.passwordDisplay = passwordDisplay
            self.passwordField = passwordField
            self.emailField = emailField
            self.emailDisplay = emailDisplay
            screenDisplay()
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func screenDisplay() {
            firstName = UILabel(frame: CGRect(x: 10, y: 15, width: 200, height: 30))
            firstName.text = "First Name"
            addSubview(firstName)
            lastName = UILabel(frame: CGRect(x: frame.width + 20, y: 15, width: 200, height: 30))
            lastName.text = "Last Name"
            addSubview(lastName)
            
            firstNameField = UITextField(frame: CGRect(x: 10, y: 47, width: 300, height: 60))
            firstNameField.placeholder = "lemme see"
            addSubview(firstNameField)
            lastNameField = UITextField(frame: CGRect(x: frame.width + 20, y: 47, width: 300, height: 60))
            lastNameField.placeholder = "YAS"
            addSubview(lastNameField)
            
            usernameDisplay = UILabel(frame: CGRect(x: 10, y: 117, width: frame.width - 40, height: 30))
            usernameDisplay.text = "Username"
            addSubview(usernameDisplay)
            usernameField = UITextField(frame: CGRect(x: 10, y: 153, width: frame.width-40, height: 60))
            usernameField.placeholder = "OK"
            addSubview(usernameField)
            
            emailDisplay = UILabel(frame: CGRect(x: 10, y: 228, width: frame.width-40, height: 30))
            emailDisplay.text = "Email"
            addSubview(emailDisplay)
            
            emailField = UITextField(frame: CGRect(x: 10, y: 263, width: frame.width-40, height: 60))
            emailField.placeholder = "HAAHHA"
            addSubview(emailField)
        }
    }

}

