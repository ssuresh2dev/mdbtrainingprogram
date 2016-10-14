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
import FirebaseDatabase

class SignupViewController: UIViewController {
    var firstName: UIImageView!
    var lastName: UIImageView!
    
    var firstNameField: UITextField!
    var lastNameField: UITextField!
    
    var usernameDisplay: UIImageView!
    var usernameField: UITextField!
    
    var passwordDisplay: UIImageView!
    var passwordField: UITextField!
    
    var emailDisplay: UIImageView!
    var emailField: UITextField!
    
    var registerBox: UIButton!
    var signUpDisplay: UIImageView!
    var clearBoxView: UIImageView!
    
    var password: String = ""
    var username: String = ""
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "SignUpBG"))
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setUpUI() {
        signUpDisplay = UIImageView(frame: CGRect(x: 99, y: 111, width: 165, height: 46))
        signUpDisplay.image = #imageLiteral(resourceName: "SignUp")
        signUpDisplay.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(signUpDisplay)
        
        clearBoxView = UIImageView(frame: CGRect(x: 38, y: 150, width: 303, height: 369))
        clearBoxView.image = #imageLiteral(resourceName: "ClearBox")
        clearBoxView.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(clearBoxView)
        
        firstName = UIImageView(frame: CGRect(x: 48, y: 162, width: 75, height: 19))
        firstName.image = #imageLiteral(resourceName: "FirstName")
        firstName.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(firstName)
        
        lastName = UIImageView(frame: CGRect(x: 205, y: 163, width: 73, height: 19))
        lastName.image = #imageLiteral(resourceName: "LastName")
        lastName.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(lastName)
        
        firstNameField = UITextField(frame: CGRect(x: 47, y: 181, width: 122, height: 33))
        firstNameField.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "FLNameBox"))
        view.addSubview(firstNameField)
        lastNameField = UITextField(frame: CGRect(x: 204, y: 181, width: 122, height: 33))
        lastNameField.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "FLNameBox"))
        view.addSubview(lastNameField)
        
        usernameDisplay = UIImageView(frame: CGRect(x: 45.5, y: 227, width: 70, height: 19))
        usernameDisplay.image = #imageLiteral(resourceName: "Username")
        usernameDisplay.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(usernameDisplay)
        usernameField = UITextField(frame: CGRect(x: 46, y: 246, width: 273, height: 33))
        usernameField.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "RegTextFieldBox"))
        view.addSubview(usernameField)
        
        passwordDisplay = UIImageView(frame: CGRect(x: 46, y: 299, width: 65, height: 19))
        passwordDisplay.image = #imageLiteral(resourceName: "Password")
        passwordDisplay.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(passwordDisplay)
        passwordField = UITextField(frame: CGRect(x: 46, y: 318, width: 279, height: 33))
        passwordField.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "RegTextFieldBox"))
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)
        
        emailDisplay = UIImageView(frame: CGRect(x: 48, y: 373, width: 38, height: 19))
        emailDisplay.image = #imageLiteral(resourceName: "Email")
        emailDisplay.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(emailDisplay)
        emailField = UITextField(frame: CGRect(x: 47, y: 389, width: 279, height: 33))
        emailField.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "RegTextFieldBox"))
        view.addSubview(emailField)
        
        registerBox = UIButton(frame: CGRect(x: 106, y: 456, width: 165, height: 33))
        registerBox.setImage(#imageLiteral(resourceName: "RegisterButton"), for: .normal)
        registerBox.addTarget(self, action:#selector(pressRegister(_:)), for: .touchUpInside)
        view.addSubview(registerBox)
    }
    
    func pressRegister(_ sender: UIButton!) {
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
                        
                        //Create User Object in FirDatabase
                        let rootRef = FIRDatabase.database().reference()
                        let uid = FIRAuth.auth()?.currentUser?.uid
                        let userData: [String: NSString] = ["firstName": (self.firstNameField.text as NSString?)!, "lastName": (self.lastNameField.text as NSString?)!, "uid": (uid as NSString?)!, "username": (self.usernameField.text as NSString?)!]
                        
                        
                        let usersRef = rootRef.child("users")
                        usersRef.child(uid!).setValue(userData){ (error, snap) in
                            print("Success in creating user in Firdatabase")
                            print(error)
                        }
                        
                        
                        
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
