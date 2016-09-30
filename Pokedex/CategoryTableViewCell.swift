//
//  CategoryTableViewCell.swift
//  Pokedex
//
//  Created by Eliot Han on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    var categoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoryLabel = UILabel(frame: CGRect(x: 30, y: frame.height/2, width: 200, height: 20))
        categoryLabel.font = UIFont(name: "SFUIText-Bold", size: 14.0)
        contentView.addSubview(categoryLabel)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
