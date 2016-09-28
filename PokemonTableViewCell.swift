//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Eliot Han on 9/26/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    var pokemonImageView: UIImageView!
    var pokemonNameLabel: UILabel!
    var pokemonNumberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pokemonImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 50, height: 50))
        contentView.addSubview(pokemonImageView)
        
        
        pokemonNameLabel = UILabel(frame: CGRect(x: frame.width - 100, y: frame.height/2 - 17, width: 200, height: 20))
        pokemonNameLabel.font = UIFont(name: "SFUIText-Bold", size: 14.0)
        contentView.addSubview(pokemonNameLabel)
        
        
        pokemonNumberLabel = UILabel(frame: CGRect(x: frame.width - 100, y: frame.height/2 + 17, width: 60, height: 20))
        pokemonNumberLabel.font = UIFont(name: "SFUIText-Bold", size: 14.0)
        contentView.addSubview(pokemonNumberLabel)
        
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
