//
//  ViewController.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

//test comment
import UIKit

class SearchViewController: UIViewController {

    struct typeObject {
        var typeName: String
        var typeSymbol: UIImage
    }
    var typesPressed: [Int]!
    var collectionView: UICollectionView!
    var minHlth: UILabel!
    var minAttk: UILabel!
    var typeArray = [UIImage(named: "normal"), UIImage(named: "fighting"), UIImage(named: "dragon"), UIImage(named: "water"), UIImage(named: "ice"), UIImage(named: "ghost"), UIImage(named: "fire"), UIImage(named: "steel"), UIImage(named: "rock"), UIImage(named: "dark"), UIImage(named: "electric"), UIImage(named: "poison"), UIImage(named: "bug"), UIImage(named: "fairy"), UIImage(named: "psychic"), UIImage(named: "flying"), UIImage(named: "grass"), UIImage(named: "ground")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
    }
    
    
    func collectionViewSetup(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 375, height: 750), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.register(TypeCollectionViewCell.self, forCellWithReuseIdentifier: "typeCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.layer.borderColor = UIColor.red.cgColor
        collectionView.layer.borderWidth = 2.0
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.allowsMultipleSelection = true
        collectionView.allowsSelection = true
        view.addSubview(collectionView)
        
        
        typesPressed = []
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        }

    }

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //number of sections in the collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //number of cells in the given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath)
            as! TypeCollectionViewCell
        cell.awakeFromNib()
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let typeCell = cell as! TypeCollectionViewCell
        typeCell.TypeImageView.image = typeArray[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath) as? TypeCollectionViewCell
        if cell != nil {
//            cell!.isSelected = !cell!.isSelected
            if cell!.isSelected == true {
                cell?.changeColor()
            }
        }
        typesPressed.append(indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TypeCollectionViewCell
        if cell != nil {
            if cell!.isSelected == false {
                cell?.changeColor()
            }
        }
    }
}
extension SearchViewController: TypeCollectionViewCellDelegate {
    func changeColorOfButton(forCell: TypeCollectionViewCell) {
        if forCell.isSelected == true {
            forCell.TypeImageView.alpha = 0.5

        } else {
            forCell.TypeImageView.alpha = 1.0

        }
    }
}




