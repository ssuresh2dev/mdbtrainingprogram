//
//  LoginViewController.swift
//  MDBSocials
//
//  Created by Jessica Chen on 10/2/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    var appLabel: UILabel!
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addButtonTargets()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addButtonTargets(){
        //add Login Button Target Action
        loginButton.addTarget(self, action: #selector(clickedLogin), for: .touchUpInside)
        //add Signup Button Target Action
        signupButton.addTarget(self, action: #selector(clickedSignup), for: .touchUpInside)
    }
    func setUI(){
        
        view.backgroundColor = themeColor
        appLabel = UILabel(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.13, width: view.frame.width * 0.6, height: 50))
        appLabel.text = "MDB Socials"
        appLabel.numberOfLines = 1
        appLabel.adjustsFontSizeToFitWidth = true
        appLabel.font = UIFont(name: "Avenir-Black", size: 32.0)
        appLabel.textAlignment = NSTextAlignment.center
        appLabel.textColor = UIColor.white
        view.addSubview(appLabel)
        
        emailLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27, width: view.frame.width * 0.5, height: 30))
        emailLabel.text = "Email:"
        emailLabel.numberOfLines = 1
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        emailLabel.textAlignment = NSTextAlignment.left
        emailLabel.textColor = UIColor.white
        view.addSubview(emailLabel)
        
        emailTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 33, width: 220, height: 30))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.font = UIFont(name: "HelveticaNeue", size: 18.0)
        emailTextField.textAlignment = NSTextAlignment.left
        emailTextField.backgroundColor = UIColor.white
        emailTextField.borderStyle = .roundedRect
        view.addSubview(emailTextField)
        
        passwordLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 75, width: view.frame.width * 0.5, height: 30))
        passwordLabel.text = "Password:"
        passwordLabel.numberOfLines = 1
        passwordLabel.adjustsFontSizeToFitWidth = true
        passwordLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        passwordLabel.textAlignment = NSTextAlignment.left
        passwordLabel.textColor = UIColor.white
        view.addSubview(passwordLabel)
        
        passwordTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 108, width: 220, height: 30))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.font = UIFont(name: "HelveticaNeue", size: 18.0)
        passwordTextField.textAlignment = NSTextAlignment.left
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.borderStyle = .roundedRect
        view.addSubview(passwordTextField)
        
        
        loginButton = UIButton(frame: CGRect(x: view.frame.width * 0.25, y: view.frame.height * 0.27 + 191, width: view.frame.width * 0.5, height: 40))
        loginButton.setTitle("Login", for: UIControlState.normal)
        loginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        loginButton.setTitleColor(themeColor, for: UIControlState.normal)
        loginButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        loginButton.addTarget(self, action: #selector(self.clickedLogin(_:)), for: UIControlEvents.touchUpInside)
        loginButton.backgroundColor = UIColor.white
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        view.addSubview(loginButton)
        
        signupButton = UIButton(frame: CGRect(x: view.frame.width * 0.25, y: view.frame.height * 0.27 + 251, width: view.frame.width * 0.5, height: 40))
        signupButton.setTitle("Sign Up", for: UIControlState.normal)
        signupButton.titleLabel?.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        signupButton.setTitleColor(themeColor, for: UIControlState.normal)
        signupButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        signupButton.addTarget(self, action: #selector(self.clickedSignup(_:)), for: UIControlEvents.touchUpInside)
        signupButton.backgroundColor = UIColor.white
        signupButton.layer.cornerRadius = 5
        signupButton.clipsToBounds = true
        view.addSubview(signupButton)
    }
    
    func clickedLogin(_ sender: UIButton!) {
        // Sign In with credentials.
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(user!)
        }
    }
    
    func clickedSignup(_ sender: UIButton!) {
        performSegue(withIdentifier: "toSignUp", sender: self)
    }
    
    func signedIn(_ user: FIRUser?) {
        MeasurementHelper.sendLoginEvent()
        
        AppState.sharedInstance.displayName = user?.displayName ?? user?.email
        AppState.sharedInstance.photoURL = user?.photoURL
        AppState.sharedInstance.signedIn = true
        let notificationName = Notification.Name(rawValue: Constants.NotificationKeys.SignedIn)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
        self.performSegue(withIdentifier: "toFeed", sender: self)
    }
    
    func setDisplayName(_ user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(FIRAuth.auth()?.currentUser)
        }
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
