//
//  DisplayNameTableViewCell.swift
//  MDBSocials
//
//  Created by Rochelle on 10/20/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit

class DisplayNameTableViewCell: UITableViewCell {
    
    var displayName: UILabel!

    override func awakeFromNib() {
        displayName = UILabel(frame: CGRect(x: 30, y: 17.5, width: 225, height: 29))
        displayName.textAlignment = NSTextAlignment.left
        displayName.font = UIFont(name: "Avenir-Book", size: 28)
        displayName.textColor = UIColor(red:0.60, green:0.83, blue:0.82, alpha:1.0)
        contentView.addSubview(displayName)
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
