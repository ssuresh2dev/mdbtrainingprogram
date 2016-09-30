//
//  PokemonTypeViewController.swift
//  Pokedex
//
//  Created by Eliot Han on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class PokemonTypeViewController: UIViewController {

    var tableView: UITableView! = UITableView()
    let pokemonTypes: [String] = ["Bug","Grass","Dark","Ground","Dragon","Ice","Electric","Normal","Fairy","Poison", "Fighting","Psychic","Fire","Rock","Flying","Steel","Ghost","Water"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func setupTableView(){
        tableView.frame = CGRect(x: 0, y: 10, width: view.frame.width, height: view.frame.height)
        tableView = UITableView(frame: tableView.frame)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length + 150, 0)  //this is to prevent tab bar from hiding last cell
        
        tableView.rowHeight = 80
        tableView.backgroundColor = UIColor.white
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView!)
    }
    

}

extension PokemonTypeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        self.tableView?.rowHeight = 80
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let typeCell = cell as! CategoryTableViewCell
        typeCell.categoryLabel.text = pokemonTypes[indexPath.row]
        //for labels
        
    }
    

    
    
    
}
