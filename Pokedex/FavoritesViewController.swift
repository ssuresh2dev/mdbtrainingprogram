//
//  FavoritesViewController.swift
//  Pokedex
//
//  Created by Vidya Ravikumar on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView : UITableView!
    var titleLabel : UILabel!
    var pokemon : [Pokemon]!
    var image : UIImageView!
    var name : UILabel!
    var number : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel = UILabel(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: 30))
        titleLabel.text = "Favorites"
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 94, width: view.frame.width, height: view.frame.height - 94))
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "pokeCell")
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath) as! PokemonTableViewCell
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! PokemonTableViewCell
        try! cell.pokemonImage.image = UIImage(data: Data(contentsOf: URL(string: pokemon[indexPath.row].imageUrl)!))
        cell.name.text = pokemon[indexPath.row].name
        cell.number.text = "# " + String(pokemon[indexPath.row].number)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
