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
    
    var emailDIsplay: UILabel!
    var emailField: UITextField!
    
    var password: String = ""
    var username: String = ""
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
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
        firstName = UILabel(frame: CGRect(x: view.frame.height/3 + 60, y: view.frame.height/2 + 80, width: view.frame.width, height: 50))
        firstName.text = "First Name"
        view.addSubview(firstName)
        
        lastName = UILabel(frame: CGRect(x: view.frame.height/2 - 80, y: view.frame.height/2, width: view.frame.height, height: 40))
        lastName.text = "Last Name"
        view.addSubview(lastName)
        
        firstNameField = UITextField(frame: CGRect(x: view.frame.height/2 - 30, y: view.frame.height/3 + 20, width: view.frame.height, height: 40))
        
        lastNameField = UITextField(frame: CGRect(x: view.frame.height/2 + 30, y: view.frame.height/3 + 20, width: view.frame.height, height: 40))
        
        usernameDisplay = UILabel(frame: CGRect(x: view.frame.height/2 - 30, y: view.frame.height/2 + 50, width: view.frame.height, height: 40))
        usernameDisplay.text = "Username"
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
