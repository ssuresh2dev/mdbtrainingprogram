//
//  CollectionViewCell.swift
//  Pokedex
//
//  Created by Kevin Jiang on 9/28/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var image: UIImageView!
    var name: UILabel!
    
    override func awakeFromNib() {
        
        image = UIImageView(frame: CGRect(x: (contentView.frame.width - 60)/2, y: (contentView.frame.height - 60)/2, width: 60, height: 60))
        name = UILabel(frame: CGRect(x: 0, y: contentView.frame.height - 10, width: 70, height: 10))
        name.font = UIFont(name: name.font.fontName, size: 12)
        contentView.addSubview(image)
        contentView.addSubview(name)
    }
}
