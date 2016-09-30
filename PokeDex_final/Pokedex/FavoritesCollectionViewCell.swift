//
//  FavoritesCollectionViewCell.swift
//  Pokedex
//
//  Created by Mohit Katyal on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//
import UIKit
class FavoritesCollectionViewCell: UICollectionViewCell {
    
    var PokemonImageView: UIImageView!
    var PokemonLabel: UILabel!
    
    
    override func awakeFromNib() { //like the image load of CollectionViews
        PokemonImageView = UIImageView(frame: CGRect(x: 0, y: (contentView.frame.height)/3, width: contentView.frame.width, height: contentView.frame.height*0.75)) //Sets image to fill cell
        PokemonImageView.contentMode = .scaleAspectFit
        PokemonImageView.clipsToBounds = true
        
        contentView.addSubview(PokemonImageView)//add UIelements to the contentView, not cell
        
        PokemonLabel = UILabel(frame: CGRect(x: 0, y: (contentView.frame.height), width: contentView.frame.width, height: (contentView.frame.height)*0.25))
        
        contentView.addSubview(PokemonLabel)
        PokemonLabel.font = UIFont(name: "SFUIText-Bold" , size: 14.0)
    }
}
