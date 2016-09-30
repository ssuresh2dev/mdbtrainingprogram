//
//  ListGridViewController.swift
//  Pokedex
//
//  Created by Candice Ye on 9/28/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ListGridViewController: UIViewController {
    
    // Static Variables
    var grid: UICollectionView!
    var amountPokemon: Int!
    var pokemonArray = PokemonGenerator.getPokemonArray()
    // var myPokemon: UIImageView! Abhi's suggestion
    var pokemonImages = [UIImage(named: "pikachu"), UIImage(named: "piplup")]
    
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white

        // Initializing
        let segmentedControl = UISegmentedControl()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.insertSegment(withTitle: "List", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Grid", at: 1, animated: true)
        segmentedControl.addTarget(self, action: Selector(("segment:")), for: .touchUpInside)
        
        // Setting up a frame and Segmented Control
        segmentedControl.frame = CGRect(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height/9, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/20)
        
        // Editing the Segmented Control
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = UIColor.gray
        segmentedControl.tintColor = UIColor.white

        
        // Add this custom Segmented Control to our view
        self.view.addSubview(segmentedControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*  Abhi's suggestion
        let url = NSURL(string: pokemonArray[0].imageUrl)
        let data = NSData(contentsOfURL: url!)
        myPokemon.image = UIImage(data: data!)
         */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Functions
    func selectSegment(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            print("List View has been selected.")
        }
        else if sender.selectedSegmentIndex == 1 {
            print("Grid View has been selected.")
        }
    }
    
    // Append Pokemon Images to Array pokemonImages
    /*
    func appendPokemonImageToArray() {
        for pokemonIndex in 0...pokemonArray.count {
            pokemonImages.append(pokemonArray[pokemonIndex].imageUrl)
        }
    }
    */
    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
/*
extension ListGridViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return.pokemonImages.count
    }
    
    
}
 */

