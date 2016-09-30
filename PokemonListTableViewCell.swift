//
//  PokemonListTableViewCell.swift
//  Pokedex
//
//  Created by Rochelle on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {

    @IBOutlet weak var eachPokeImage: UIImageView!
    @IBOutlet weak var pokemonNum: UILabel!
    @IBOutlet weak var pokeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
