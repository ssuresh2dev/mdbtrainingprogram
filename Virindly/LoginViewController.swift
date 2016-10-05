//
//  LoginViewController.swift
//  Virindly
//
//  Created by Ben Goldberg on 10/2/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // VIRINDLY Logo
        let virindlyLogoView = UIImageView(image: #imageLiteral(resourceName: "virindlyTitle"))
        virindlyLogoView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/13, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/9)
        self.view.addSubview(virindlyLogoView)
        
        // Login Textfield 
        /*
        let loginTextField = UITextField()
        loginTextField.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/3, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/12)
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Enter username")
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Enter username", attributes: [NSForegroundColorAttributeName: UIColor.yellow])
        loginTextField.backgroundColor = UIColor.gray
        self.view.addSubview(loginTextField)
         */
        

        // Login Textfield
        let loginTextField = UITextField()
        
        let loginPlaceholder = NSAttributedString(string: "Enter username", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        loginTextField.attributedPlaceholder = loginPlaceholder
        
        loginTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height/3, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/12)
        loginTextField.font = UIFont.systemFont(ofSize: 20)
        loginTextField.borderStyle = UITextBorderStyle.roundedRect
        
        loginTextField.autocorrectionType = UITextAutocorrectionType.no
        loginTextField.keyboardType = UIKeyboardType.default
        loginTextField.returnKeyType = UIReturnKeyType.done
        self.view.addSubview(loginTextField)

        
        
        
        
        
        // Login Button
        let loginButton = UIButton()
        loginButton.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/3, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/12)
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = UIColor.white
        loginButton.titleLabel!.font = UIFont(name: "Avenir", size: 20)
        loginButton.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

