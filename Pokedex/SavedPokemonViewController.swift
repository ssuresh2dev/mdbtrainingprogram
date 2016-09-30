//
//  StatisticsViewController.swift
//  Pokedex
//
//  Created by Eliot Han on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class SavedPokemonViewController: UIViewController {
    var tableView: UITableView! = UITableView()
    var savedPokemonNames: [String] = []
    var savedPokemon: [Pokemon] = []
    var allPokemon = PokemonGenerator.getPokemonArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getFromDefaults()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        viewDidLoad()
    }

    func getFromDefaults(){
        let defaults = UserDefaults.standard
        if let names = defaults.stringArray(forKey: "Favorite Pokémon List"){
            savedPokemonNames = names
            for pokemon in allPokemon{
                for i in savedPokemonNames{
                    if i == pokemon.name{
                        savedPokemon.append(pokemon)
                    }
                }
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView(){
        tableView.frame = CGRect(x: 0, y: 15, width: view.frame.width, height: view.frame.height)
        tableView = UITableView(frame: tableView.frame)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length + 150, 0)  //this is to prevent tab bar from hiding last cell
        
        tableView.rowHeight = 80
        tableView.backgroundColor = UIColor.white
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView!)
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
extension SavedPokemonViewController: UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPokemonNames.count
        
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
            let pokemonDisplayed = savedPokemon[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

