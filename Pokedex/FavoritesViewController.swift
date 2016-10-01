//
//  FavoritesViewController.swift
//  Pokedex
//
//  Created by Kevin Jiang on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    let tableView = UITableView(frame: CGRect(x: 25, y: 25, width: 350, height: 850))
    var selectedPoke: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(TableViewCell.self, forCellReuseIdentifier: "favCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = true
        tableView.isHidden = false
        
        view.addSubview(tableView)
        print(Global.favPokes.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        tableView.reloadData()
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

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    //TABLEVIEW STUFF
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.favPokes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
            as! TableViewCell
        
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let pokeCell = cell as! TableViewCell
        
        let pokemon = Global.favPokes[indexPath.row]
        if let url = NSURL(string: pokemon.imageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                pokeCell.pokeImage.image = UIImage(data: data as Data)
            }
        }
        
        pokeCell.pokeName.text = pokemon.name
        pokeCell.pokeNumber.text = "#" + String(pokemon.number)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPoke = Global.favPokes[indexPath.row]
        performSegue(withIdentifier: "toProfile", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
