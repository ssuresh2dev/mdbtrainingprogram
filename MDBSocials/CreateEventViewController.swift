//
//  CreateEventViewController.swift
//  MDBSocials
//
//  Created by Eliot Han on 10/5/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class CreateEventViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var eventNameLabel: UILabel!
    var eventNameTextField: UITextField!
    
    var descriptionLabel: UILabel!
    var descriptionTextField: UITextView!
    
    var imageView: UIImageView!
    
    var eventDateLabel: UILabel!
    var eventDateTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var eventImageLabel: UILabel!
    var eventImageView: UIImageView! = UIImageView(image: UIImage(named: "emptyimage"))
    var actionSheetController : UIAlertController = UIAlertController(title: "Photos", message: "Select Camera or Photo Library", preferredStyle: .actionSheet)

    
    
    let rootRef = FIRDatabase.database().reference()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAlertController()
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = UIColor(red:0.96, green:1.00, blue:1.00, alpha:1.0)
        
        let bttn = UIButton()
        bttn.setImage(#imageLiteral(resourceName: "PostIcon"), for: .normal)
        bttn.frame = CGRect(x: 0, y: 0, width: 36, height: 27)
        bttn.addTarget(self, action: #selector(CreateEventViewController.postButtonClicked), for: .touchUpInside)
        let addEventButton = UIBarButtonItem()
        addEventButton.customView = bttn
        self.navigationItem.rightBarButtonItem = addEventButton
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Bar"), for: .default)
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "CreateEventBanner"))

        eventNameLabel = UILabel(frame: CGRect(x: 38.5, y: 90, width: 110, height: 19))
        eventNameLabel.text = "Name of event:"
        eventNameLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        view.addSubview(eventNameLabel)
        
        eventNameTextField = UITextField(frame: CGRect(x: 36, y: 108, width: 298, height: 33))
        eventNameTextField.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "NameEventTF"))
        view.addSubview(eventNameTextField)
        
        eventDateLabel = UILabel(frame: CGRect(x: 39.5, y: 158, width: 102, height: 19))
        eventDateLabel.text = "Date of event:"
        eventDateLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        view.addSubview(eventDateLabel)

        eventDateTextField = UITextField(frame: CGRect(x: 36, y: 176, width: 152, height: 33))
        eventDateTextField.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "DateEventTF"))
        view.addSubview(eventDateTextField)
        
        descriptionLabel = UILabel(frame: CGRect(x: 36.5, y: 225, width: 141, height: 19))
        descriptionLabel.text = "Describe the event:"
        descriptionLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        view.addSubview(descriptionLabel)
        
        descriptionTextField = UITextView(frame: CGRect(x: 36, y: 244, width: 298, height: 117))
        descriptionTextField.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "DescriptionTF"))
        view.addSubview(descriptionTextField)
        
        eventImageLabel = UILabel(frame: CGRect(x: 122, y: 397, width: 131, height: 19))
        eventImageLabel.text = "Insert image here:"
        eventImageLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        view.addSubview(eventImageLabel)
        
        eventImageView.frame = CGRect(x: 62, y: 416, width: 252, height: 192)
        eventImageView.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(eventImageView!)
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(CreateEventViewController.imageTapped))
        eventImageView.isUserInteractionEnabled = true
        eventImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func setupAlertController(){
        //Create and add the "Cancel" action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        //Create and add "Camera" action
        let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            
            //The user just pressed the camera button.
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        actionSheetController.addAction(cameraAction)
        
        let libraryAction: UIAlertAction = UIAlertAction(title: "Photo Library", style: .default){ action -> Void
            in
            //User just pressed library button
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
                print("library chosen")
                
                
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
                self.imagePicker.allowsEditing = false
                
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
        }
        actionSheetController.addAction(libraryAction)
    }
    func imageTapped(){
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
        

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            eventImageView.image = image
            print("image picked")
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    
    func postButtonClicked(){
        //Event references: Firebase Database
        let eventsRef = rootRef.child("events")
        let uniqueEventRef = eventsRef.childByAutoId()
        
        //Image References: Firebase Storage stuff
        let storageRef = FIRStorage.storage().reference(forURL: "gs://mdbsocials2.appspot.com")
        let imagesRef = storageRef.child("images")
        let eventImageRef = imagesRef.child("\(uniqueEventRef.key)")
        
        var posterName: String?
        let currentUserID = (FIRAuth.auth()?.currentUser?.uid)! as String
        let ref = rootRef.child("users").child(currentUserID)
        ref.observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: String]{
                posterName = dictionary["username"]
                
            }
        })
        print(posterName)
        
        //Event Information
        let eventData: [String : NSString] = ["eventTitle": eventNameTextField.text as NSString? ?? "None", "poster": (FIRAuth.auth()?.currentUser?.uid as NSString?)!, "eventDescription": descriptionTextField.text as NSString? ?? "None", "eventDate": eventDateTextField.text as NSString? ?? "None", "rsvp": "0", "posterName": posterName as NSString? ?? "None"]

        //Set Event Information
        uniqueEventRef.setValue(eventData){ (error, snap) in
            print("Success")
            print(error)
            
        }
        
        //Set Picture
        var data = NSData()
        data = UIImageJPEGRepresentation(eventImageView.image!, 0.8)! as NSData
        
        // Upload the file to the path eventImageRef
        var downloadURL: URL?
        let uploadTask = eventImageRef.put(data as Data, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                downloadURL = metadata!.downloadURL()
            }
            
        uniqueEventRef.child("downloadURL").setValue(downloadURL?.absoluteString){ (error, snap) in
            print("downloadURL added to uniqueeventRef")
        }

        }
        
        
        
        
        performSegue(withIdentifier: "unwindToFeed", sender: self)

        
//        eventsRef.setValue("hello")
//        eventsRef.observeSingleEvent(of: .Value) { (snap) in
//            print("GOT DATA")
//            print(snap)
////            if snap != nil {
//                eventsRef.setValue(["hello":"test"]) { (error, snap) in
//                    print("THERE WAS AN ERROR, YO:")
//                    print(error)
//                }
////
////            }
//            
//        }
        
//        print(eventData)
//        print(eventsRef)
//        print("worked")
        
//        rootRef.observeSingleEvent(of: .value, with: {snap in
//        
//            print("GOT DATA")
//            print(snap)
//        })
        
    }
}
