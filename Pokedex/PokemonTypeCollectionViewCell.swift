//
//  PokemonTypeCollectionViewCell.swift
//  Pokedex
//
//  Created by Vidya Ravikumar on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class PokemonTypeCollectionViewCell: UICollectionViewCell {
    
    var typeImage : UIImageView!
    var type : UILabel!
    
    override func awakeFromNib() {
        typeImage = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        typeImage.contentMode = .scaleAspectFit
        typeImage.clipsToBounds = true
        contentView.addSubview(typeImage)
        
        type = UILabel(frame: CGRect(x: 0, y: contentView.frame.height * 82.5, width: contentView.frame.width, height: contentView.frame.height * 0.15))
        type.textAlignment = .center
        type.textColor = UIColor.black
        contentView.addSubview(type)
    }
}
