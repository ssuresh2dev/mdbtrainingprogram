//
//  StartViewController.swift
//  MDB Project 1
//
//  Created by Eliot Han on 9/19/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    var g = 1
    //g keeps track of button
    
    var isPlaying = false
    //isPlaying keeps track of delay function: whether or not user is playing or not
    
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    var timer = Timer()
    @IBOutlet weak var score: UITextField!
    var scoreInt = 0
    @IBOutlet weak var image: UIImageView!
    //Creates buttons, timer, score, and image placeholder
    
    let names: [String] = ["JessicaCherny", "MansiShah", "AliceWang", "JessicaJi", "KevinJiang", "JaredGutierrez", "KristinHo", "ChristineMunar", "MuditMittal", "AliShelton", "RichardHu", "ShaanAppel", "AnkurMahesh", "EdwardLiu", "WilburShi", "YoungLin", "AbhinavKoppu", "AbhishekMangla",  "AkkshayKhoslaa", "AllyKoo", "AndyWang", "AneeshJindal", "AnishaSalunkhe", "AparnaKrishnan", "AshwinVaidyanathan", "CodyHsieh", "ConnorKillion", "JeffreyZhang", "JustinKim", "KennethSteele", "KrishnanRajiyah", "LisaLee", "PeterSchafhalter", "RileyEdmunds", "RohanNarayan", "SahilLamba", "SameerSuresh", "SonaJeswani", "SirjanKafle", "TarunKhasnavis", "VirindhBorra", "BillyLu", "AayushTyagi", "BenGoldberg", "CandiceYe", "EliotHan", "EmaanHariri", "JessicaChen", "KatharineJiang", "KedarThakkar", "LeonKwak", "MohitKatyal", "RochelleShen", "SayanPaul", "SharieWang", "ShreyaReddy", "ShubhamGoenka", "VictorSun", "VidyaRavikumar"]
    
    var chosenName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.setTitle("Start", for: UIControlState.normal)
        //image.isHidden = true
        choice1.isHidden = true
        choice2.isHidden = true
        choice3.isHidden = true
        choice4.isHidden = true
        
        self.image.image = UIImage(named: "press start")

    //Creates load screen

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonPress(_ sender: AnyObject) {
        //Start
        if g == 1{
            g = 2
            //image.isHidden = false
            startButton.setTitle("End", for: UIControlState.normal)
            isPlaying = true
            play()
            
        
        
        }
        //Stop
        else{
            g = 1
            isPlaying = false
            //image.isHidden = true
            startButton.setTitle("Start",for: UIControlState.normal)
            choice1.isHidden = true
            choice2.isHidden = true
            choice3.isHidden = true
            choice4.isHidden = true
            self.viewDidLoad()
        }
    }
    //Creates original gameplay screen
    func setup(){
        self.image.isHidden = false
        choice1.isHidden = false
        choice2.isHidden = false
        choice3.isHidden = false
        choice4.isHidden = false
        choice1.setTitle("Button", for: UIControlState.normal)
        choice2.setTitle("Button", for: UIControlState.normal)
        choice3.setTitle("Button", for: UIControlState.normal)
        choice4.setTitle("Button", for: UIControlState.normal)
        self.choice1.backgroundColor = UIColor.clear
        self.choice2.backgroundColor = UIColor.clear
        self.choice3.backgroundColor = UIColor.clear
        self.choice4.backgroundColor = UIColor.clear
        self.choice1.isUserInteractionEnabled = true
        self.choice2.isUserInteractionEnabled = true
        self.choice3.isUserInteractionEnabled = true
        self.choice4.isUserInteractionEnabled = true

    }
    
    func timeEnded(){
        self.timer.invalidate()
        if self.isPlaying{
            self.play()
        }
    }
    func play(){
        setup()
        //timer
    
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timeEnded), userInfo: nil, repeats: true)
        
        
        
        
        //random image
        let rand = Int(arc4random_uniform(UInt32(names.count)))
        chosenName = names[rand]
        print(chosenName)
        self.image.image = UIImage(named: chosenName)
        
        //random answer choices
        
        let random = Int(arc4random_uniform(UInt32(4)))
        if random == 1{
            choice1.setTitle(chosenName,for: UIControlState.normal)
        }  else if random == 2{
            choice2.setTitle(chosenName,for: UIControlState.normal)
        }  else if random == 3{
            choice3.setTitle(chosenName,for: UIControlState.normal)
        }  else{
            choice4.setTitle(chosenName,for: UIControlState.normal)
        }
        
        //creates titles
        let title1 = generateButtonTitle(button: choice1)
        let title2 = generateButtonTitle(button: choice2)
        let title3 = generateButtonTitle(button: choice3)
        let title4 = generateButtonTitle(button: choice4)
        
        //sets titles
        if title1 != nil && choice1.currentTitle == "Button"{
            choice1.setTitle(title1, for: UIControlState.normal)
        }
        if title2 != nil && choice2.currentTitle == "Button"{
            choice2.setTitle(title2, for: UIControlState.normal)
        }
        if title3 != nil && choice3.currentTitle == "Button"{
            choice3.setTitle(title3, for: UIControlState.normal)
        }
        if title4 != nil && choice4.currentTitle == "Button"{
            choice4.setTitle(title4, for: UIControlState.normal)
        }
        


    }
    //Sets the other buttons random names that aren't correct
    func generateButtonTitle(button: UIButton) -> String?{
        var buttonName: String?
        if button.currentTitle == "Button"{
            repeat{
                let random = Int(arc4random_uniform(UInt32(names.count)))
                buttonName = names[random]
            }while(buttonName == chosenName)
            return buttonName
        }else{
            return nil
        }
    }
    
    //Sets button to green if correct and increases score, red if incorrect, resets button
    
    @IBAction func chose1(_ sender: AnyObject) {
        self.choice2.isUserInteractionEnabled = false
        self.choice3.isUserInteractionEnabled = false
        self.choice4.isUserInteractionEnabled = false

        if self.choice1.currentTitle == self.chosenName{
            self.choice1.backgroundColor = UIColor.green
            self.scoreInt += 1
            self.score.text = "Score: \(scoreInt)"
        }else{
            self.choice1.backgroundColor = UIColor.red
        }
        delay(1){
        self.choice1.backgroundColor = UIColor.clear
        self.timeEnded()
        }
        
        
    }

    @IBAction func chose2(_ sender: AnyObject) {
        self.choice1.isUserInteractionEnabled = false
        self.choice3.isUserInteractionEnabled = false
        self.choice4.isUserInteractionEnabled = false
        if self.choice2.currentTitle == self.chosenName{
            self.choice2.backgroundColor = UIColor.green
            self.scoreInt += 1
            self.score.text = "Score: \(scoreInt)"
        }else{
            self.choice2.backgroundColor = UIColor.red
        }
        delay(1){
            self.choice2.backgroundColor = UIColor.clear
            self.timeEnded()
        }

    }
    @IBAction func chose3(_ sender: AnyObject) {
        self.choice2.isUserInteractionEnabled = false
        self.choice1.isUserInteractionEnabled = false
        self.choice4.isUserInteractionEnabled = false
        if self.choice3.currentTitle == self.chosenName{
            self.choice3.backgroundColor = UIColor.green
            self.scoreInt += 1
            self.score.text = "Score: \(scoreInt)"
        }else{
            self.choice3.backgroundColor = UIColor.red
        }
        delay(1){
            self.choice3.backgroundColor = UIColor.clear
            self.timeEnded()
        }
     

    }
    @IBAction func chose4(_ sender: AnyObject) {
        self.choice2.isUserInteractionEnabled = false
        self.choice3.isUserInteractionEnabled = false
        self.choice1.isUserInteractionEnabled = false
        if self.choice4.currentTitle == self.chosenName{
            self.choice4.backgroundColor = UIColor.green
            self.scoreInt += 1
            self.score.text = "Score: \(scoreInt)"
        }else{
            self.choice4.backgroundColor = UIColor.red
        }
        delay(1){
            self.choice4.backgroundColor = UIColor.clear
            self.timeEnded()
            }

        }

    //delay function 
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}

