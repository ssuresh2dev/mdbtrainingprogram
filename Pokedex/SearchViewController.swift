//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Eliot Han on 9/29/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var tableView: UITableView! = UITableView()
    var pokemon: [Pokemon] = PokemonGenerator.getPokemonArray()
    var filteredPokemon = [Pokemon]()
    var searchController: UISearchController!
    var shouldShowSearchResults: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearch()

        // Do any additional setup after loading the view.
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
        searchController.searchBar.scopeButtonTitles = []

        // Place the search bar view to the tableview headerview.
        tableView.tableHeaderView = searchController.searchBar
        

    }
    
    func setupTableView(){
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height) //height of navigation bar + statusbar
        tableView = UITableView(frame: tableView.frame)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length + 150, 0)  //this is to prevent tab bar from hiding last cell
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        view.addSubview(tableView!)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredPokemon.count
        }
        else {
            filteredPokemon = PokemonGenerator.getPokemonArray()
            return pokemon.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        self.tableView?.rowHeight = 80
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
        

    }
    
    
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        for pokemon in pokemon{
            if searchText.lowercased() == pokemon.name{
                filteredPokemon.append(pokemon)
            }
        }
        
        tableView.reloadData()
    }

}


extension SearchViewController: UISearchBarDelegate{
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
//    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults{
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filteredPokemon.removeAll()
        shouldShowSearchResults = true
        tableView.reloadData()
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
        let searchString = searchController.searchBar.text
       
        
        // Filter the data array and get only those countries that match the search text.
        filteredPokemon = pokemon.filter({ (pokemon) -> Bool in
            let pokemonNameString: NSString = pokemon.name as NSString
            return (pokemonNameString.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        tableView.reloadData()
    }
    
    
    
}
