//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Candice Ye on 9/28/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var searchName: UILabel!
    @IBOutlet weak var searchNumber: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var HP: UITextField!
    @IBOutlet weak var attack: UITextField!
    @IBOutlet weak var defense: UITextField!
    
    @IBOutlet weak var typesCollectionView: UICollectionView!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var typeText: UILabel!
    
    @IBOutlet weak var randomizePoke: UIButton!
    
    struct elements {
        var elementType: String
    }
    var allElements: [elements] = []
    
    var diffElements: [String] = ["Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Posion", "Psychic", "Rock", "Steel", "Water"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        typesCollectionView.delegate = self
        typesCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diffElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let eachCell = collectionView.dequeueReusableCell(withReuseIdentifier: "eachButton", for: indexPath) as! TypesButtonCollectionViewCell
        eachCell.eachType.text = diffElements[indexPath.item]
        return eachCell
        
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

}
