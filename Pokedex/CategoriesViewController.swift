//
//  CategoriesViewController.swift
//  Pokedex
//
//  Created by Kevin Jiang on 9/28/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    var filteredPokemon: [Pokemon] = []
    var selectedTypes: [String] = []
    var pokeArray = PokemonGenerator.getPokemonArray()
    let minAttackLabel = UITextField(frame: CGRect(x: 25, y: 500, width: 200, height: 40))
    let minDefenseLabel = UITextField(frame: CGRect(x: 25, y: 550, width: 200, height: 40))
    let minHPLabel = UITextField(frame: CGRect(x: 25, y: 600, width: 200, height: 40))
    let minAttackField = UITextField(frame: CGRect(x: 225, y: 500, width: 30, height: 40))
    let minDefenseField = UITextField(frame: CGRect(x: 225, y: 550, width: 30, height: 40))
    let minHPField = UITextField(frame: CGRect(x: 225, y: 600, width: 30, height: 50))
    
    let bug = UIColor(red: 112/255, green: 161/255, blue: 56/255, alpha: 1.0)
    let dragon = UIColor(red: 182/255, green: 41/255, blue: 240/255, alpha: 1.0)
    let fairy = UIColor(red: 253/255, green: 183/255, blue: 233/255, alpha: 1.0)
    let fire = UIColor(red: 255/255, green: 126/255, blue: 7/255, alpha: 1.0)
    let ghost = UIColor(red: 122/255, green: 97/255, blue: 163/255, alpha: 1.0)
    let ground = UIColor(red: 248/255, green: 222/255, blue: 36/255, alpha: 1.0)
    let normal = UIColor(red: 163/255, green: 171/255, blue: 173/255, alpha: 1.0)
    let psychic = UIColor(red: 245/255, green: 98/255, blue: 186/255, alpha: 1.0)
    let steel = UIColor(red: 158/255, green: 182/255, blue: 184/255, alpha: 1.0)
    let dark = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
    let electric = UIColor(red: 237/255, green: 215/255, blue: 16/255, alpha: 1.0)
    let fighting = UIColor(red: 215/255, green: 103/255, blue: 17/255, alpha: 1.0)
    let flying = UIColor(red: 134/255, green: 175/255, blue: 213/255, alpha: 1.0)
    let grass = UIColor(red: 154/255, green: 205/255, blue: 76/255, alpha: 1.0)
    let ice = UIColor(red: 75/255, green: 195/255, blue: 231/255, alpha: 1.0)
    let poison = UIColor(red: 186/255, green: 123/255, blue: 202/255, alpha: 1.0)
    let rock = UIColor(red: 165/255, green: 140/255, blue: 12/255, alpha: 1.0)
    let water = UIColor(red: 64/255, green: 145/255, blue: 198/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 80, height: 40)
        let collectionView = UICollectionView(frame: CGRect(x: 25, y: 175, width: 250, height: 250), collectionViewLayout: layout)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: "categoryCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        
        minAttackLabel.text = "Set minimum attack"
        
        minDefenseLabel.text = "Set defense attack"
        
        minHPLabel.text = "Set HP attack"
        
        minAttackField.placeholder = "0"
        
        minDefenseField.placeholder = "0"
        
        minHPField.placeholder = "0"
        
        let searchButton = UIButton(frame: CGRect(x: 250, y: 550, width: 80, height: 50))
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(UIColor.blue, for: .normal)
        searchButton.addTarget(self, action: #selector(self.sendToRandom), for: .touchUpInside)
        
        view.addSubview(collectionView)
        view.addSubview(minAttackLabel)
        view.addSubview(minDefenseLabel)
        view.addSubview(minHPLabel)
        view.addSubview(minAttackField)
        view.addSubview(minDefenseField)
        view.addSubview(minHPField)
        view.addSubview(searchButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendToRandom() {
        if minAttackField.text == "" {
            minAttackField.text = "0"
        }
        
        if minDefenseField.text == "" {
            minDefenseField.text = "0"
        }
        
        if minHPField.text == "" {
            minHPField.text = "0"
        }
        
        filteredPokemon = filterPokemon()
    
        performSegue(withIdentifier: "alsoToRandom", sender: self)
    }
    
    func filterPokemon () -> [Pokemon] {
        var filtered: [Pokemon] = []
        for pokemon in pokeArray {
            if pokemon.attack >= Int(minAttackField.text!)!
                && pokemon.health >= Int(minHPField.text!)!
                && pokemon.defense >= Int(minDefenseField.text!)! {
                for type in pokemon.types {
                    if selectedTypes.contains(type) && !filtered.contains(pokemon)  {
                        filtered.append(pokemon)
                    }
                }
                
                if selectedTypes.count == 0 {
                    filtered.append(pokemon)
                }
            }
        }
        
        return filtered
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alsoToRandom" {
            if let destination = segue.destination as? RandomViewController {
                destination.pokesToDisplay = filteredPokemon
            }
        }
    }
}

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! ButtonCell
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let foodCell = cell as! ButtonCell
        if indexPath.item == 0 {
            foodCell.button.backgroundColor = fire
            foodCell.button.setTitle("Fire", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 1 {
            foodCell.button.backgroundColor = fighting
            foodCell.button.setTitle("Fighting", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 2 {
            foodCell.button.backgroundColor = rock
            foodCell.button.setTitle("Rock", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 3 {
            foodCell.button.backgroundColor = ground
            foodCell.button.setTitle("Electric", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 4 {
            foodCell.button.backgroundColor = electric
            foodCell.button.setTitle("Ground", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 5 {
            foodCell.button.backgroundColor = grass
            foodCell.button.setTitle("Bug", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 6 {
            foodCell.button.backgroundColor = bug
            foodCell.button.setTitle("Grass", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 7 {
            foodCell.button.backgroundColor = ice
            foodCell.button.setTitle("Ice", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 8 {
            foodCell.button.backgroundColor = water
            foodCell.button.setTitle("Water", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 9 {
            foodCell.button.backgroundColor = poison
            foodCell.button.setTitle("Poison", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 10 {
            foodCell.button.backgroundColor = ghost
            foodCell.button.setTitle("Ghost", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 11 {
            foodCell.button.backgroundColor = dark
            foodCell.button.setTitle("Dark", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 12 {
            foodCell.button.backgroundColor = fairy
            foodCell.button.setTitle("Fairy", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 13 {
            foodCell.button.backgroundColor = psychic
            foodCell.button.setTitle("Psychic", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 14 {
            foodCell.button.backgroundColor = dragon
            foodCell.button.setTitle("Dragon", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 15 {
            foodCell.button.backgroundColor = steel
            foodCell.button.setTitle("Steel", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 16 {
            foodCell.button.backgroundColor = normal
            foodCell.button.setTitle("Normal", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        } else if indexPath.item == 17 {
            foodCell.button.backgroundColor = flying
            foodCell.button.setTitle("Flying", for: .normal)
            foodCell.button.addTarget(self, action: #selector(self.changeBorder), for: .touchUpInside)
        }
    }
    
    func changeBorder(sender: UIButton) {
        if sender.layer.borderWidth == 3 {
            sender.layer.borderWidth = 0
            selectedTypes.remove(at: selectedTypes.index(of: sender.title(for: .normal)!)!)
        } else if sender.layer.borderWidth == 0 {
            selectedTypes.append(sender.title(for: .normal)!)
            sender.layer.borderWidth = 3
            sender.layer.borderColor = UIColor.yellow.cgColor
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    //Sets the size of the cell
    
}
