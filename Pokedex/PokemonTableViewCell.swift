//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Vidya Ravikumar on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    var pokemon : Pokemon!
    var pokemonImage : UIImageView!
    var name : UILabel!
    var number : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pokemonImage = UIImageView(frame: CGRect(x: 5, y: 5, width: contentView.frame.width * 0.20, height: contentView.frame.height * 0.9))
        pokemonImage.contentMode = .scaleAspectFit
        pokemonImage.clipsToBounds = true
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.addSubview(pokemonImage) //adds UI elements to contentView and not cell itself
        
        name = UILabel(frame: CGRect(x: 10 + (contentView.frame.width * 0.2), y: 5, width: (contentView.frame.width * 0.8) - 10, height: (contentView.frame.height - 7.5) / 2))
        name.textAlignment = .center
        contentView.addSubview(name)
        
        number = UILabel(frame: CGRect(x: 10 + (contentView.frame.width * 0.2), y: (contentView.frame.height - 2.5) / 2, width: (contentView.frame.width * 0.8) - 10, height: (contentView.frame.height - 7.5) / 2))
        number.textAlignment = .center
        contentView.addSubview(number)
    }
}
