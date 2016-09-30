//
//  ListViewController.swift
//  Pokedex
//
//  Created by Jessica Chen on 9/26/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var listGridSwitch: UISegmentedControl!
    var pokemons: [Pokemon] = PokemonGenerator.getPokemonArray()
    var tableView: UITableView!
    var CollectionView: UICollectionView!
    var typesPressed: [IndexPath] = []
    var pokemonAt: Pokemon!
    var favorites: [Pokemon] = [] 
    
    //class cell for table view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listGridSwitch = UISegmentedControl(frame: CGRect(x: view.frame.width/4, y: view.frame.height/10, width: view.frame.width/2, height: view.frame.width/10))
        listGridSwitch.insertSegment(withTitle: "List View", at: 0, animated: true)
        listGridSwitch.insertSegment(withTitle: "Grid View", at: 1, animated: true)
        listGridSwitch.addTarget(self, action: #selector(segment), for: UIControlEvents.valueChanged)
        listGridSwitch.tintColor = UIColor.white
//        view.addSubview(listGridSwitch)
        self.navigationItem.titleView = listGridSwitch
        self.navigationItem.title = "Pokemon List"
        navigationItem.leftBarButtonItem?.tintColor =  UIColor.white
        
        //Favorites Button
        let goToFave = UIBarButtonItem(title: "Favorites", style: UIBarButtonItemStyle.plain, target: self, action: #selector(goToFavorites))
//        goToFave.backgroundColor = UIColor.clear
//        goToFave.addTarget(self, action: #selector(goToFavorites), for: UIControlEvents.touchUpInside)
//        goToFave.setTitle("Favorites", for: .normal)
        navigationItem.rightBarButtonItem = goToFave
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(navBack))
        
        listViewSetup()
        
        
                // Do any additional setup after loading the view.
    }
    
    func navBack(sender: UIBarButtonItem){
        performSegue(withIdentifier: "backToSearch", sender: self)
    }
    func goToFavorites(sender: UIButton){
        performSegue(withIdentifier: "favoritesSegue", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segment(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 1:
           gridViewSetup()
            
        default:
            listViewSetup()
            
        }
    }
    
    func listViewSetup(){
        for subview in view.subviews{
            subview.removeFromSuperview()
        }
        //set up tableView
        tableView = UITableView(frame: CGRect(x:0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.register(ListCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    func gridViewSetup(){
        for subview in view.subviews{
            subview.removeFromSuperview()
        }
        //set up grid view
        let layout = UICollectionViewFlowLayout()
        CollectionView = UICollectionView(frame: CGRect(x: view.frame.width/20, y: 64, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        CollectionView.backgroundColor = UIColor.white
        CollectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "PokemonCell")
        view.addSubview(CollectionView)
        CollectionView.delegate = self
        CollectionView.dataSource = self
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
    }
    
    //tableView methods. 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count //Still need to set array  countfor this value
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonAt = pokemons[indexPath.row]
        performSegue(withIdentifier: "segueProfile", sender: self)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
            as! ListCell
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellId = cell as! ListCell
            guard let url = URL(string: pokemons[indexPath.row].imageUrl) else {
                return
            }
            try! cellId.TableImageView.image = UIImage(data: Data(contentsOf: url))
        cellId.pokemonName.text = pokemons[indexPath.row].name
        cellId.pokemonNumber.text = String(pokemons[indexPath.row].number)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/5
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueProfile"){
            let VC = segue.destination as! ProfileViewController
            VC.pokemon = pokemonAt
            VC.faves = favorites
        }
        else if(segue.identifier == "favoritesSegue"){
            let VC2 = segue.destination as! FavoritesViewController
            VC2.favorites = self.favorites
        }
    }
    

}
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    //number of sections in the collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //number of cells in the given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        //indexPath helps identify row and section number in the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! PokemonCollectionViewCell
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        cell.awakeFromNib() //sets up image view
        return cell
    }
    
    //Creating a separate funciton allows for faster and smoother transition
    func collectionView(_ collectionView: UICollectionView, willDisplay cell:  UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let PokemonCell = cell as! PokemonCollectionViewCell
        //Sets images in correct section/rows of the view
        guard let url = URL(string: pokemons[indexPath.row].imageUrl) else {
            return
        }
        try! PokemonCell.PokemonImageView.image = UIImage(data: Data(contentsOf: url))
        
        PokemonCell.PokemonLabel.text = pokemons[indexPath.row].name
            
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width)/3, height: (view.frame.height)/5)
    }
    
    //select items
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath) as? PokemonCollectionViewCell
        if cell != nil {
//            cell!.isSelected = !cell!.isSelected
            if cell!.isSelected == true {
                pokemonAt = pokemons[indexPath.row]
                performSegue(withIdentifier: "segueProfile", sender: self)
            }
        }
    }
}

extension ListViewController: PokemonCollectionViewCellDelegate {
    func changeColorOfButton(forCell: PokemonCollectionViewCell) {
        if forCell.isSelected == true {
            forCell.PokemonImageView.alpha = 0.5
            
        } else {
            forCell.PokemonImageView.alpha = 1.0
            
        }
    }
}
