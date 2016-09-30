//
//  ButtonCell.swift
//  Pokedex
//
//  Created by Kevin Jiang on 9/29/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ButtonCell: UICollectionViewCell {
    var button: UIButton!
    
    override func awakeFromNib() {
        //foodImageView = UIImageView(frame: contentView.frame)
        //foodImageView.contentMode = .scaleAspectFill
        //foodImageView.clipsToBounds = true
        //contentView.addSubview(foodImageView) //Remember to add UI elements to the contentView, not the cell itself
        
        button = UIButton(frame: CGRect(x: (contentView.frame.width - 70)/2, y: (contentView.frame.height - 40)/2, width: 70, height: 40))
        button.backgroundColor = UIColor.green
        button.setTitle("Sup", for: .normal)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        //button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        contentView.addSubview(button)
    }
}
