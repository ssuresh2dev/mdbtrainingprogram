//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Vidya Ravikumar on 9/29/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    var pokemon : Pokemon!
    var pokemonImage : UIImageView!
    var name : UILabel!
    var number : UILabel!
    
    override func awakeFromNib() {
        pokemonImage = UIImageView(frame: CGRect(x: contentView.frame.width * 0.05, y: contentView.frame.width * 0.05, width: contentView.frame.width * 0.90, height: contentView.frame.height * 0.75))
        pokemonImage.contentMode = .scaleAspectFit
        pokemonImage.clipsToBounds = true
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.addSubview(pokemonImage) //adds UI elements to contentView and not cell itself
        
        name = UILabel(frame: CGRect(x: 0, y: contentView.frame.width * 0.05 + contentView.frame.height * 0.75, width: contentView.frame.width, height: 15))
        name.textAlignment = .center
        contentView.addSubview(name)
        
        number = UILabel(frame: CGRect(x: 0, y: contentView.frame.width * 0.05 + contentView.frame.height * 0.75 + 17.5, width: contentView.frame.width, height: 15))
        number.textAlignment = .center
        contentView.addSubview(number)
    }
}
