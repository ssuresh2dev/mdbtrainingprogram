//
//  TextFieldViewController.swift
//  Pokedex
//
//  Created by Eliot Han on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class TextFieldViewController: UIViewController {
    var textField: UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }

    func setupTextField(){
        textField = UITextField(frame: CGRect(x: view.frame.width/2 - 80, y: view.frame.height/2, width: 180, height: 50))
        textField?.placeholder = "Enter number here: "
        textField?.isHidden = false
        textField?.keyboardType = UIKeyboardType.numberPad
        view.addSubview(textField!)
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
