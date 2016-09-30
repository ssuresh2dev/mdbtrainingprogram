//
//  DetailsViewController.swift
//  Pokedex
//
//  Created by Candice Ye on 9/28/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

// Random for the time being.
let pokemonArray = PokemonGenerator.getPokemonArray()
let randomIndex = Int(arc4random_uniform(UInt32(pokemonArray.count)))
var selectedPokemon = pokemonArray[randomIndex]

class DetailsViewController: UIViewController {

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
        
        
        // Profile Image: pokemonProfile
        let pokemonProfile = UIImageView()
        pokemonProfile.frame = CGRect(x: UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height/8, width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.width/1.5)
        pokemonProfile.backgroundColor = UIColor.gray
        self.view.addSubview(pokemonProfile)
        
        // Add to Favorites Button
        let addFavorites = UIButton()
        addFavorites.frame = CGRect(x: UIScreen.main.bounds.width - UIScreen.main.bounds.width/3, y: UIScreen.main.bounds.height/1.9, width: 60, height: 18)
        addFavorites.backgroundColor = UIColor.gray
        addFavorites.tintColor = UIColor.white
        addFavorites.setTitle("Favorite!", for: .normal)
        addFavorites.titleLabel!.font = UIFont(name: "Helvetica", size: 10)
        self.view.addSubview(addFavorites)
        
        // Profile Name
        let pokemonProfileName = UILabel()
        pokemonProfileName.frame = CGRect(x: UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height/2.1, width: 450, height: 80)
        pokemonProfileName.text = "\(selectedPokemon.name!)"
        pokemonProfileName.textColor = UIColor.black
        pokemonProfileName.font = pokemonProfileName.font.withSize(22)
        self.view.addSubview(pokemonProfileName)
        
        
        // Pokemon Description (Other info)
        let pokemonDescription = UILabel()
        pokemonDescription.frame = CGRect(x: UIScreen.main.bounds.width/5.5, y: UIScreen.main.bounds.height/1.9, width: 450, height: 80)
        pokemonDescription.text = "#\(selectedPokemon.number!) | \(selectedPokemon.species!) | \(selectedPokemon.total!)"
        pokemonDescription.textColor = UIColor.gray
        pokemonDescription.font = pokemonDescription.font.withSize(13)
        pokemonDescription.textRect(forBounds: UIScreen.main.bounds, limitedToNumberOfLines: 3)
        self.view.addSubview(pokemonDescription)
        
        // Pokemon Type
        let pokemonType = UILabel()
        pokemonType.frame = CGRect(x: UIScreen.main.bounds.width/5.5, y: UIScreen.main.bounds.height/1.8, width: 450, height: 80)
        
        pokemonType.text = "Type: \(selectedPokemon.types)".replacingOccurrences(of: "\"", with: " ")
        pokemonType.textColor = UIColor.gray
        pokemonType.font = pokemonType.font.withSize(13)
        self.view.addSubview(pokemonType)
        
        // HP Stats
        let pokemonHP = UILabel()
        pokemonHP.frame = CGRect(x: UIScreen.main.bounds.width/5.5, y: UIScreen.main.bounds.height/1.6, width: 300, height: 80)
        pokemonHP.text = "HP: \(selectedPokemon.health!) | Speed: \(selectedPokemon.speed!)"
        pokemonHP.textColor = UIColor.gray
        pokemonHP.font = pokemonHP.font.withSize(13)
        self.view.addSubview(pokemonHP)
        
        // Attack Stats
        let pokemonAttack = UILabel()
        pokemonAttack.frame = CGRect(x: UIScreen.main.bounds.width/5.5, y: UIScreen.main.bounds.height/1.5, width: 300, height: 80)
        pokemonAttack.text = "Attack: \(selectedPokemon.attack!) | Special Attack: \(selectedPokemon.specialAttack!)"
        pokemonAttack.textColor = UIColor.gray
        pokemonAttack.font = pokemonAttack.font.withSize(13)
        self.view.addSubview(pokemonAttack)
        
        
        // Defense Stats
        let pokemonDefense = UILabel()
        pokemonDefense.frame = CGRect(x: UIScreen.main.bounds.width/5.5, y: UIScreen.main.bounds.height/1.4, width: 300, height: 80)
        pokemonDefense.text = "Defense: \(selectedPokemon.defense!) | Special Defense: \(selectedPokemon.specialDefense!)"
        pokemonDefense.textColor = UIColor.gray
        pokemonDefense.font = pokemonDefense.font.withSize(13)
        self.view.addSubview(pokemonDefense)
        
        
        // Search On Web Button
        let searchButton = UIButton()
        searchButton.frame = CGRect(x: UIScreen.main.bounds.width/5.5, y: UIScreen.main.bounds.height/1.25, width: 250, height: 30)
        searchButton.backgroundColor = UIColor.gray
        searchButton.tintColor = UIColor.white
        searchButton.setTitle("Search On Web?", for: .normal)
        searchButton.addTarget(self, action: Selector(("Action:")), for: .touchUpInside)
        
        self.view.addSubview(searchButton)
        
        
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Actions
    
    func searchButtonPressed(sender: UIButton!) {
        let googleSearch: UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        googleSearch.loadRequest(NSURLRequest(url: NSURL(string: "https://google.com/search?q=POKEMONNAME") as! URL) as URLRequest)
        self.view.addSubview(googleSearch.delegate as! UIView)
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
