//
//  SignUpViewController.swift
//  MDBSocials
//
//  Created by Mohit Katyal on 10/2/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    var backgroundImage : UIImageView!
    var signUpLabel : UILabel!
    var nameLabel : UILabel!
    var nameTextField : UITextField!
    var usernameLabel : UILabel!
    var usernameTextField : UITextField!
    var emailLabel : UILabel!
    var emailTextField : UITextField!
    var passwordLabel : UILabel!
    var passwordTextField : UITextField!
    var passwordRequirementLabel :UILabel!
    var createAccountButton : UIButton!
    var backButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //Should Create a new account
    func createAccountPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error{
                print(error)
                return
            }else {
                self.setDisplayName(user)
                AppState.sharedInstance.signedIn = true
            }
            
        })
    }
    
    func setDisplayName(_ user: FIRUser?) {
        let changeRequest = user?.profileChangeRequest()
        changeRequest?.displayName = user?.email!.components(separatedBy: "@")[0]
        changeRequest?.commitChanges(completion: { (error) in
            if let error = error {
                print(error)
                return
            } else {
                self.signedIn(FIRAuth.auth()?.currentUser)
            }
        })
    }
    
    func signedIn(_ user: FIRUser?) {
        performSegue(withIdentifier: "signUpToFeed", sender: self)
    }

    func backPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpUI() {
        //set background
        backgroundImage = UIImageView(frame: view.frame)
        backgroundImage.image = #imageLiteral(resourceName: "background")
        view.addSubview(backgroundImage)
        
        //add sign up labels
        signUpLabel = UILabel(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.1, width: view.frame.width * 0.8, height: view.frame.height * 0.15))
        signUpLabel.text = "Sign Up"
        signUpLabel.textColor = UIColor.white
        signUpLabel.textAlignment = .center
        signUpLabel.font = UIFont(name: signUpLabel.font.fontName, size: 50)
        signUpLabel.backgroundColor = UIColor(red: 41/255, green: 70/255, blue: 164/255, alpha: 0.9)
        signUpLabel.layer.masksToBounds = true
        signUpLabel.layer.cornerRadius = 10
        view.addSubview(signUpLabel)
        
        //add "Full Name: " label
        nameLabel = UILabel(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.3, width: view.frame.width * 0.275, height: view.frame.height * 0.05))
        nameLabel.text = "Full Name: "
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        nameLabel.font = UIFont(name: nameLabel.font.fontName, size: 20)
        view.addSubview(nameLabel)
        
        //add textField for name
        nameTextField = UITextField(frame: CGRect(x: view.frame.width * 0.375, y: view.frame.height * 0.3, width: view.frame.width * 0.525, height: view.frame.height * 0.05))
        nameTextField.placeholder = "  Oski Bear"
        nameTextField.layer.masksToBounds = true
        nameTextField.layer.cornerRadius = 5
        nameTextField.backgroundColor = UIColor.white
        view.addSubview(nameTextField)
        
        //add username label
        usernameLabel = UILabel(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.4, width: view.frame.width * 0.3, height: view.frame.height * 0.05))
        usernameLabel.text = "Username: "
        usernameLabel.textColor = UIColor.white
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        usernameLabel.font = UIFont(name: usernameLabel.font.fontName, size: 20)
        view.addSubview(usernameLabel)
        
        //add username text field
        usernameTextField = UITextField(frame: CGRect(x: view.frame.width * 0.375, y: view.frame.height * 0.4, width: view.frame.width * 0.525, height: view.frame.height * 0.05))
        usernameTextField.placeholder = "  oskiBearrr"
        usernameTextField.layer.masksToBounds = true
        usernameTextField.layer.cornerRadius = 5
        usernameTextField.backgroundColor = UIColor.white
        view.addSubview(usernameTextField)
        
        //add email label
        emailLabel = UILabel(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.5, width: view.frame.width * 0.15, height: view.frame.height * 0.05))
        emailLabel.text = "Email: "
        emailLabel.textColor = UIColor.white
        emailLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        emailLabel.font = UIFont(name: emailLabel.font.fontName, size: 20)
        view.addSubview(emailLabel)
        
        //add email text field
        emailTextField = UITextField(frame: CGRect(x: view.frame.width * 0.275, y: view.frame.height * 0.5, width: view.frame.width * 0.625, height: view.frame.height * 0.05))
        emailTextField.placeholder = "  oski@bearrr.edu"
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 5
        emailTextField.backgroundColor = UIColor.white
        view.addSubview(emailTextField)
        
        //add password label
        passwordLabel = UILabel(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.6, width: view.frame.width * 0.275, height: view.frame.height * 0.05))
        passwordLabel.text = "Password: "
        passwordLabel.textColor = UIColor.white
        passwordLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        passwordLabel.font = UIFont(name: passwordLabel.font.fontName, size: 20)
        view.addSubview(passwordLabel)
        
        //add password text field
        passwordTextField = UITextField(frame: CGRect(x: view.frame.width * 0.375, y: view.frame.height * 0.6, width: view.frame.width * 0.525, height: view.frame.height * 0.05))
        passwordTextField.placeholder = "  oskisPassword123"
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.backgroundColor = UIColor.white
        view.addSubview(passwordTextField)
        
        
        //add password requirements label
        passwordRequirementLabel = UILabel(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.65, width: view.frame.width * 0.7, height: view.frame.height * 0.05))
        passwordRequirementLabel.text = "* minimum 6 characters in length"
        passwordRequirementLabel.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)
        passwordRequirementLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        passwordRequirementLabel.font = UIFont(name: passwordRequirementLabel.font.fontName, size: 17)
        view.addSubview(passwordRequirementLabel)
        
        //add create account button
        createAccountButton = UIButton(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.75, width: view.frame.width * 0.8, height: view.frame.height * 0.15))
        createAccountButton.setTitle("Create an Account!", for: .normal)
        createAccountButton.backgroundColor = UIColor(red: 255/255, green: 191/255, blue: 0/255, alpha: 1)
        createAccountButton.setTitleColor(UIColor.white, for: .normal)
        createAccountButton.layer.cornerRadius = 10
        createAccountButton.addTarget(self, action: #selector(createAccountPressed), for: .touchUpInside)
        view.addSubview(createAccountButton)
        
        //add back button
        backButton = UIButton(frame: CGRect(x: view.frame.width * 0, y: view.frame.height * 0.025, width: view.frame.width * 0.2, height: view.frame.height * 0.05))
        backButton.setTitle("<- Back", for: .normal)
        backButton.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1), for: .normal)
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        view.addSubview(backButton)
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
