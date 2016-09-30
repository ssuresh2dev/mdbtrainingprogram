//
//  ListCell.swift
//  Pokedex
//
//  Created by Jessica Chen on 9/29/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    var TableImageView: UIImageView!
    var pokemonName: UILabel!
    var pokemonNumber: UILabel!
    override func awakeFromNib() {
        TableImageView = UIImageView(frame: CGRect(x: contentView.frame.width/10, y: contentView.frame.height/10, width: contentView.frame.width/3, height: 4*contentView.frame.height/5))
        pokemonName = UILabel(frame: CGRect(x: contentView.frame.width/2, y: contentView.frame.height/2, width: contentView.frame.width/3, height: contentView.frame.height/6))
        pokemonNumber = UILabel(frame: CGRect(x: contentView.frame.width/2, y: contentView.frame.height/2 + contentView.frame.height/5, width: contentView.frame.width/3, height: contentView.frame.height/6))
        
        TableImageView.contentMode = .scaleAspectFit
        TableImageView.clipsToBounds = true
        contentView.addSubview(TableImageView)
        contentView.addSubview(pokemonName)
        contentView.addSubview(pokemonNumber)
        
        // Initialization code
    }


//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }

}


