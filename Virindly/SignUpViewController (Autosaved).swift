//
//  SignUpViewController.swift
//  Virindly
//
//  Created by Candice Ye on 10/4/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import Firebase
import UIKit

class SignUpViewController: UIViewController {
    
    var inputFullNameTextField: UITextField!
    var inputUsernameTextField: UITextField!
    var inputPasswordTextField: UITextField!
    var inputEmailTextField: UITextField!
    var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Input Full Name Textfield
        inputFullNameTextField = UITextField()
        
        let inputFullNamePlaceholder = NSAttributedString(string: "What's your full name?", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputFullNameTextField.attributedPlaceholder = inputFullNamePlaceholder
        
        inputFullNameTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/3.3, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        inputFullNameTextField.font = UIFont.systemFont(ofSize: 15)
        inputFullNameTextField.borderStyle = UITextBorderStyle.roundedRect
        
        inputFullNameTextField.autocorrectionType = UITextAutocorrectionType.no
        inputFullNameTextField.keyboardType = UIKeyboardType.default
        inputFullNameTextField.returnKeyType = UIReturnKeyType.done
        
        self.view.addSubview(inputFullNameTextField)
        
        
        // Input Username Textfield
        inputUsernameTextField = UITextField()
        
        let inputUsernamePlaceholder = NSAttributedString(string: "Pick a unique username!", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputUsernameTextField.attributedPlaceholder = inputUsernamePlaceholder
        
        inputUsernameTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/2.5, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        inputUsernameTextField.font = UIFont.systemFont(ofSize: 15)
        inputUsernameTextField.borderStyle = UITextBorderStyle.roundedRect
        
        inputUsernameTextField.autocorrectionType = UITextAutocorrectionType.no
        inputUsernameTextField.keyboardType = UIKeyboardType.default
        inputUsernameTextField.returnKeyType = UIReturnKeyType.done
        
        self.view.addSubview(inputUsernameTextField)
        
        
        // Password Textfield
        inputPasswordTextField = UITextField()
        
        let inputPasswordPlaceholder = NSAttributedString(string: "Enter a new password.", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputPasswordTextField.attributedPlaceholder = inputPasswordPlaceholder
        
        inputPasswordTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        inputPasswordTextField.font = UIFont.systemFont(ofSize: 15)
        inputPasswordTextField.borderStyle = UITextBorderStyle.roundedRect
        
        inputPasswordTextField.autocorrectionType = UITextAutocorrectionType.no
        inputPasswordTextField.keyboardType = UIKeyboardType.default
        inputPasswordTextField.returnKeyType = UIReturnKeyType.done
        
        self.view.addSubview(inputPasswordTextField)
        
        
        // Password Textfield
        inputEmailTextField = UITextField()
        
        let inputEmailPlaceholder = NSAttributedString(string: "What's your email?", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputEmailTextField.attributedPlaceholder = inputEmailPlaceholder
        
        inputEmailTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/2.5, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        inputEmailTextField.font = UIFont.systemFont(ofSize: 15)
        inputEmailTextField.borderStyle = UITextBorderStyle.roundedRect
        
        inputEmailTextField.autocorrectionType = UITextAutocorrectionType.no
        inputEmailTextField.keyboardType = UIKeyboardType.default
        inputEmailTextField.returnKeyType = UIReturnKeyType.done
        
        self.view.addSubview(inputEmailTextField)
        
        
        // Signup Button
        signupButton = UIButton()
        signupButton.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/1.4, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        signupButton.setTitle("Hoo Hah!", for: .normal)
        signupButton.titleLabel!.font = UIFont(name: "Avenir", size: 15)
        signupButton.titleLabel!.textColor = UIColor.black
        signupButton.tintColor = UIColor.black
        signupButton.backgroundColor = UIColor.black
        signupButton.layer.cornerRadius = 5
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor.lightGray.cgColor
        signupButton.addTarget(self, action: #selector(hooHah), for: .touchUpInside)
        
        self.view.addSubview(signupButton)
    }

    func hooHah(sender: UIButton!) {
        print("1")
        if let email = inputEmailTextField.text, let pass = inputPasswordTextField.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                if let error = error {
                    print(error)
                    return
                }
                self.updateProfile(user: user!)
                print("hi")
            })
        }
    }
        
    func updateProfile(user: FIRUser) {
        print("2")
        if let name = inputFullNameTextField.text {
            let changeRequest = user.profileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges(completion: { (error) in
                if let error = error {
                    print(error)
                    return
                }
                self.signedIn(user: FIRAuth.auth()?.currentUser)
            })
        } else {
                return
        }
    }
        
    func signedIn(user: FIRUser?) {
        print("3")
        performSegue(withIdentifier: "segueSignUpToFeed", sender: signupButton)
    }
        
}

//
//  LoginViewController.swift
//  Virindly
//
//  Created by Ben Goldberg on 10/2/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var backgroundImage: UIImageView!
    var virindlyLogoView: UIImageView!
    var loginTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    var user: FIRUser!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        backgroundImage = UIImageView(image: #imageLiteral(resourceName: "Background.jpg"))
        backgroundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(backgroundImage)
        
        // VIRINDLY Logo
        virindlyLogoView = UIImageView(image: #imageLiteral(resourceName: "VIRINDLYLogoOrange"))
        virindlyLogoView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/7, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/9)
        self.view.addSubview(virindlyLogoView)
        
        
        // Login Textfield
        loginTextField = UITextField()
        
        let loginPlaceholder = NSAttributedString(string: "Please enter username", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        loginTextField.attributedPlaceholder = loginPlaceholder
        
        loginTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/2.5, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        loginTextField.font = UIFont.systemFont(ofSize: 15)
        loginTextField.borderStyle = UITextBorderStyle.roundedRect
        
        loginTextField.autocorrectionType = UITextAutocorrectionType.no
        loginTextField.keyboardType = UIKeyboardType.default
        loginTextField.returnKeyType = UIReturnKeyType.done
        
        self.view.addSubview(loginTextField)
        
        
        // Password Textfield
        passwordTextField = UITextField()
        
        let passwordPlaceholder = NSAttributedString(string: "Please enter password", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        passwordTextField.attributedPlaceholder = passwordPlaceholder
        
        passwordTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.borderStyle = UITextBorderStyle.roundedRect
        
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        
        self.view.addSubview(passwordTextField)
        
        
        // Login Button
        loginButton = UIButton()
        loginButton.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/1.6, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        loginButton.setTitle("Log in!", for: .normal)
        loginButton.tintColor = UIColor.white
        loginButton.titleLabel!.font = UIFont(name: "Avenir", size: 15)
        loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.40)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.clear.cgColor
        
        
        loginButton.addTarget(self, action: #selector(pressedLoginButton), for: .touchUpInside)
        self.performSegue(withIdentifier: "segueLoginToFeed", sender: loginButton)
        
        self.view.addSubview(loginButton)
        
        
        // Signup Button
        signupButton = UIButton()
        signupButton.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/1.375, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        signupButton.setTitle("Don't have an account? Sign up!", for: .normal)
        signupButton.tintColor = UIColor.white
        signupButton.titleLabel!.font = UIFont(name: "Avenir", size: 15)
        signupButton.backgroundColor = UIColor.white.withAlphaComponent(0.40)
        signupButton.layer.cornerRadius = 5
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor.clear.cgColor
        
        signupButton.addTarget(self, action: #selector(pressedSignUpButton), for: .touchUpInside)
        self.performSegue(withIdentifier: "segueToSignUp", sender: signupButton)
        
        self.view.addSubview(signupButton)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueLoginToFeed" {
            let dest = segue.destination as! FeedViewController
            dest.user = user
        }
    }
    
    // FUNCTIONS
    func pressedSignUpButton(sender: UIButton!) {
        performSegue(withIdentifier: "segueToSignUp", sender: self)
    }

    func pressedLoginButton(sender: UIButton!) {
        if let login = loginTextField.text, let pass = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: login, password: pass, completion: { (user, error) in
                if let error = error {
                    print(error)
                    return
                }
                self.signedIn(user: user!)
            })
        }
    }
    
    func signedIn(user: FIRUser) {
        performSegue(withIdentifier: "segueLoginToFeed", sender: self)
    }
}
