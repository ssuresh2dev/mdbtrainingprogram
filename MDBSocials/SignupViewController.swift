//
//  SignupViewController.swift
//  MDBSocials
//
//  Created by Shubham Goenka on 10/2/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit
import Firebase


let themeColor = UIColor(colorLiteralRed: 51/255, green: 153/255, blue: 255/255, alpha: 1)

class SignupViewController: UIViewController {
    
    var appLabel: UILabel!
    var fullNameLabel: UILabel!
    var fullNameTextField: UITextField!
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
    var confirmLabel: UILabel!
    var confirmTextField: UITextField!
    var signupButton: UIButton!
    var backToLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addButtonTargets()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addButtonTargets(){
        //add Login Button Target Action
        backToLoginButton.addTarget(self, action: #selector(clickedBackToLogin), for: .touchUpInside)
        
        //add Signup Button Target Action
        signupButton.addTarget(self, action: #selector(clickedSignup), for: .touchUpInside)
    }
    
    func setUI() {
        
        view.backgroundColor = themeColor
        
        appLabel = UILabel(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.13, width: view.frame.width * 0.6, height: 50))
        appLabel.text = "MDB Socials"
        appLabel.numberOfLines = 1
        appLabel.adjustsFontSizeToFitWidth = true
        appLabel.font = UIFont(name: "Avenir-Black", size: 32.0)
        appLabel.textAlignment = NSTextAlignment.center
        appLabel.textColor = UIColor.white
        view.addSubview(appLabel)
        
        
        fullNameLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27, width: view.frame.width * 0.5, height: 30))
        fullNameLabel.text = "Full Name:"
        fullNameLabel.numberOfLines = 1
        fullNameLabel.adjustsFontSizeToFitWidth = true
        fullNameLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        fullNameLabel.textAlignment = NSTextAlignment.left
        fullNameLabel.textColor = UIColor.white
        view.addSubview(fullNameLabel)
        
        fullNameTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 33, width: view.frame.width * 0.7, height: 30))
        fullNameTextField.adjustsFontSizeToFitWidth = true
        fullNameTextField.font = UIFont(name: "HelveticaNeue", size: 18.0)
        fullNameTextField.textAlignment = NSTextAlignment.left
        fullNameTextField.backgroundColor = UIColor.white
        view.addSubview(fullNameTextField)
        
        
        emailLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 75, width: view.frame.width * 0.5, height: 30))
        emailLabel.text = "Email:"
        emailLabel.numberOfLines = 1
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        emailLabel.textAlignment = NSTextAlignment.left
        emailLabel.textColor = UIColor.white
        view.addSubview(emailLabel)
        
        emailTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 108, width: view.frame.width * 0.7, height: 30))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.font = UIFont(name: "HelveticaNeue", size: 18.0)
        emailTextField.textAlignment = NSTextAlignment.left
        emailTextField.backgroundColor = UIColor.white
        view.addSubview(emailTextField)
        
        
        passwordLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 150, width: view.frame.width * 0.5, height: 30))
        passwordLabel.text = "Password:"
        passwordLabel.numberOfLines = 1
        passwordLabel.adjustsFontSizeToFitWidth = true
        passwordLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        passwordLabel.textAlignment = NSTextAlignment.left
        passwordLabel.textColor = UIColor.white
        view.addSubview(passwordLabel)
        
        passwordTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 183, width: view.frame.width * 0.7, height: 30))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.font = UIFont(name: "HelveticaNeue", size: 18.0)
        passwordTextField.textAlignment = NSTextAlignment.left
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        
        confirmLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 225, width: view.frame.width * 0.5, height: 30))
        confirmLabel.text = "Confirm Password:"
        confirmLabel.numberOfLines = 1
        confirmLabel.adjustsFontSizeToFitWidth = true
        confirmLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        confirmLabel.textAlignment = NSTextAlignment.left
        confirmLabel.textColor = UIColor.white
        view.addSubview(confirmLabel)
        
        confirmTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 257, width: view.frame.width * 0.7, height: 30))
        confirmTextField.adjustsFontSizeToFitWidth = true
        confirmTextField.font = UIFont(name: "HelveticaNeue", size: 18.0)
        confirmTextField.textAlignment = NSTextAlignment.left
        confirmTextField.backgroundColor = UIColor.white
        confirmTextField.isSecureTextEntry = true
        view.addSubview(confirmTextField)
        
        
        signupButton = UIButton(frame: CGRect(x: view.frame.width * 0.25, y: view.frame.height * 0.27 + 330, width: view.frame.width * 0.5, height: 40))
        signupButton.setTitle("Sign Up", for: UIControlState.normal)
        signupButton.titleLabel?.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        signupButton.setTitleColor(themeColor, for: UIControlState.normal)
        signupButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        signupButton.addTarget(self, action: #selector(self.clickedSignup(_:)), for: UIControlEvents.touchUpInside)
        signupButton.backgroundColor = UIColor.white
        signupButton.layer.cornerRadius = 5
        signupButton.clipsToBounds = true
        view.addSubview(signupButton)
        
        backToLoginButton = UIButton(frame: CGRect(x: view.frame.width * 0.25, y: view.frame.height * 0.27 + 390, width: view.frame.width * 0.5, height: 40))
        backToLoginButton.setTitle("Back To Login", for: UIControlState.normal)
        backToLoginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        backToLoginButton.setTitleColor(themeColor, for: UIControlState.normal)
        backToLoginButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        backToLoginButton.addTarget(self, action: #selector(self.clickedBackToLogin(_:)), for: UIControlEvents.touchUpInside)
        backToLoginButton.backgroundColor = UIColor.white
        backToLoginButton.layer.cornerRadius = 5
        backToLoginButton.clipsToBounds = true
        view.addSubview(backToLoginButton)
    }
    
    func clickedSignup(_ sender: UIButton!) {
        if(passwordTextField.text != confirmTextField.text) {
            let alert = UIAlertController(title: "Error:", message: "Passwords do not match.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                let alert = UIAlertController(title: "Error:", message: "Invalid password.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                self.setDisplayName(user!)
            }
        }
        
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

    
    func clickedBackToLogin(_ sender: UIButton!) {
        
        performSegue(withIdentifier: "backToLogin", sender: self)
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
