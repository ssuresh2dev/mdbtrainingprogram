//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Candice Ye on 9/28/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var topNav: UINavigationItem!
    let imageView = UIImageView(image: #imageLiteral(resourceName: "Pokedex"))
    
    @IBOutlet weak var typesCollectionView: UICollectionView!

    @IBOutlet weak var randomizer: UIButton!
    
    struct elements {
        var elementType: String
    }
    var allElements: [elements] = []
    
    var fontElements: [UIColor] = [UIColor.white, UIColor.white, UIColor.white, UIColor.black, UIColor.white, UIColor.white, UIColor.white, UIColor.black, UIColor.white, UIColor.white, UIColor.black, UIColor.white, UIColor.white, UIColor.white, UIColor.white, UIColor.white, UIColor.white, UIColor.white]
    var imageElements: [UIImage] = [#imageLiteral(resourceName: "bug"), #imageLiteral(resourceName: "dark"), #imageLiteral(resourceName: "dragon"), #imageLiteral(resourceName: "electric"), #imageLiteral(resourceName: "fairy"), #imageLiteral(resourceName: "fighting"), #imageLiteral(resourceName: "fire"), #imageLiteral(resourceName: "flying"), #imageLiteral(resourceName: "ghost"), #imageLiteral(resourceName: "grass"), #imageLiteral(resourceName: "ground"), #imageLiteral(resourceName: "ice"), #imageLiteral(resourceName: "normal"), #imageLiteral(resourceName: "poison"), #imageLiteral(resourceName: "psychic"), #imageLiteral(resourceName: "rock"), #imageLiteral(resourceName: "steel"), #imageLiteral(resourceName: "water")]
    var diffElements: [String] = ["Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Psychic", "Rock", "Steel", "Water"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        typesCollectionView.delegate = self
        typesCollectionView.dataSource = self
        
        randomizer.setBackgroundImage(#imageLiteral(resourceName: "Randomizeme"), for: .normal)
        topNav.titleView = imageView
    }
    
    //number of rows
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diffElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let eachCell = collectionView.dequeueReusableCell(withReuseIdentifier: "eachButton", for: indexPath) as! TypesButtonCollectionViewCell
        eachCell.backgroundColor = UIColor.blue
        eachCell.element.setBackgroundImage(imageElements[indexPath.item], for: .normal)
        eachCell.element.setTitle(diffElements[indexPath.item], for: .normal)
        eachCell.element.setTitleColor(fontElements[indexPath.item], for: .normal)
        return eachCell
        
    }
    
    /*func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //let cl = cell as! TypesButtonCollectionViewCell
        //cl.eachType.text = diffElements[indexPath]
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func temporarySegueToDetailsPage(_ sender: AnyObject) {
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
