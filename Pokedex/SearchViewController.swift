//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Eliot Han on 9/29/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit
import Foundation

class SearchViewController: UIViewController {
    
    var tableView: UITableView! = UITableView()
    var pokemon: [Pokemon] = PokemonGenerator.getPokemonArray()
    var filteredPokemon = [Pokemon]()
    var searchController: UISearchController!
    var shouldShowSearchResults: Bool = false
    var textFieldPlaceholder:String = "lol"
    
    var searchCategories: [String] = ["Type", "Attack","Defense","Health","Special Attack", "Special Defense", "Species", "Speed"]
    
    
    //categories for searching
    
//    let numberCatButton: UIButton!
//    let attackCatTextField: UITextField!
//    let defenseCatTextField: UITextField!
//    let healthCatTextField: UITextField!
//    let specialAttackCatTextField: UITextField!
//    let specialDefenseCatTextField: UITextField!
//    let speciesCatTextField: UITextField!
//    let speedCatTextField: UITextField!
//    let totalCatTextField: UITextField!
//    let typeTextField: UITextField!
 
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(false)
      self.viewDidLoad()
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldShowSearchResults = false
      
        // Do any additional setup after loading the view.
        setupTableView()
        setupSearch()
    }

    func setupSearch(){
        searchController = UISearchController(searchResultsController: nil)
        //searchController.searchBar.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: 44)

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pokemon"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self

        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true

        
        
        searchController.searchBar.isHidden = false
        searchController.searchBar.sizeToFit()
        // This following line fixed a  bug for me where my search bar would not display....
        searchController.searchBar.scopeButtonTitles = []

        // Place the search bar view to the tableview headerview.
        tableView.tableHeaderView = searchController.searchBar
        

    }
    
    func setupTableView(){
        tableView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height +
            self.navigationController!.navigationBar.frame.height, width: view.frame.width, height: view.frame.height)
        tableView = UITableView(frame: tableView.frame)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length + 150, 0)  //this is to prevent tab bar from hiding last cell
        
        tableView.rowHeight = 80
        tableView.backgroundColor = UIColor.white
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView!)
    }
    

    
//    func setupTypeTableView(){
//        typeTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//        typeTableView = UITableView(frame: typeTableView.frame)
//        typeTableView.contentInset = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length + 150, 0)
//        typeTableView.delegate = self
//        typeTableView.dataSource = self
//        typeTableView.backgroundColor = UIColor.white
//        typeTableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "pokemonCell")
//        view.addSubview(typeTableView!)
//    }
//    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        viewWillAppear(false)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults{
            print(filteredPokemon.count)
            print("numrowsinSection returning filteredpokemon.count")
            return filteredPokemon.count
        }
    
        //Display Categories for Searching
        filteredPokemon = PokemonGenerator.getPokemonArray()
        print("numrowsinSection returning searchCategories.count")
        return searchCategories.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if shouldShowSearchResults{
            print("Making pokemonCells")
            let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
            for subview in cell.contentView.subviews{
                subview.removeFromSuperview()
            }
            cell.awakeFromNib()
            self.tableView?.rowHeight = 80
            
            return cell
        }else{
            print("making categoryCells")
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
            for subview in cell2.contentView.subviews{
                subview.removeFromSuperview()
            }
            cell2.awakeFromNib()
            self.tableView?.rowHeight = 80
            
            return cell2
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if shouldShowSearchResults{ //display filtered pokemon
            let pokemonCell = cell as! PokemonTableViewCell
            
            //for labels
            let pokemonDisplayed = filteredPokemon[indexPath.row]
            var name:String? = pokemonDisplayed.name
            //this makes the cells look nicer as it cuts out the pokemon's nickname if it has one
            if pokemonDisplayed.name.contains("("){
                let index = name!.index(of: "(")
                name = name?.substring(to: index!)
                
            }
            pokemonCell.pokemonNameLabel.text = name!
            pokemonCell.pokemonNumberLabel.text = String(pokemonDisplayed.number)
            
            //for image
            //checks if imageurl is nil
            var imgURL: URL
            if let _ = Foundation.URL(string: pokemonDisplayed.imageUrl){
                imgURL = Foundation.URL(string: pokemonDisplayed.imageUrl)!
                
                //This is to check if the url actually downloads an image (checks for nil)
                let placeholderImageView: UIImageView? = UIImageView()
                placeholderImageView?.downloadedFrom(url: imgURL)
                
                
                if placeholderImageView != nil{
                    pokemonCell.pokemonImageView?.downloadedFrom(url: imgURL)
                }else{
                    //let imageName = "noimage"
                    //let image = UIImage(#imageLiteral(resourceName: "noimage"))
                    
                    pokemonCell.pokemonImageView?.image = UIImage(named: "noimage")
                    
                }
                
            }else{
                let imageName = "noimage"
                let image = UIImage(named: imageName)
                pokemonCell.pokemonImageView? = UIImageView(image: image!)
            }
            
        }else{ //display categories for user
            let categoryCell = cell as! CategoryTableViewCell
            let categoryDisplayed = searchCategories[indexPath.row]
            categoryCell.categoryLabel.text = categoryDisplayed
            
        }
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if shouldShowSearchResults{
            //enter into profileviewcontroller
            print("Entering profile view controller")
            
            
            
            
        }else{
            print("shouldshowsearchresults is false")
            if indexPath.row == 0{
                //enter into type tableview controller
                print("enter into type tableview controller")
                performSegue(withIdentifier: "showPokemonTypeVC", sender: self)
                
                
                
            }else{
                //enter into text field view controller
                
                textFieldPlaceholder = searchCategories[indexPath.row]
                print(textFieldPlaceholder)
                performSegue(withIdentifier: "showTextFieldVC", sender: self)
                
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTextFieldVC"{
            let vc = segue.destination as? TextFieldViewController
            vc?.navigationItem.title = textFieldPlaceholder
        }
    }
    
}


extension SearchViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults{
            shouldShowSearchResults = true
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        searchController.searchBar.resignFirstResponder()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filteredPokemon.removeAll()
        shouldShowSearchResults = true
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        filteredPokemon.removeAll()
        print("User clicked Cancel!")
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {

        let searchString = searchController.searchBar.text
       
        
        // Filter the data array and get only those pokemon that match the search text.
        //check for letters
        let letters = NSCharacterSet.letters
        let range = searchString?.rangeOfCharacter(from: letters)
        
        // range will be nil if no letters is found
        if let test = range {
            //println("letters found")
            filteredPokemon = pokemon.filter({ (pokemon) -> Bool in
                let pokemonNameString: NSString = pokemon.name as NSString
                return (pokemonNameString.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
            })
            
            
            

        }
        else {
            //println("letters not found")
            filteredPokemon = pokemon.filter({ (pokemon) -> Bool in
                let pokemonNumberString = String(pokemon.number)
                let pokemonNumber = pokemonNumberString as NSString
                return (pokemonNumber.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
            })
            

        }
        
        
        tableView.reloadData()
        
        
 
    }
    
    
    
}
