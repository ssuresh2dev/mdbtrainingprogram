//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Jessica Chen on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

protocol PokemonCollectionViewCellDelegate {
    func changeColorOfButton(forCell: PokemonCollectionViewCell)
}


class PokemonCollectionViewCell: UICollectionViewCell {
    var PokemonImageView: UIImageView!
    var PokemonLabel: UILabel!
    var delegate: PokemonCollectionViewCellDelegate? = nil

    
    override func awakeFromNib() { //like the image load of CollectionViews
        PokemonImageView = UIImageView(frame: CGRect(x: 0, y: (contentView.frame.height)/3, width: contentView.frame.width*0.75, height: contentView.frame.height*0.65)) //Sets image to fill cell
        PokemonImageView.contentMode = .scaleAspectFit
        PokemonImageView.clipsToBounds = true
        
        contentView.addSubview(PokemonImageView)//add UIelements to the contentView, not cell
        
        PokemonLabel = UILabel(frame: CGRect(x: 0, y: (contentView.frame.height), width: contentView.frame.width, height: (contentView.frame.height)*0.25))
        
        contentView.addSubview(PokemonLabel)
        PokemonLabel.font = UIFont(name: "SFUIText-Bold" , size: 14.0)
    }
    
    func changeColor() {
        delegate?.changeColorOfButton(forCell: self)
    }
}
