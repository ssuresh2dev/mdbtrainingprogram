//
//  ViewController.swift
//  Pokedex
//
//  Created by Kevin Jiang on 9/28/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

struct Global {
    static var favPokes: [Pokemon] = []
}

class MainViewController: UIViewController{
    
    let pokeArray = PokemonGenerator.getPokemonArray()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let categoryButton = UIButton(frame: CGRect(x: 100, y: 100, width: 250, height: 50)) //need to center
        categoryButton.addTarget(self, action: #selector(self.categorySegue), for: .touchUpInside)
        categoryButton.backgroundColor = UIColor.red
        categoryButton.setTitle("Search by category", for: .normal)
        
        let byNameButton = UIButton(frame: CGRect(x: 100, y: 200, width: 250, height: 50)) //need to center
        byNameButton.addTarget(self, action: #selector(self.toNameSegue), for: .touchUpInside)
        byNameButton.setTitle("Search by name/number", for: .normal)
        byNameButton.backgroundColor = UIColor.red
        
        let randomButton = UIButton(frame: CGRect(x: 100, y: 300, width: 250, height: 50)) //need to center
        randomButton.addTarget(self, action: #selector(self.toRandomSegue), for: .touchUpInside)
        randomButton.setTitle("Generate random list of Pokemon", for: .normal)
        randomButton.backgroundColor = UIColor.red
        
        let testImage = UIImageView(frame: CGRect(x: 50, y: 400, width: 50, height: 50))
        
        if let url = NSURL(string: pokeArray[1].imageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                testImage.image = UIImage(data: data as Data)
            }        
        }
        
        testImage.layer.borderColor = UIColor.black.cgColor
        testImage.layer.borderWidth = 2
        
        view.addSubview(testImage)
        
        view.addSubview(categoryButton)
        view.addSubview(byNameButton)
        view.addSubview(randomButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func categorySegue() {
        printFavs()
        performSegue(withIdentifier: "toCategories", sender: self)
    }
    
    func printFavs() {
        print(Global.favPokes.count)
        for pokemon in Global.favPokes {
            print(pokemon.name)
        }
    }
    
    func toNameSegue() {
        performSegue(withIdentifier: "toNameSearch", sender: self)
    }
    
    func toRandomSegue() {
        performSegue(withIdentifier: "toRandom", sender: self)
    }
    
    func generateRandomPokemon() -> [Pokemon] {
        var randomPokeArray: [Pokemon] = []
        
        while randomPokeArray.count < 20 {
            let index: Int = Int(arc4random_uniform(UInt32(pokeArray.count)))
            if (!randomPokeArray.contains(pokeArray[index])) {
                randomPokeArray.append(pokeArray[index])
            }
        }
        return randomPokeArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCategories" {
            
        } else if segue.identifier == "toNameSearch" {
            
        } else if segue.identifier == "toRandom" {
            if let destination = segue.destination as? RandomViewController {
                destination.pokesToDisplay = generateRandomPokemon()
            }
        }
    }


}

