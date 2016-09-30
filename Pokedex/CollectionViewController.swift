//
//  CollectionViewController.swift
//  Pokedex
//
//  Created by Vidya Ravikumar on 9/29/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var searchedPokemon : [Pokemon]! = []
    var selectCategoryLabel : UILabel!
    var noPokemonToView : Bool!
    var collectionView: UICollectionView!
    var segmentedView : UISegmentedControl!
    var tableView : UITableView!
    var selectedPokemon : Pokemon!
    var toFavesButton : UIButton!
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any avartional setup after loading the view.
        setupCollectionView()
        setupSegmentedControl()
        setupFavoritesButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSegmentedControl() {
        let items = ["Grid", "Table"]
        segmentedView = UISegmentedControl(items: items)
        segmentedView.selectedSegmentIndex = 0
        segmentedView.frame = CGRect(x: 0, y: 94, width: view.frame.width, height: 30)
        segmentedView.layer.cornerRadius = 3
        segmentedView.backgroundColor = UIColor.white
        segmentedView.tintColor = UIColor.black
        segmentedView.addTarget(self, action: #selector(switchView), for: .valueChanged)
        view.addSubview(segmentedView)
    }
    
    func setupFavoritesButton() {
        toFavesButton = UIButton(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: 30))
        toFavesButton.layer.cornerRadius = 3
        toFavesButton.setTitle("Favorites", for: .normal)
        toFavesButton.backgroundColor = UIColor.red
        toFavesButton.addTarget(self, action: #selector(viewFavoritesPage), for: .touchUpInside)
        view.addSubview(toFavesButton)
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 124, width: self.view.frame.width, height: self.view.frame.height - 28) , collectionViewLayout: layout)
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "pokeCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 124, width: view.frame.width, height: view.frame.height - 28))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "pokeTableViewCell")
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeTableViewCell", for: indexPath) as! PokemonTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! PokemonTableViewCell
        try! cell.pokemonImage.image = UIImage(data: Data(contentsOf: URL(string: searchedPokemon[indexPath.row].imageUrl)!))
        cell.name.text = searchedPokemon[indexPath.row].name
        cell.number.text = "# " + String(searchedPokemon[indexPath.row].number)
    }
    
    func switchView(sender: UISegmentedControl) {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        if (sender.selectedSegmentIndex == 0) {
            view.addSubview(segmentedView)
            setupFavoritesButton()
            setupCollectionView()
        } else {
            view.addSubview(segmentedView)
            setupFavoritesButton()
            setupTableView()
        }
    }
    
    func viewFavoritesPage() {
        performSegue(withIdentifier: "toFavorites", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let next = segue.destination as! PokemonDetailsViewController
            next.pokemon = selectedPokemon
            next.favorites = defaults.object(forKey: "p") as! [Pokemon]!
            next.defaults = defaults
        } else {
            let next = segue.destination as! FavoritesViewController
            
        }
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

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if noPokemonToView == false {
            return searchedPokemon.count
        //}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as! PokemonCollectionViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let pokeCell = cell as! PokemonCollectionViewCell
        try! pokeCell.pokemonImage.image = UIImage(data: Data(contentsOf: URL(string: searchedPokemon[indexPath.row].imageUrl)!))
        pokeCell.name.text = searchedPokemon[indexPath.row].name
        pokeCell.number.text = "# " + String(searchedPokemon[indexPath.row].number)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3), height: view.frame.height * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPokemon = searchedPokemon[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = searchedPokemon[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: self)
    }
}

