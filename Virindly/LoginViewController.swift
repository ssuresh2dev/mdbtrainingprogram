//
//  LoginViewController.swift
//  Virindly
//
//  Created by Ben Goldberg on 10/2/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // Segues
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "Background.jpg"))
        backgroundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(backgroundImage)
        
        // VIRINDLY Logo
        let virindlyLogoView = UIImageView(image: #imageLiteral(resourceName: "VIRINDLYLogoOrange"))
        virindlyLogoView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/7, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/9)
        self.view.addSubview(virindlyLogoView)
        

        // Login Textfield
        let loginTextField = UITextField()
        
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
        let passwordTextField = UITextField()
        
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
        let loginButton = UIButton()
        loginButton.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/1.6, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        loginButton.setTitle("Log in!", for: .normal)
        loginButton.tintColor = UIColor.white
        loginButton.titleLabel!.font = UIFont(name: "Avenir", size: 15)
        loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.40)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.clear.cgColor
        
        self.view.addSubview(loginButton)
        
        
        // Signup Button
        let signupButton = UIButton()
        signupButton.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/1.375, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        signupButton.setTitle("Don't have an account? Sign up!", for: .normal)
        signupButton.tintColor = UIColor.white
        signupButton.titleLabel!.font = UIFont(name: "Avenir", size: 15)
        signupButton.backgroundColor = UIColor.white.withAlphaComponent(0.40)
        signupButton.layer.cornerRadius = 5
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor.clear.cgColor
        
        signupButton.addTarget(self, action: #selector(LoginViewController.pressedSignUpButton(sender:)), for: .touchUpInside)
        
        
        self.performSegue(withIdentifier: "segueToSignUp", sender: signupButton)
        
        self.view.addSubview(signupButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pressedSignUpButton(sender: UIButton!) {
        performSegue(withIdentifier: "segueToSignUp", sender: self)
    }


}

