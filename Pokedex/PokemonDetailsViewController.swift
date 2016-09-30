//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Vidya Ravikumar on 9/28/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    var pokemon : Pokemon!
    var name : UILabel!
    var num: UILabel!
    var attackLabel : UILabel!
    var defense : UILabel!
    var health : UILabel!
    var specialAttack : UILabel!
    var specialDefense : UILabel!
    var species : UILabel!
    var speed : UILabel!
    var total : UILabel!
    var types : UILabel!
    var image : UIImageView!
    var favorites : [Pokemon]! = []
    var pokeball : UIButton!
    var searchWebButton : UIButton!
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image = UIImageView(frame: CGRect(x: view.frame.width * 0.05, y: 70, width: view.frame.width * 0.9, height: view.frame.height * 0.5))
        try! image.image = UIImage(data: Data(contentsOf: URL(string: pokemon.imageUrl)!))
        image.contentMode = .scaleAspectFit
        view.addSubview(image)
        
        name = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.64, width: view.frame.width, height: 20))
        name.text = String(pokemon.name!)!
        name.textAlignment = .center
        view.addSubview(name)
        
        num = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.67, width: view.frame.width, height: 20))
        num.text = "#:" + String(pokemon.number!)
        num.textAlignment = .center
        view.addSubview(num)
        
        attackLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.7, width: view.frame.width, height: 20))
        attackLabel.text = "Attack: " + String(pokemon.attack)
        attackLabel.textAlignment = .center
        view.addSubview(attackLabel)
        
        defense = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.73, width: view.frame.width, height: 20))
        defense.text = "Defense: " + String(pokemon.defense)
        defense.textAlignment = .center
        view.addSubview(defense)
        
        health = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.76, width: view.frame.width, height: 20))
        health.text = "Health: " + String(pokemon.health)
        health.textAlignment = .center
        view.addSubview(health)
        
        specialAttack = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.79, width: view.frame.width, height: 20))
        specialAttack.text = "Special Attack: " + String(pokemon.specialAttack)
        specialAttack.textAlignment = .center
        view.addSubview(specialAttack)
        
        specialDefense = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.82, width: view.frame.width, height: 20))
        specialDefense.text = "Special Defense: " + String(pokemon.specialDefense)
        specialDefense.textAlignment = .center
        view.addSubview(specialDefense)
        
        species = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.85, width: view.frame.width, height: 20))
        species.text = "Species: " + String(pokemon.species)
        species.textAlignment = .center
        view.addSubview(species)
        
        speed = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.88, width: view.frame.width, height: 20))
        speed.text = "Speed: " + String(pokemon.speed)
        speed.textAlignment = .center
        view.addSubview(speed)
        
        total = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.91, width: view.frame.width, height: 20))
        total.text = "Total: " + String(pokemon.total)
        total.textAlignment = .center
        view.addSubview(total)
        
        types = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.94, width: view.frame.width, height: 20))
        types.text = "Types: " + String(describing: pokemon.types)
        types.textAlignment = .center
        view.addSubview(types)
        
        pokeball = UIButton(frame: CGRect(x: view.frame.width * 0.9, y: 70, width: view.frame.width * 0.1, height: view.frame.width * 0.1))
        pokeball.setImage(#imageLiteral(resourceName: "bwPokeBall"), for: .normal)
        pokeball.addTarget(self, action: #selector(addToOrDeleteFromFavorites), for: .touchUpInside)
        view.addSubview(pokeball)
        
        searchWebButton = UIButton(frame: CGRect(x: view.frame.width * 0.8, y: view.frame.height * 0.9 - 5, width: view.frame.width * 0.15, height: view.frame.height * 0.075))
        searchWebButton.setImage(#imageLiteral(resourceName: "searchWebButtonImage"), for: .normal)
        searchWebButton.addTarget(self, action: #selector(search), for: .touchUpInside)
        view.addSubview(searchWebButton)
        
        // Do any additional setup after loading the view.
    }

    func search() {
        performSegue(withIdentifier: "toWeb", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! WebSearchViewController
        next.poke = pokemon
    }
    
    func addToOrDeleteFromFavorites() {
        if pokeball.imageView?.image == #imageLiteral(resourceName: "bwPokeBall") {
            pokeball.setImage(#imageLiteral(resourceName: "colorPokeBall"), for: .normal)
            defaults.set(pokemon, forKey: "p")
        } else {
            pokeball.setImage(#imageLiteral(resourceName: "bwPokeBall"), for: .normal)
            //need to delete favorite
        }
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
