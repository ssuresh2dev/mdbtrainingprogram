//
//  CreateEventViewController.swift
//  MDBSocials
//
//  Created by Eliot Han on 10/5/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit
import Firebase


class CreateEventViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var eventTitleField: UITextField!
    var eventDescriptonTextField: UITextField!
    var imageView: UIImageView!
    var eventDateTextField: UITextField!
    var imagePicker = UIImagePickerController()
    var eventImageView: UIImageView! = UIImageView(image: UIImage(named: "emptyimage"))
    var actionSheetController : UIAlertController = UIAlertController(title: "Photos", message: "Select Camera or Photo Library", preferredStyle: .actionSheet)

    
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
        view.backgroundColor = Constants.Colors.purpleColor
        
        let postEventButton = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(CreateEventViewController.postButtonClicked))
        self.navigationItem.rightBarButtonItem = postEventButton
        
        eventTitleField = UITextField(frame: CGRect(x: 20, y: (self.navigationController?.navigationBar.frame.height)! + 20, width: view.frame.width - 20, height: 50))
        eventTitleField.placeholder = "What is the title of your event?"
        view.addSubview(eventTitleField)
        
        eventDescriptonTextField = UITextField(frame: CGRect(x: 20, y: eventTitleField.frame.maxY + 25, width: view.frame.width - 20, height: 50))
        eventDescriptonTextField.placeholder = "Describe your event."
        view.addSubview(eventDescriptonTextField)
        

        eventDateTextField = UITextField(frame: CGRect(x: 20, y: eventDescriptonTextField.frame.maxY + 25, width: view.frame.width-40, height: 50))
        eventDateTextField.placeholder = "Date"
        view.addSubview(eventDateTextField)
        
        eventImageView.frame = CGRect(x: 20, y: eventDateTextField.frame.maxY + 20, width: view.frame.width - 40, height: 320)
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
                print("Button capture")
                
                
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
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    
    func postButtonClicked(){
        performSegue(withIdentifier: "unwindToFeedVC", sender: self)
    }
}
