//
//  RandomViewController.swift
//  Pokedex
//
//  Created by Kevin Jiang on 9/28/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController {

    var pokesToDisplay: [Pokemon]!
    var selectedPoke: Pokemon!
    let tableView = UITableView(frame: CGRect(x: 25, y: 25, width: 350, height: 850))
    var segControl = UISegmentedControl(frame: CGRect(x: 140, y: 75, width: 100, height: 40))
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 15, y: 105, width: 350, height: 850), collectionViewLayout: self.layout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 70, height: 70)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.isHidden = true
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = true
        tableView.isHidden = false
        
        segControl.backgroundColor = UIColor.white
        segControl.selectedSegmentIndex = 0
        segControl.insertSegment(withTitle: "List", at: 0, animated: false)
        segControl.insertSegment(withTitle: "Grid", at: 1, animated: false)
        segControl.addTarget(self, action: #selector(self.changeViews), for: .valueChanged)
        
        view.addSubview(tableView)
        view.addSubview(segControl)
        view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfile" {
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
                    destination.types.text = "Types: " + selectedPoke.types[0] + "/" + selectedPoke.types[1]
                }
            }
        }
     }
    
    func changeViews() {
        if segControl.selectedSegmentIndex == 0 {
            tableView.isHidden = false
            collectionView.isHidden = true
        } else if segControl.selectedSegmentIndex == 1 {
            tableView.isHidden = true
            collectionView.isHidden = false
        }
    }

}

extension RandomViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate,
                                UICollectionViewDataSource {
    //TABLEVIEW STUFF
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokesToDisplay.count
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
        
        let pokemon = pokesToDisplay[indexPath.row]
        if let url = NSURL(string: pokemon.imageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                pokeCell.pokeImage.image = UIImage(data: data as Data)
            }
        }
        
        pokeCell.pokeName.text = pokemon.name
        pokeCell.pokeNumber.text = "#" + String(pokemon.number)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPoke = pokesToDisplay[indexPath.row]
        performSegue(withIdentifier: "toProfile", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    //COLLECTIONVIEW STUFF
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokesToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectCell", for: indexPath) as! CollectionViewCell
        
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let pokeCell = cell as! CollectionViewCell
        
        let pokemon = pokesToDisplay[indexPath.item]
        if let url = NSURL(string: pokemon.imageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                pokeCell.image.image = UIImage(data: data as Data)
            }
        }
        
        pokeCell.name.text = pokesToDisplay[indexPath.item].name
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPoke = pokesToDisplay[indexPath.item]
        performSegue(withIdentifier: "toProfile", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}


