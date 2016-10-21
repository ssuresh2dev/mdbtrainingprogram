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

class SignupViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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
    var selectButton: UIButton!
    var uploadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addButtonTargets()
//        imagepicker.source = self
        
        
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
        
        selectButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
    }
    
    
    func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectButton.contentMode = .scaleAspectFit
            selectButton.setBackgroundImage(image, for: .normal)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          dismiss(animated: true, completion: nil)
    }
    
    
    func setUI() {
        
        view.backgroundColor = themeColor
        
        backToLoginButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.2, height: view.frame.height * 0.1))
        backToLoginButton.setTitle("Back", for: UIControlState.normal)
        backToLoginButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        backToLoginButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        backToLoginButton.addTarget(self, action: #selector(self.clickedBackToLogin(_:)), for: UIControlEvents.touchUpInside)
        backToLoginButton.clipsToBounds = true
        view.addSubview(backToLoginButton)
        
        appLabel = UILabel(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.13 - 18, width: view.frame.width * 0.6, height: 50))
        appLabel.text = "MDB Socials"
        appLabel.numberOfLines = 1
        appLabel.adjustsFontSizeToFitWidth = true
        appLabel.font = UIFont(name: "Avenir-Black", size: 32.0)
        appLabel.textAlignment = NSTextAlignment.center
        appLabel.textColor = UIColor.white
        view.addSubview(appLabel)
        
        
        fullNameLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 - 35, width: view.frame.width * 0.5, height: 30))
        fullNameLabel.text = "Full Name:"
        fullNameLabel.numberOfLines = 1
        fullNameLabel.adjustsFontSizeToFitWidth = true
        fullNameLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        fullNameLabel.textAlignment = NSTextAlignment.left
        fullNameLabel.textColor = UIColor.white
        view.addSubview(fullNameLabel)
        
        fullNameTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 - 2, width: view.frame.width * 0.7, height: 30))
        fullNameTextField.adjustsFontSizeToFitWidth = true
        fullNameTextField.font = UIFont(name: "HelveticaNeue", size: 18.0)
        fullNameTextField.textAlignment = NSTextAlignment.left
        fullNameTextField.backgroundColor = UIColor.white
        view.addSubview(fullNameTextField)
        
        
        emailLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 40, width: view.frame.width * 0.5, height: 30))
        emailLabel.text = "Email:"
        emailLabel.numberOfLines = 1
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        emailLabel.textAlignment = NSTextAlignment.left
        emailLabel.textColor = UIColor.white
        view.addSubview(emailLabel)
        
        emailTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 73, width: view.frame.width * 0.7, height: 30))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.font = UIFont(name: "HelveticaNeue", size: 18.0)
        emailTextField.textAlignment = NSTextAlignment.left
        emailTextField.backgroundColor = UIColor.white
        view.addSubview(emailTextField)
        
        
        passwordLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 115, width: view.frame.width * 0.5, height: 30))
        passwordLabel.text = "Password:"
        passwordLabel.numberOfLines = 1
        passwordLabel.adjustsFontSizeToFitWidth = true
        passwordLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        passwordLabel.textAlignment = NSTextAlignment.left
        passwordLabel.textColor = UIColor.white
        view.addSubview(passwordLabel)
        
        passwordTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 148, width: view.frame.width * 0.7, height: 30))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.font = UIFont(name: "HelveticaNeue", size: 18.0)
        passwordTextField.textAlignment = NSTextAlignment.left
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        
        confirmLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 190, width: view.frame.width * 0.5, height: 30))
        confirmLabel.text = "Confirm Password:"
        confirmLabel.numberOfLines = 1
        confirmLabel.adjustsFontSizeToFitWidth = true
        confirmLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        confirmLabel.textAlignment = NSTextAlignment.left
        confirmLabel.textColor = UIColor.white
        view.addSubview(confirmLabel)
        
        confirmTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 222, width: view.frame.width * 0.7, height: 30))
        confirmTextField.adjustsFontSizeToFitWidth = true
        confirmTextField.font = UIFont(name: "HelveticaNeue", size: 18.0)
        confirmTextField.textAlignment = NSTextAlignment.left
        confirmTextField.backgroundColor = UIColor.white
        confirmTextField.isSecureTextEntry = true
        view.addSubview(confirmTextField)
        
        
        uploadLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.27 + 269, width: view.frame.width * 0.7, height: 30))
        uploadLabel.text = "Select Profile Image:"
        uploadLabel.numberOfLines = 1
        uploadLabel.adjustsFontSizeToFitWidth = true
        uploadLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        uploadLabel.textAlignment = NSTextAlignment.left
        uploadLabel.textColor = UIColor.white
        view.addSubview(uploadLabel)
        
        selectButton = UIButton(frame: CGRect(x: view.frame.width * 0.35, y: view.frame.height * 0.27 + 316, width: view.frame.width * 0.3, height: view.frame.width * 0.3))
        selectButton.setBackgroundImage(#imageLiteral(resourceName: "uploadimg"), for: .normal)
        view.addSubview(selectButton)
        
        signupButton = UIButton(frame: CGRect(x: view.frame.width * 0.25, y: view.frame.height * 0.27 + view.frame.width * 0.3 + 338, width: view.frame.width * 0.5, height: 40))
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.titleLabel?.font = UIFont(name: "HelveticaNeue-SemiBold", size: 24.0)
        signupButton.backgroundColor = UIColor.white
        signupButton.setTitleColor(themeColor, for: UIControlState.normal)
        signupButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        signupButton.addTarget(self, action: #selector(self.clickedSignup(_:)), for: UIControlEvents.touchUpInside)
        signupButton.layer.cornerRadius = 5
        signupButton.clipsToBounds = true
        view.addSubview(signupButton)
        
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
                self.setProfPic(user!)
            }
        }
        //        let storageRef = FIRStorage.storage().reference()
        //        let databaseRef = FIRDatabase.database().reference()
        //        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        //            selectButton.contentMode = .scaleAspectFit
        //            selectButton.setBackgroundImage(image, for: .normal)
        //        }
        //        dismiss(animated: true, completion: nil)
        //        var data = NSData()
        //        data = UIImageJPEGRepresentation(selectButton.backgroundImage(for: .normal)!, 0.8)! as NSData
        //        // set upload path
        //        let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\("userPhoto")"
        //        let metaData = FIRStorageMetadata()
        //        metaData.contentType = "image/jpg"
        //        storageRef.child(filePath).put(data as Data, metadata: metaData){(metaData,error) in
        //            if let error = error {
        //                print(error.localizedDescription)
        //                return
        //            }else{
        //                //store downloadURL
        //                let downloadURL = metaData!.downloadURL()!.absoluteString
        //                //store downloadURL at database
        //            databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["userPhoto": downloadURL])
        //            }
        //            }
        //            dismiss(animated: true, completion: nil)
        
    }
    
    func setProfPic(_ user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        //changeRequest.photoURL = //user.email!.components(separatedBy: "@")[0]
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
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
