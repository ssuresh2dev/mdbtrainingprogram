//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Mohit Katyal on 9/29/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    
    var CollectionView: UICollectionView!
    var pictureArray = [UIImage(named : "normal"), UIImage(named : "fighting")] //Still needs link to searched catagories to upload images of selected array

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        // Do any additional setup after loading the view.
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView(){
        
        
        let layout = UICollectionViewFlowLayout()
        CollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        CollectionView.backgroundColor = UIColor.white
        CollectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "PokemonCell")
        view.addSubview(CollectionView)
        CollectionView.delegate = self
        CollectionView.dataSource = self
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
}

    extension PokemonViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
        
        //number of sections in the collectionView
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        //number of cells in the given section
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return pictureArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
            
            //indexPath helps identify row and section number in the cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! PokemonCollectionViewCell
            
                cell.awakeFromNib() //sets up image view
                return cell
                }
        
        //Creating a separate funciton allows for faster and smoother transition
        func collectionView(_ collectionView: UICollectionView, willDisplay cell:  UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let PokemonCell = cell as! PokemonCollectionViewCell
            //Sets images in correct section/rows of the view
            PokemonCell.PokemonImageView.image = pictureArray[indexPath.row]
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (view.frame.width)/3, height: (view.frame.height)/5)
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



