//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Kevin Jiang on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var pokemon: Pokemon? = nil
    let picture = UIImageView(frame: CGRect(x: 30, y: 300, width: 100, height: 100))
    
    let name = UILabel(frame: CGRect(x: 5, y: 265, width: 300, height: 15))
    let number = UILabel(frame: CGRect(x: 5, y: 245, width: 200, height: 15))
    let attack = UILabel(frame: CGRect(x: 5, y: 225, width: 200, height: 15))
    let defense = UILabel(frame: CGRect(x: 5, y: 65, width: 200, height: 15))
    let health = UILabel(frame: CGRect(x: 5, y: 85, width: 200, height: 15))
    let specialAttack = UILabel(frame: CGRect(x: 5, y: 105, width: 200, height: 15))
    let specialDefense = UILabel(frame: CGRect(x: 5, y: 125, width: 200, height: 15))
    let species = UILabel(frame: CGRect(x: 5, y: 145, width: 300, height: 15))
    let speed = UILabel(frame: CGRect(x: 5, y: 165, width: 200, height: 15))
    let total = UILabel(frame: CGRect(x: 5, y: 185, width: 200, height: 15))
    let types = UILabel(frame: CGRect(x: 5, y: 205, width: 200, height: 15))
    
    let addToFav = UIButton(frame: CGRect(x: 100, y: 225, width: 200, height: 15))
    let searchWeb = UIButton(frame: CGRect(x: 100, y: 245, width: 200, height: 15))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addToFav.setTitle("Add to Favorites", for: .normal)
        addToFav.setTitleColor(UIColor.black, for: .normal)
        
        if Global.favPokes.contains(pokemon!) {
            addToFav.setTitle("Favorited", for: .normal)
        }
        
        addToFav.addTarget(self, action: #selector(self.favorite), for: .touchUpInside)
        searchWeb.setTitle("Search on the Web", for: .normal)
        searchWeb.setTitleColor(UIColor.black, for: .normal)
        searchWeb.addTarget(self, action: #selector(self.toWeb), for: .touchUpInside)
        
        view.addSubview(picture)
        view.addSubview(name)
        view.addSubview(number)
        view.addSubview(attack)
        view.addSubview(defense)
        view.addSubview(health)
        view.addSubview(specialAttack)
        view.addSubview(specialDefense)
        view.addSubview(species)
        view.addSubview(speed)
        view.addSubview(total)
        view.addSubview(types)
        view.addSubview(addToFav)
        view.addSubview(searchWeb)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toWeb() {
        performSegue(withIdentifier: "toWeb", sender: self)
    }
    
    func favorite(sender: UIButton) {
        if sender.title(for: .normal) == "Add to Favorites" {
            sender.setTitle("Favorited", for: .normal)
            Global.favPokes.append(pokemon!)
        } else if sender.title(for: .normal) == "Favorited" {
            sender.setTitle("Add to Favorites", for: .normal)
            Global.favPokes.remove(at: Global.favPokes.index(of: pokemon!)!)
        }
    }
    
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
                //return true
            }
        }
        return false
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeb" {
            if let destination = segue.destination as? WebViewController {
                let pokeName = name.text!.substring(from: name.text!.index(name.text!.startIndex, offsetBy: 6))
                var canOpen = verifyUrl(urlString: "https://google.com/search?q=" + pokeName)
                if canOpen == true {
                    var request = NSURLRequest(url: NSURL(string: "https://google.com/search?q=" + pokeName) as! URL) as URLRequest?
                    destination.webV.loadRequest(request!)
                } else {
                    destination.webV.loadRequest(NSURLRequest(url: NSURL(string: "https://google.com/") as! URL) as URLRequest)
                }
            }
        }
        
    }
    
    

}
