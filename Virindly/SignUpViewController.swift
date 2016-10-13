//
//  SignUpViewController.swift
//  Virindly
//
//  Created by Candice Ye on 10/4/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Input Full Name Textfield
        let inputFullNameTextField = UITextField()
        
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
        let inputUsernameTextField = UITextField()
        
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
        let inputPasswordTextField = UITextField()
        
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
        let inputEmailTextField = UITextField()
        
        let inputEmailPlaceholder = NSAttributedString(string: "What's your email?", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputEmailTextField.attributedPlaceholder = inputEmailPlaceholder
        
        inputEmailTextField.frame = CGRect(x: UIScreen.main.bounds.width/16, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/2.5, width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/12)
        inputEmailTextField.font = UIFont.systemFont(ofSize: 15)
        inputEmailTextField.borderStyle = UITextBorderStyle.roundedRect
        
        inputEmailTextField.autocorrectionType = UITextAutocorrectionType.no
        inputEmailTextField.keyboardType = UIKeyboardType.default
        inputEmailTextField.returnKeyType = UIReturnKeyType.done
        
        self.view.addSubview(inputEmailTextField)
        
        
        
        // Do any additional setup after loading the view.
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
