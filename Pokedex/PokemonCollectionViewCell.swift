//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Eliot Han on 9/27/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    var pokemonImageView: UIImageView!
    var pokemonNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pokemonImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 25))
        contentView.addSubview(pokemonImageView)
        
        
        pokemonNameLabel = UILabel(frame: CGRect(x: frame.width - 100, y: frame.height - 28, width: 200, height: 30))
        pokemonNameLabel.font = UIFont(name: "SFUIText-Bold", size: 12.0)
        pokemonNameLabel.textColor = UIColor.blue
        contentView.addSubview(pokemonNameLabel)
        
    
    }
    
}
