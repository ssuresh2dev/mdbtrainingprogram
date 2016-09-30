//
//  ViewController.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let pokeGen = PokemonGenerator.getPokemonArray()
    var pokemon : [Pokemon]! = []
    var nameButton : UIButton!
    var numButton : UIButton!
    var attackButton : UIButton!
    var healthButton : UIButton!
    var defenseButton : UIButton!
    var randomButton : UIButton!
    var collectionView : UICollectionView!
    var selectCategoryLabel : UILabel!
    var searchBar : UITextField!
    var byTypesLabel : UILabel!
    var searchByCategoriesButton : UIButton!
    var searchByTypesButton : UIButton!
    var pressed : UIButton!
    var searchedPokemon : [Pokemon] = []
    var noPokemonToBeSearched : Bool!
    let pokemonTypeNames : [String]! = ["Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Psychic", "Rock", "Steel", "Water"]
    var selectedTypesNames : [String]! = []
    //let pokemonTypeImages = [UIImage(named: "Bug"), UIImage(named: "Dark"), UIImage(named: "Dragon"), UIImage(named: "Electric"), UIImage(named: "Fairy"), UIImage(named: "Fighting"), UIImage(named: "Fire"), UIImage(named: "Flying"), UIImage(named: "Ghost"), UIImage(named: "Grass"), UIImage(named: "Ground"), UIImage(named: "Ice"), UIImage(named: "Normal"), UIImage(named: "Poison"), UIImage(named: "Psychic"), UIImage(named: "Rock"), UIImage(named: "Steel"), UIImage(named: "Water")]
        //[#imageLiteral(resourceName: "Bug"), #imageLiteral(resourceName: "Dark"), #imageLiteral(resourceName: "Dragon"), #imageLiteral(resourceName: "Electric"), #imageLiteral(resourceName: "Fairy"), #imageLiteral(resourceName: "Fighting"), #imageLiteral(resourceName: "Fire"), #imageLiteral(resourceName: "Flying"), #imageLiteral(resourceName: "Ghost"), #imageLiteral(resourceName: "Grass"), #imageLiteral(resourceName: "Ground"), #imageLiteral(resourceName: "Ice"), #imageLiteral(resourceName: "Normal"), #imageLiteral(resourceName: "Poison"), #imageLiteral(resourceName: "Psychic"), #imageLiteral(resourceName: "Rock"), #imageLiteral(resourceName: "Steel"), #imageLiteral(resourceName: "Water")]
    func setUI() {
        navigationController?.navigationBar.topItem?.title = "Pokemon"
        
    }
    
    override func viewDidLoad() {
        for poke in pokeGen {
            if let httpUrl = poke.imageUrl,
                let url = NSURL(string: httpUrl),
                let data = NSData(contentsOf: url as URL),
                let _ = UIImage(data: data as Data)
            {
                pokemon = pokemon + [poke]
            }
        }
        print("done")
        super.viewDidLoad()
        setUI()
        setupCollectionView()
        view.backgroundColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)

        selectCategoryLabel = UILabel(frame: CGRect(x: 0, y: 80, width: view.frame.width, height: view.frame.height * 0.05))
        selectCategoryLabel.text = "Search by:"
        selectCategoryLabel.textAlignment = .center
        view.addSubview(selectCategoryLabel)
        
        nameButton = UIButton(frame: CGRect(x: 20, y: 80 + (view.frame.height * 0.05), width: view.frame.width * 0.40, height: view.frame.height * 0.05))
        nameButton.setTitle("Name", for: UIControlState.normal)
        nameButton.backgroundColor = UIColor.black
        nameButton.titleLabel?.textColor = UIColor.white
        nameButton.layer.cornerRadius = 3
        nameButton.addTarget(self, action: #selector(nameButtonPressed), for: .touchUpInside)
        view.addSubview(nameButton)
        
        
        numButton = UIButton(frame: CGRect(x: 50 + (width: view.frame.width * 0.40), y: 80 + (view.frame.height * 0.05), width: view.frame.width * 0.40, height: view.frame.height * 0.05))
        numButton.setTitle("Number", for: UIControlState.normal)
        numButton.backgroundColor = UIColor.black
        numButton.titleLabel?.textColor = UIColor.white
        numButton.layer.cornerRadius = 3
        numButton.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        view.addSubview(numButton)
        
        attackButton = UIButton(frame: CGRect(x: 20, y: 100 + (view.frame.height * 0.1), width: view.frame.width * 0.40, height: view.frame.height * 0.05))
        attackButton.setTitle("Attack Points", for: UIControlState.normal)
        attackButton.backgroundColor = UIColor.black
        attackButton.titleLabel?.textColor = UIColor.white
        attackButton.layer.cornerRadius = 3
        attackButton.addTarget(self, action: #selector(attackButtonPressed), for: .touchUpInside)
        view.addSubview(attackButton)
        
        healthButton = UIButton(frame: CGRect(x: 50 + (width: view.frame.width * 0.40), y: 100 + (view.frame.height * 0.1), width: view.frame.width * 0.40, height: view.frame.height * 0.05))
        healthButton.setTitle("Health Points", for: UIControlState.normal)
        healthButton.backgroundColor = UIColor.black
        healthButton.titleLabel?.textColor = UIColor.white
        healthButton.layer.cornerRadius = 3
        healthButton.addTarget(self, action: #selector(healthButtonPressed), for: .touchUpInside)
        view.addSubview(healthButton)
        
        defenseButton = UIButton(frame: CGRect(x: 20, y: 120 + (view.frame.height * 0.15), width: view.frame.width * 0.40, height: view.frame.height * 0.05))
        defenseButton.setTitle("Defense Points", for: UIControlState.normal)
        defenseButton.backgroundColor = UIColor.black
        defenseButton.titleLabel?.textColor = UIColor.white
        defenseButton.layer.cornerRadius = 3
        defenseButton.addTarget(self, action: #selector(defenseButtonPressed), for: .touchUpInside)
        view.addSubview(defenseButton)
        
        randomButton = UIButton(frame: CGRect(x: 50 + (width: view.frame.width * 0.40), y: 120 + (view.frame.height * 0.15), width: view.frame.width * 0.40, height: view.frame.height * 0.05))
        randomButton.setTitle("Random", for: UIControlState.normal)
        randomButton.backgroundColor = UIColor.black
        randomButton.titleLabel?.textColor = UIColor.white
        randomButton.layer.cornerRadius = 3
        randomButton.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
        view.addSubview(randomButton)
        
        searchBar = UITextField(frame: CGRect(x: 20, y: 140 + (view.frame.height * 0.2), width: view.frame.width - 40, height: view.frame.height * 0.04))
        searchBar.placeholder = "  Search..."
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 3
        view.addSubview(searchBar)
        
        byTypesLabel = UILabel(frame: CGRect(x: 20, y: 160 + (view.frame.height * 0.25), width: view.frame.width - 40, height: view.frame.height * 0.05))
        byTypesLabel.text = "Or search by types:"
        byTypesLabel.textAlignment = .center
        view.addSubview(byTypesLabel)
        
        searchByCategoriesButton = UIButton(frame: CGRect(x: view.frame.width - 22.5 - (searchBar.frame.width * 0.3), y: 140 + (view.frame.height * 0.2) + (searchBar.frame.height * 0.075), width: searchBar.frame.width * 0.3, height: searchBar.frame.height * 0.85))
        searchByCategoriesButton.setTitle("Hoo hah!", for: .normal)
        searchByCategoriesButton.backgroundColor = UIColor.red
        searchByCategoriesButton.layer.cornerRadius = 3
        searchByCategoriesButton.addTarget(self, action: #selector(categoriesHooHah), for: .touchUpInside)
        view.addSubview(searchByCategoriesButton)
        
        searchByTypesButton = UIButton(frame: CGRect(x: (view.frame.width / 2) - (searchBar.frame.width * 0.15), y: 240 + (view.frame.height * 0.2) + (searchBar.frame.height * 0.075), width: searchBar.frame.width * 0.3, height: searchBar.frame.height * 0.85))
        searchByTypesButton.setTitle("Hoo hah!", for: .normal)
        searchByTypesButton.backgroundColor = UIColor.red
        searchByTypesButton.layer.cornerRadius = 3
        searchByTypesButton.addTarget(self, action: #selector(typesHooHah), for: .touchUpInside)
        view.addSubview(searchByTypesButton)
        
        
        pressed = UIButton()
    }
    
    func nameButtonPressed() {
        buttonPressed(b: nameButton)
    }
    
    func numButtonPressed() {
        buttonPressed(b: numButton)
    }
    
    func attackButtonPressed() {
        buttonPressed(b: attackButton)
    }
    
    func healthButtonPressed() {
        buttonPressed(b: healthButton)
    }
    
    func defenseButtonPressed() {
        buttonPressed(b: defenseButton)
    }
    
    func randomButtonPressed() {
        noPokemonToBeSearched = false
        nameButton.backgroundColor = UIColor.black
        numButton.backgroundColor = UIColor.black
        attackButton.backgroundColor = UIColor.black
        healthButton.backgroundColor = UIColor.black
        defenseButton.backgroundColor = UIColor.black
        randomButton.backgroundColor = UIColor.black
        
        randomButton.backgroundColor = UIColor.gray
        pressed = randomButton
        
        var indecies : [Int] = []
        var rand: Int
        var i: Int = 1
        while i < 21 {
            rand = Int(arc4random_uniform(UInt32(pokemon.count)))
            //                if !searchedPokemon.contains(pokemon[rand]) {
            //                    searchedPokemon.append(pokemon[rand])
            //                    i += 1
            //                }
            if !indecies.contains(rand) {
                indecies.append(rand)
                i += 1
                searchedPokemon.append(pokemon[rand])
            }
        }
        searchBar.text = ""
        pressed = nil
        nameButton.backgroundColor = UIColor.black
        numButton.backgroundColor = UIColor.black
        attackButton.backgroundColor = UIColor.black
        healthButton.backgroundColor = UIColor.black
        defenseButton.backgroundColor = UIColor.black
        randomButton.backgroundColor = UIColor.black
        performSegue(withIdentifier: "toCollection", sender: self)
    }
    
    func buttonPressed(b : UIButton) {
        nameButton.backgroundColor = UIColor.black
        numButton.backgroundColor = UIColor.black
        attackButton.backgroundColor = UIColor.black
        healthButton.backgroundColor = UIColor.black
        defenseButton.backgroundColor = UIColor.black
        randomButton.backgroundColor = UIColor.black
        
        b.backgroundColor = UIColor.gray
        pressed = b
    }
    
    func categoriesHooHah() {
        if searchBar.text != "" {
            noPokemonToBeSearched = false
            switch pressed {
            case nameButton:
                for p in pokemon {
                    if p.name == searchBar.text {
                        searchedPokemon.append(p)
                        break
                    }
                }
            case numButton:
                for p in pokemon {
                    if String(p.number) == searchBar.text! {
                        searchedPokemon.append(p)
                        break
                    }
                }
            case attackButton:
                for p in pokemon {
                    if String(p.attack) >= searchBar.text! {
                        searchedPokemon.append(p)
                    }
                }
            case healthButton:
                for p in pokemon {
                    if String(p.health) >= searchBar.text! {
                        searchedPokemon.append(p)
                    }
                }
            case defenseButton:
                for p in pokemon {
                    if String(p.defense) >= searchBar.text! {
                        searchedPokemon.append(p)
                    }
                }
            default:
                break
            }
        } else {
            noPokemonToBeSearched = true
        }
        searchBar.text = ""
        pressed = nil
        nameButton.backgroundColor = UIColor.black
        numButton.backgroundColor = UIColor.black
        attackButton.backgroundColor = UIColor.black
        healthButton.backgroundColor = UIColor.black
        defenseButton.backgroundColor = UIColor.black
        randomButton.backgroundColor = UIColor.black
        performSegue(withIdentifier: "toCollection", sender: self)
    }
    
    func typesHooHah() {
        for type in selectedTypesNames {
            for p in pokemon {
                for psType in p.types {
                    if type.contains(psType) {
                        searchedPokemon.append(p)
                        break;
                    }
                }
            }
        }
        if searchedPokemon.count == 0 {
            noPokemonToBeSearched = true
        } else {
            noPokemonToBeSearched = false
        }
        performSegue(withIdentifier: "toCollection", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! CollectionViewController
        next.searchedPokemon = searchedPokemon
        next.noPokemonToView = noPokemonToBeSearched
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 20, y: 200 + (view.frame.height * 0.25), width: view.frame.width - 40, height: view.frame.height * 0.4), collectionViewLayout: layout)
        collectionView.register(PokemonTypeCollectionViewCell.self, forCellWithReuseIdentifier: "typeCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
        view.addSubview(collectionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonTypeNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! PokemonTypeCollectionViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let typeCell = cell as! PokemonTypeCollectionViewCell
        typeCell.typeImage.image = UIImage(named: String(pokemonTypeNames[indexPath.row])!)!
        typeCell.type.text = pokemonTypeNames[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 6), height: view.frame.height * 0.15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? PokemonTypeCollectionViewCell
        if cell?.backgroundColor == UIColor.black {
            cell?.backgroundColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
            let rem = pokemonTypeNames[indexPath.row]
            selectedTypesNames = selectedTypesNames.filter { $0 != rem }
        } else {
            cell?.backgroundColor = UIColor.black
            selectedTypesNames.append(pokemonTypeNames[indexPath.row])
        }
    }
    
}
