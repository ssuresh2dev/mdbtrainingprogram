//
//  NewSocialViewController.swift
//  MDBSocials
//
//  Created by Jessica Chen on 10/2/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit
import Firebase


class NewSocialViewController: UIViewController {
    var nameTF: UITextField!
    var pic: UILabel!
    var img: UIImageView!
    var picUpload: UIButton!
    var desc: UITextField!
    var date: UITextField!
    var time: UITextField!
    var addButton: UIButton!
    

    
    override func viewDidLoad() {
        setUI()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func uploadImage(){
        
    }
    func newSocial(){
        let social: [String: String] = ["name": nameTF.text!, "date": date.text!, "time" : time.text!, "description": desc.text!, "numRSVPs": "0"]
        let ref = FIRDatabase.database().reference()
        ref.child("events").childByAutoId().setValue(social)
    }
    func setUI(){
        addButton = UIButton(frame: CGRect(x:view.frame.width - view.frame.width/4, y: 0, width: view.frame.width/4, height: view.frame.height/10))
        addButton.setTitle("Done", for: .normal)
        addButton.backgroundColor = UIColor.green
        addButton.addTarget(self, action: #selector(newSocial), for: .touchUpInside)
        view.addSubview(addButton)
        
        let margin = view.frame.width/8
        //nameLabel setup
        nameTF = UITextField(frame: CGRect(x: margin, y: view.frame.height/5, width: view.frame.width-2*margin, height: view.frame.width/8))
        nameTF.placeholder = "Event Name"
        picUpload = UIButton(frame: CGRect(x: margin, y: view.frame.height/5 + view.frame.width/8, width: view.frame.width/4, height: view.frame.width/4))
        picUpload.setBackgroundImage(UIImage(named: "uploadimg"), for: .normal)
        
        desc = UITextField(frame: CGRect(x: margin, y: view.frame.height/2, width: view.frame.width-2*margin, height: view.frame.height/3))
        desc.placeholder = "Event description"
        desc.borderStyle = .roundedRect
        
        
        date = UITextField(frame: CGRect(x: view.frame.width/2, y: view.frame.height/5 + view.frame.height/20, width: view.frame.width/5, height: view.frame.height/5))
        date.placeholder = "Date"
        
        time = UITextField(frame: CGRect(x: view.frame.width/2, y: view.frame.height/5 + view.frame.height/10, width: view.frame.width/5, height: view.frame.height/5))
        time.placeholder = "Time"
        
        view.addSubview(time)
        view.addSubview(nameTF)
        view.addSubview(picUpload)
        view.addSubview(desc)
        view.addSubview(date)
        
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
