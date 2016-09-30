//
//  TableViewCell.swift
//  Pokedex
//
//  Created by Kevin Jiang on 9/29/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var pokeImage: UIImageView!
    var pokeName: UILabel!
    var pokeNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        pokeName = UILabel(frame: CGRect(x: (contentView.frame.width - 200)/2, y: (contentView.frame.height - 40)/2, width: 250, height: 40))
        pokeName.font = UIFont(name: pokeName.font.fontName, size: 13.0)
        pokeImage = UIImageView(frame: CGRect(x: 0, y: (contentView.frame.height - 50)/2, width: 50, height: 50))
        pokeNumber = UILabel(frame: CGRect(x: contentView.frame.width - 70, y: (contentView.frame.height - 40)/2, width: 50, height: 40))
        //pokeName.layer.borderColor = UIColor.black.cgColor
        //pokeName.layer.borderWidth = 1
        
        pokeImage.layer.borderColor = UIColor.black.cgColor
        //pokeImage.layer.borderWidth = 3
        contentView.addSubview(pokeImage)
        contentView.addSubview(pokeName)
        contentView.addSubview(pokeNumber)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
