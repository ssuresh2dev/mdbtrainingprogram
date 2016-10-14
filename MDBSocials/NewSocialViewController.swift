//
//  NewSocialViewController.swift
//  MDBSocials
//
//  Created by Jessica Chen on 10/2/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit


class NewSocialViewController: UIViewController {
    var nameTF: UITextField!
    var pic: UILabel!
    var img: UIImageView!
    var picUpload: UIButton!
    var desc: UITextField!
    var date: UITextField!
    
    override func viewDidLoad() {
        setUI()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        let margin = view.frame.width/8
        let marginBF = view.frame.width/10
        //nameLabel setup
        nameTF = UITextField(frame: CGRect(x: margin, y: view.frame.height/5, width: view.frame.width-2*margin, height: view.frame.width/8))
        nameTF.placeholder = "Event Name"
        picUpload = UIButton(frame: CGRect(x: margin, y: view.frame.height/5 + view.frame.width/8, width: view.frame.width/4, height: view.frame.width/4))
        picUpload.setBackgroundImage(UIImage(named: "uploadimg"), for: .normal)
        
        desc = UITextField(frame: CGRect(x: margin, y: view.frame.height/5 + view.frame.width/8 + 2*marginBF, width: view.frame.width-2*margin, height: view.frame.height/5))
        desc.placeholder = "Event description"
        
        date = UITextField(frame: CGRect(x: view.frame.width/2, y: view.frame.height/5 + view.frame.width/8 + 2*marginBF, width: view.frame.width-2*margin, height: view.frame.height/5))
        
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
