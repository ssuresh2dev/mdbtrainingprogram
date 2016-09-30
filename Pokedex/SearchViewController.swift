//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Kevin Jiang on 9/29/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let searchController = UISearchController(searchResultsController: nil)
    let pokeArray = PokemonGenerator.getPokemonArray()
    var filteredPokemon: [Pokemon] = []
    let tableView = UITableView(frame: CGRect(x: 5, y: 5, width: 350, height: 850))
    var selectedPoke: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = true
        
        searchController.searchResultsUpdater = self //self updates
        searchController.dimsBackgroundDuringPresentation = false
        //definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        
        
        view.addSubview(tableView)
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
    
    func filterPokemon () -> [Pokemon] {
        var filtered: [Pokemon] = []
        for pokemon in pokeArray {
            if pokemon.name.lowercased().contains((searchController.searchBar.text?.lowercased())!){
                filtered.append(pokemon)
            }
        }
        
        return filtered
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alsoToProfile" {
            if let destination = segue.destination as? ProfileViewController {
                
                if let url = NSURL(string: selectedPoke.imageUrl) {
                    if let data = NSData(contentsOf: url as URL) {
                        destination.picture.image = UIImage(data: data as Data)
                    }
                }
                
                destination.pokemon = selectedPoke
                destination.name.text = "Name: " + selectedPoke.name
                destination.number.text = "Number: " + String(selectedPoke.number)
                destination.attack.text = "Attack: " + String(selectedPoke.attack)
                destination.defense.text = "Defense: " + String(selectedPoke.defense)
                destination.health.text = "Health: " + String(selectedPoke.health)
                destination.specialAttack.text = "Special Attack: " + String(selectedPoke.specialAttack)
                destination.specialDefense.text = "Special Defense: " + String(selectedPoke.specialDefense)
                destination.species.text = "Species: " + String(selectedPoke.species)
                destination.speed.text = "Speed: " + String(selectedPoke.speed)
                destination.total.text = "Total: " + String(selectedPoke.total)
                
                if selectedPoke.types.count == 1 {
                    destination.types.text = "Type: " + selectedPoke.types[0]
                } else {
                    destination.types.text = "Type(s): " + selectedPoke.types[0] + "/" + selectedPoke.types[1]
                }
            }
        }
    }



}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating,
                            UISearchBarDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.searchBar.text != "" {
            return filteredPokemon.count
        }
        return pokeArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            as! TableViewCell
        
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let pokeCell = cell as! TableViewCell
        
        var arrayToUse = pokeArray
        
        if searchController.searchBar.text != "" {
            arrayToUse = filteredPokemon
        }
        
        let pokemon = arrayToUse[indexPath.row]
        
        if let url = NSURL(string: pokemon.imageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                pokeCell.pokeImage.image = UIImage(data: data as Data)
            }
         }
         
        pokeCell.pokeName.text = pokemon.name
        pokeCell.pokeNumber.text = "#" + String(pokemon.number)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredPokemon.removeAll(keepingCapacity: false)
        
        
        /*
        let searchPredicate = NSPredicate(format: "Pokemon.name CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (pokeArray as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]*/
        
        filteredPokemon = filterPokemon()
        
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.searchBar.text != "" {
            selectedPoke = filteredPokemon[indexPath.item]
        } else {
            selectedPoke = pokeArray[indexPath.item]
        }
        
        performSegue(withIdentifier: "alsoToProfile", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}


