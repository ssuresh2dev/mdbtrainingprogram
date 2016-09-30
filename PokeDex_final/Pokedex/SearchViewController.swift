//
//  ViewController.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

//test comment
import UIKit

class SearchViewController: UIViewController, UIAlertViewDelegate {

    struct typeObject {
        var typeName: String
        var typeSymbol: UIImage
    }
    var pokelogo: UIImageView!
    var typesPressed: [IndexPath]!
    var collectionView: UICollectionView!
    var pokeNum: UITextField!
    let totalPokemons: [Pokemon] = PokemonGenerator.getPokemonArray()
    var pokemonsToShow: [Pokemon] = [] 
    var pokeName: UITextField!
    var minHlthTF: UITextField!
    var minAttkTF: UITextField!
    var goButton: UIButton!
    var randomButton: UIButton!
    var typeArray = [UIImage(named: "normal"), UIImage(named: "fighting"), UIImage(named: "dragon"), UIImage(named: "water"), UIImage(named: "ice"), UIImage(named: "ghost"), UIImage(named: "fire"), UIImage(named: "steel"), UIImage(named: "rock"), UIImage(named: "dark"), UIImage(named: "electric"), UIImage(named: "poison"), UIImage(named: "bug"), UIImage(named: "fairy"), UIImage(named: "psychic"), UIImage(named: "flying"), UIImage(named: "grass"), UIImage(named: "ground")]
    var typeNames = ["Normal", "Fighting", "Dragon", "Water", "Ice", "Ghost", "Fire", "Steel", "Rock", "Dark", "Electric", "Poison", "Bug", "Fairy", "Psychic", "Flying", "Grass", "Ground"]
    
    //Values to pass onto to the next view controller in order to show a subset of pokemon we want based on the choices in this view controller.
    var minHlthInput: Int!
    var minAttkIinput: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        minHlthSetup()
        minAttkSetup()
        pokeNameSetup()
        pokeNumSetup()
        
        
        let nav = navigationController!.navigationBar
        pokelogo = UIImageView(frame: CGRect(x: nav.frame.width/16, y: nav.frame.height/16, width: 7*nav.frame.width/8, height: 7*nav.frame.height/8))
        pokelogo.image = UIImage(named: "pokemonlogo")
        pokelogo.contentMode = .scaleAspectFit
        pokelogo.clipsToBounds = true
       
        nav.addSubview(pokelogo)
//        let pokeball = UIImageView(frame: CGRect(x: nav.frame.width/2, y:nav.frame.height/2, width: nav.frame.width/6, height: nav.frame.width/6))
//        pokeball.image = UIImage(named: "pokeball")
//        nav.addSubview(pokeball)
        nav.barTintColor = UIColor.red
        navigationItem.hidesBackButton = true
        //sets up random button
        randomButton = UIButton(frame: CGRect(x: 2*view.frame.width/3, y: view.frame.width/2, width: view.frame.width/3, height: view.frame.width/6))
        randomButton.sendSubview(toBack: view)
        randomButton.setTitle("Random!", for: .normal)
        randomButton.backgroundColor = UIColor.init(red:0.10, green:0.10, blue:0.44, alpha:0.8)
        randomButton.addTarget(self, action: #selector(randbuttonClicked), for: UIControlEvents.touchUpInside)
        view.addSubview(randomButton)
        
        //sets up search button
        goButton = UIButton(frame: CGRect(x: 0, y: 3*view.frame.width/8, width: view.frame.width, height: view.frame.width/6))
        goButton.setTitle("Search by categories >>>", for: .normal)
        goButton.backgroundColor = UIColor.black
        goButton.addTarget(self, action: #selector(gobuttonClicked), for: UIControlEvents.touchUpInside)
        view.addSubview(goButton)
        
        
    }
    
    //all button click events
    func randbuttonClicked(sender: UIButton){
        pokemonsToShow = []
        var randArray: [Int] = []
        while(randArray.count < 20){
            let r =  Int(arc4random_uniform(UInt32(totalPokemons.count)))
            if(!randArray.contains(r)){
                randArray.append(r)
            }
        }
        for p in totalPokemons{
            if(randArray.contains(p.number)){
                pokemonsToShow.append(p)
            }
        }
        performSegue(withIdentifier: "search", sender: self)
    }
    //types and minhlth and minattk filters
    func gobuttonClicked(sender: UIButton){
        pokemonsToShow = []
        
        //shows alert if min hlth or min pts is not numeric.
        if((!(minHlthTF.text?.isEmpty)! && !(minHlthTF.text?.isNumber)!) || (!(minAttkTF.text?.isEmpty)! && !(minAttkTF.text?.isNumber)!)){
            let alert = UIAlertController(title: "Alert: Invalid Input", message: "input must be numeric.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "I understand", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        for p in totalPokemons{
            if((minHlthTF.text?.isEmpty)! || (minAttkTF.text?.isEmpty)!){
                if collectionView.indexPathsForSelectedItems!.isEmpty{
                    pokemonsToShow.append(p)
                }
                else{
                    for i in collectionView.indexPathsForSelectedItems!{
                        if(p.types.contains(String(typeNames[i.row]))){
                            pokemonsToShow.append(p)
                        }
                    }
                }
            }
            else{
                let minhlth: Int? = Int(minHlthTF.text!)
                let minattk: Int? = Int(minAttkTF.text!)
                if((p.attack >= minattk!) && (p.health >= minhlth!)){
                    if collectionView.indexPathsForSelectedItems!.isEmpty{
                        pokemonsToShow.append(p)
                    }
                    else{
                        for i in collectionView.indexPathsForSelectedItems!{
                            if(p.types.contains(String(typeNames[i.row]))){
                                pokemonsToShow.append(p)
                            }
                        }
                }
            }
            }
        }
        performSegue(withIdentifier: "search", sender: self)
    }
    
    func numSearchClicked(sender: UIButton){
        pokemonsToShow = []
        if(pokeNum.text?.isEmpty)!{
            let alert = UIAlertController(title: "Alert: Invalid Input", message: "please enter a pokemon number.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "I understand", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            for p in totalPokemons{
                if(String(p.number) == pokeNum.text!){
                        pokemonsToShow.append(p)
                        performSegue(withIdentifier: "search", sender: self)
                        return
                }
            }
            //Pokemon cannot be found - alert
            let alert = UIAlertController(title: "Sorry, your number is out of bounds.", message: ":(", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "I understand", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func nameSearchClicked(sender: UIButton){
        pokemonsToShow = []
        if(pokeName.text?.isEmpty)!{
            let alert = UIAlertController(title: "Alert: Invalid Input", message: "please enter a pokemon number.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "I understand", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            for p in totalPokemons{
                if(String(p.name) == pokeName.text!){
                    pokemonsToShow.append(p)
                    performSegue(withIdentifier: "search", sender: self)
                    return
                }
            }
            //Pokemon cannot be found - alert
            let alert = UIAlertController(title: "Sorry, either your Pokemon does not exist or you spelled it wrong.", message: ":(", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "I understand", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func pokeNameSetup(){
        pokeName = UITextField(frame: CGRect(x: 0, y: view.frame.width/6, width: 3*view.frame.width/4, height: view.frame.width/8))
        pokeName.placeholder = "Enter your pokémon name..."
        view.addSubview(pokeName)
        
        let nameSearch = UIButton(frame: CGRect(x: 3*view.frame.width/4, y: view.frame.width/6, width: view.frame.width/4, height: view.frame.width/9))
        nameSearch.backgroundColor = UIColor.init(red:0.10, green:0.10, blue:0.44, alpha:0.8)
        nameSearch.setTitle("Search", for: .normal)
        nameSearch.addTarget(self, action: #selector(nameSearchClicked), for: UIControlEvents.touchUpInside)
        view.addSubview(nameSearch)
    }
    
    func pokeNumSetup(){
        pokeNum = UITextField(frame: CGRect(x: 0, y: view.frame.width/4, width: 3*view.frame.width/4, height: view.frame.width/8))
        pokeNum.placeholder = "Enter your pokémon number..."
        view.addSubview(pokeNum)
        let numSearch = UIButton(frame: CGRect(x: 3*view.frame.width/4, y: view.frame.width/6 + view.frame.width/9, width: view.frame.width/4, height: view.frame.width/9))
        numSearch.setTitle("Search", for: .normal)
        numSearch.backgroundColor = UIColor.init(red:0.10, green:0.10, blue:0.44, alpha:0.8)
        numSearch.addTarget(self, action: #selector(numSearchClicked), for: UIControlEvents.touchUpInside)
        view.addSubview(numSearch)
        }
    
    func minHlthSetup(){
        minHlthTF = UITextField(frame: CGRect(x: 0, y: view.frame.width/2, width: view.frame.width/3, height: view.frame.width/6))
        minHlthTF.placeholder = "min health pts"
        minHlthTF.returnKeyType = UIReturnKeyType.done
        minHlthTF.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.addSubview(minHlthTF)
    }
    
    func minAttkSetup(){
        //set up pokemon number text field
        minAttkTF = UITextField(frame: CGRect(x: view.frame.width/3, y: view.frame.width/2, width: view.frame.width/3, height: view.frame.width/6))
        
        minAttkTF.placeholder = "min attack pts"
        minAttkTF.returnKeyType = UIReturnKeyType.done
        minAttkTF.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.addSubview(minAttkTF)
    }

    
    func collectionViewSetup(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 2*view.frame.width/3-view.frame.width/6 , width: view.frame.width, height: view.frame.height-2*view.frame.width/3 + view.frame.width/6), collectionViewLayout: layout)
        collectionView.register(TypeCollectionViewCell.self, forCellWithReuseIdentifier: "typeCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.init(red:0.80, green:0.89, blue:0.98, alpha:1.0)
       
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsMultipleSelection = true
        collectionView.allowsSelection = true
        view.addSubview(collectionView)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        }

    }

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //number of sections in the collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //number of cells in the given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath)
            as! TypeCollectionViewCell
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let typeCell = cell as! TypeCollectionViewCell
        typeCell.TypeImageView.image = typeArray[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3, height: view.frame.width/3)
    }
    
    //select items
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath) as? TypeCollectionViewCell
        if cell != nil {
//            cell!.isSelected = !cell!.isSelected
            if cell!.isSelected == true {
                cell?.changeColor()
            }
        }
    }
    //deselect items
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TypeCollectionViewCell
        if cell != nil {
            if cell!.isSelected == false {
                cell?.changeColor()
            }
        }
    }
    
    
    //transfers search data to the next view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "search"){
            let VC = segue.destination as! ListViewController
            VC.pokemons = pokemonsToShow
            pokelogo.removeFromSuperview()
        }
    }
    
    
}
extension SearchViewController: TypeCollectionViewCellDelegate {
    func changeColorOfButton(forCell: TypeCollectionViewCell) {
        if forCell.isSelected == true {
            forCell.TypeImageView.alpha = 0.5

        } else {
            forCell.TypeImageView.alpha = 1.0

        }
    }
}

extension String{
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted) == nil
        }
    }
}




