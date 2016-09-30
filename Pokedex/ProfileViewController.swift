//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Shubham Goenka on 29/09/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

var nameAndNumberView: NameAndNumberView?
let testPokemon = PokemonGenerator.getPokemonArray()[0]


class ProfileViewController: UIViewController, UIScrollViewDelegate {
    var passedPokemon: Pokemon?
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(colorLiteralRed: 100/255, green: 0, blue: 0, alpha: 1)
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.isScrollEnabled = true
        scrollView.contentSize = view.frame.size


    }
    
    func setUI() {
        
        //setups scrollview
        scrollView = UIScrollView()
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        var containerView = UIView()
        scrollView.addSubview(containerView)

        
        // Sets up the frame for Pokemon image.
        var profilePic = UIImageView(frame: CGRect(x: view.frame.width * 0.25, y: self.navigationController!.navigationBar.frame.height + 20, width: view.frame.width * 0.5, height: view.frame.height * 0.3))
        

        //for image
        //checks if imageurl is nil
        var imgURL: URL
        if let _ = Foundation.URL(string:(passedPokemon?.imageUrl)!){
            imgURL = Foundation.URL(string: (passedPokemon?.imageUrl)!)!
            
            //This is to check if the url actually downloads an image (checks for nil)
            let placeholderImageView: UIImageView? = UIImageView()
            placeholderImageView?.downloadedFrom(url: imgURL)
            
            
            if placeholderImageView != nil{
                profilePic.downloadedFrom(url: imgURL)
            }else{
                profilePic.image = UIImage(named: "noimage")
                
            }
            
        }else{
            let imageName = "noimage"
            let image = UIImage(named: imageName)
            profilePic = UIImageView(image: image!)
            
        }

    
        profilePic.contentMode = .scaleAspectFit
        profilePic.clipsToBounds = true
        containerView.addSubview(profilePic)
        
        // Instantiates the class that displays the Pokemon's name and number, the two most important properties.
        nameAndNumberView = NameAndNumberView(frame: CGRect(x: view.frame.width * 0.25, y: (view.frame.height * 0.3 + 30) + self.navigationController!.navigationBar.frame.height, width: view.frame.width * 0.5, height: 55), pokemon: passedPokemon!)
        containerView.addSubview(nameAndNumberView!)
        
        // Instantiates the class that displays the Pokemon's other properties/statistics.
        let otherStatisticsView = OtherStatisticsView(frame: CGRect(x: view.frame.width * 0.15, y: (view.frame.height * 0.3 + 105) + self.navigationController!.navigationBar.frame.height, width: view.frame.width * 0.7, height: 257.5), pokemon: passedPokemon!)
        containerView.addSubview(otherStatisticsView)
        
        // Instantiates the class that contains the ADDTOFAVORITES button.
        let addToFavorites = AddToFavorites(frame: CGRect(x: view.frame.width * 0.15, y: (view.frame.height * 0.3 + 382.5) + self.navigationController!.navigationBar.frame.height, width: view.frame.width * 0.7, height: 40), staticText: "Add To Favorites")
        containerView.addSubview(addToFavorites)
        
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


class NameAndNumberView: UIView {
    
    var pokemon: Pokemon!
    
    // Takes in the POKEMON object as a parameter.
    init(frame: CGRect, pokemon: Pokemon) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.pokemon = pokemon
        setNameNumLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNameNumLayout() {
        
        // Sets the layout for the Pokemon's NAME.
        let nameLabel = UILabel(frame: CGRect(x: frame.width * 0.1, y: 5, width: frame.width * 0.8, height: 20))
        nameLabel.text = "Name: \(pokemon.name!)"
        nameLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 16.0)
        nameLabel.textAlignment = NSTextAlignment.center
        addSubview(nameLabel)
        
        // Sets the layout for the Pokemon's NUMBER.
        let numberLabel = UILabel(frame: CGRect(x: frame.width * 0.1, y: 30, width: frame.width * 0.8, height: 20))
        numberLabel.text = "Number: \(String(pokemon.number))"
        numberLabel.font = UIFont(name: "HelveticaNeue-SemiBold", size: 16.0)
        numberLabel.textAlignment = NSTextAlignment.center
        addSubview(numberLabel)
        
    }
    
}


class OtherStatisticsView: UIView {
    
    var pokemon: Pokemon!
    
    // Takes in the POKEMON object as a parameter.
    init(frame: CGRect, pokemon: Pokemon) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
        self.pokemon = pokemon
        setStatsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStatsLayout() {
        
        // Sets the layout for the Pokemon's TYPE.
        let typeLabel = UILabel(frame: CGRect(x: frame.width * 0.05, y: 10, width: frame.width * 0.9, height: 17.5))
        typeLabel.text = "Type: \(arrayToString(stringArr: pokemon.types))"
        typeLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        addSubview(typeLabel)
        
        // Sets the layout for the Pokemon's ATTACK stat.
        let attackLabel = UILabel(frame: CGRect(x: frame.width * 0.05, y: 37.5, width: frame.width * 0.9, height: 17.5))
        attackLabel.text = "Attack: \(String(pokemon.attack))"
        attackLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        addSubview(attackLabel)
        
        // Sets the layout for the Pokemon's DEFENSE stat.
        let defenseLabel = UILabel(frame: CGRect(x: frame.width * 0.05, y: 65, width: frame.width * 0.9, height: 17.5))
        defenseLabel.text = "Defense: \(String(pokemon.defense))"
        defenseLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        addSubview(defenseLabel)
        
        // Sets the layout for the Pokemon's HP stat.
        let healthLabel = UILabel(frame: CGRect(x: frame.width * 0.05, y: 92.5, width: frame.width * 0.9, height: 17.5))
        healthLabel.text = "Health: \(String(pokemon.health))"
        healthLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        addSubview(healthLabel)
        
        // Sets the layout for the Pokemon's SP.ATK stat.
        let spAttackLabel = UILabel(frame: CGRect(x: frame.width * 0.05, y: 120, width: frame.width * 0.9, height: 17.5))
        spAttackLabel.text = "Special Attack: \(String(pokemon.specialAttack))"
        spAttackLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        addSubview(spAttackLabel)
        
        // Sets the layout for the Pokemon's SP.DEF stat.
        let spDefLabel = UILabel(frame: CGRect(x: frame.width * 0.05, y: 147.5, width: frame.width * 0.9, height: 17.5))
        spDefLabel.text = "Special Defense: \(String(pokemon.specialDefense))"
        spDefLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        addSubview(spDefLabel)
        
        // Sets the layout for the Pokemon's SPEED stat.
        let speedLabel = UILabel(frame: CGRect(x: frame.width * 0.05, y: 175, width: frame.width * 0.9, height: 17.5))
        speedLabel.text = "Speed: \(String(pokemon.speed))"
        speedLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        addSubview(speedLabel)
        
        // Sets the layout for the Pokemon's TOTAL stats.
        let totalLabel = UILabel(frame: CGRect(x: frame.width * 0.05, y: 202.5, width: frame.width * 0.9, height: 17.5))
        totalLabel.text = "Total: \(String(pokemon.total))"
        totalLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        addSubview(totalLabel)
        
        // Sets the layout for the Pokemon's SPECIES type.
        let speciesLabel = UILabel(frame: CGRect(x: frame.width * 0.05, y: 230, width: frame.width * 0.9, height: 17.5))
        speciesLabel.text = "Species: \(pokemon.species!)"
        speciesLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        addSubview(speciesLabel)
        
    }
    
    // Converts the contents of a string array to a single string containing the elements in STRINGARR separated by a ", "
    func arrayToString(stringArr: [String]) -> String {
        var result: String = ""
        for x in stringArr {
            if (x != stringArr[stringArr.count - 1]) {
                result += (x + ", ")
            } else {
                result += x
            }
        }
        return result
    }
    
}


class AddToFavorites: UIView {
    
    // For the button's text field.
    var staticText: String!
    
    // Sets up an offline NSUserDefaults library.
    let offlineLib = UserDefaults.standard
    
    // List of Pokemon names that will be added to Favorites.
    var favorites: [String] = []
    
    init(frame: CGRect, staticText: String) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.staticText = staticText
        setButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton() {
        
        // Sets the layout for the "Add To Favorites" button.
        let favoriteButton = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        favoriteButton.setTitle(staticText, for: UIControlState.normal)
        favoriteButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        favoriteButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        // Tells the button which function to call upon being tapped.
        favoriteButton.addTarget(self, action: #selector(AddToFavorites.pressed(_:)), for: UIControlEvents.touchUpInside)
        
        addSubview(favoriteButton)
    }
    
    // Function that gets called when the user taps the button.
    func pressed(_ sender: UIButton!) {
        let current = nameAndNumberView?.pokemon.name!
        if (!(favorites.contains(current!))) {
            favorites.append(current!)
        }
        
        // The list of the names of the user's FAVORITES is saved to NSUserDefaults.
        offlineLib.set(favorites, forKey: "Favorite Pokémon List")
    }
    
}



