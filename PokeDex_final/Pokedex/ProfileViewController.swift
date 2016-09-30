//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Jessica Chen on 9/26/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var pokemon: Pokemon!
    var faves: [Pokemon] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUI()
        // Do any additional setup after loading the view.
    }
    
    
    
    func setUI(){
        let imageView = UIImageView(frame: CGRect(x: (view.frame.width)*0.25, y: view.frame.height/4, width: (view.frame.width)/2 , height: view.frame.height / 4))
        imageView.contentMode = .scaleAspectFill
        try! imageView.image = UIImage(data: Data(contentsOf: URL(string: pokemon.imageUrl)!))
//        catch{
//            imageView.image = nil
//        }
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        let descriptionView = DescriptionView (frame: CGRect(x: 0, y: view.frame.height * 0.4 + 10, width: (view.frame.width) , height: view.frame.height * 0.6 - 20), name: pokemon.name, number: String(pokemon.number), attack: String(pokemon.attack), defense: String(pokemon.defense), health: String(pokemon.health), specialAttack: String(pokemon.specialAttack), specialDefense: String(pokemon.specialDefense), species: pokemon.species, speed: String(pokemon.speed), total: String(pokemon.total), types: pokemon.types.joined(separator: ", "))
        
        view.addSubview(descriptionView)
        
        // Create button to go to favorites
        let fave = UIButton(frame: CGRect(x: view.frame.width/4, y: view.frame.height-view.frame.width/6, width: view.frame.width/2, height: view.frame.width/8))
        fave.addTarget(self, action: #selector(faveClicked), for: UIControlEvents.touchUpInside)
        fave.setTitle("Favorite 💖 ", for: .normal)
        fave.layer.cornerRadius = 20
        fave.backgroundColor = UIColor.green
        view.addSubview(fave)
        navigationItem.leftBarButtonItem?.tintColor =  UIColor.white
        navigationItem.title = pokemon.name
        
        let searchWeb = UIButton(frame: CGRect(x: view.frame.width/4, y: view.frame.height-view.frame.width/3, width: view.frame.width/2, height: view.frame.width/8))
        searchWeb.layer.cornerRadius = 20
        searchWeb.backgroundColor = UIColor.green
        searchWeb.addTarget(self, action: #selector(searchTheWeb), for: UIControlEvents.touchUpInside)
        searchWeb.setTitle("Search the web", for: .normal)
        view.addSubview(searchWeb)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(navBack))
        
        
    }
    func searchTheWeb(sender: UIButton){
//        let website = URL(string: "https://mail.google.com/mail/u/1/#inbox")
        let website = URL(string: "https://google.com/search?q=" + String(pokemon.name))
        if website != nil {
            UIApplication.shared.open(website!)
        }
    }
    func faveClicked(sender: UIButton){
        print(faves)
        var i: Int = 0
        while(i < faves.count){
            if (faves[i].name == self.pokemon.name) {
                faves.remove(at: i)
                sender.alpha = 1.0
                return
            }
            i+=1
        }
        sender.alpha = 0.5
        faves.append(pokemon)
    }
    
    func navBack(sender: UIBarButtonItem){
         performSegue(withIdentifier: "backSegue", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class DescriptionView: UIView {
        
        var name: String!
        var number: String!
        var attack: String!
        var defense: String!
        var health: String!
        var specialAttack: String!
        var specialDefense: String!
        var species: String!
        var speed: String!
        var total: String!
        var types: String!
        
        
        init(frame: CGRect, name: String, number: String, attack: String, defense: String, health: String, specialAttack: String, specialDefense: String, species: String, speed: String, total: String, types: String)
        {
            super.init(frame: frame)
            self.name = name
            self.number = number
            self.attack = attack
            self.defense = defense
            self.health = health
            self.specialAttack = specialAttack
            self.specialDefense = specialDefense
            self.species = species
            self.speed = speed
            self.total = total
            self.types = types
            setLayout()
        }
        
        required init(coder aDecoder: NSCoder)
        {
            fatalError("init(coder) had not been identified")
        }
        
        func setLayout(){
            
            let numberLabel = UILabel(frame: CGRect(x: 20, y: 70, width: 400, height: 30))
            numberLabel.text = "Number: \(number!)"
            numberLabel.font = UIFont(name: "SFUIText-Light" , size: 12.0)
            addSubview(numberLabel)
            
            let attackLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 400, height: 30))
            attackLabel.text = "Attack: \(attack!)"
            attackLabel.font = UIFont(name: "SFUIText-Light" , size: 12.0)
            addSubview(attackLabel)
            
            let defenseLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 400, height: 30))
            defenseLabel.text = "Defense: \(defense!)"
            defenseLabel.font = UIFont(name: "SFUIText-Light" , size: 12.0)
            addSubview(defenseLabel)
            
            let healthLabel = UILabel(frame: CGRect(x: 20, y: 160 , width: 400, height: 30))
            healthLabel.text = "Health: \(health!)"
            healthLabel.font = UIFont(name: "SFUIText-Light" , size: 12.0)
            addSubview(healthLabel)
            
            let specialAttackLabel = UILabel(frame: CGRect(x: 20, y: 190, width: 400, height: 30))
            specialAttackLabel.text = "Special Attk: \(specialAttack!)"
            specialAttackLabel.font = UIFont(name: "SFUIText-Light" , size: 12.0)
            addSubview(specialAttackLabel)
            
            let specialDefenseLabel = UILabel(frame: CGRect(x: 160, y: 70, width: 400, height: 30))
            specialDefenseLabel.text = "Special Defense: \(specialDefense!)"
            specialDefenseLabel.font = UIFont(name: "SFUIText-Light" , size: 12.0)
            addSubview(specialDefenseLabel)
            
            let speciesLabel = UILabel(frame: CGRect(x: 160, y: 100, width: 400, height: 30))
            speciesLabel.text = "Species: \(species!)"
            speciesLabel.font = UIFont(name: "SFUIText-Light" , size: 12.0)
            addSubview(speciesLabel)
            
            let speedLabel = UILabel(frame: CGRect(x: 160, y: 130, width: 400, height: 30))
            speedLabel.text = "Speed: \(speed!)"
            speedLabel.font = UIFont(name: "SFUIText-Light" , size: 12.0)
            addSubview(speedLabel)
            
            let totalLabel = UILabel(frame: CGRect(x: 160, y: 160, width: 400, height: 30))
            totalLabel.text = "Total: \(total!)"
            totalLabel.font = UIFont(name: "SFUIText-Light" , size: 12.0)
            addSubview(totalLabel)
            
            let typesLabel = UILabel(frame: CGRect(x: 160, y: 190, width: 400, height: 30))
            typesLabel.text = "Types: \(types!)"
            typesLabel.font = UIFont(name: "SFUIText-Light" , size: 12.0)
            addSubview(typesLabel)
        }
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backSegue"){
            let VC = segue.destination as! ListViewController
            VC.favorites = self.faves
        }
    }
 

}
