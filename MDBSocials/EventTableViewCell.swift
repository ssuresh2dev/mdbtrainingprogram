//
//  EventTableViewCell.swift
//  MDBSocials
//
//  Created by Eliot Han on 10/5/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    var backgroundClear: UIImageView!
    var defaultPostLabel: UIImageView!
    var titleName: UILabel!
    var numInterest: UILabel!
    
    override func awakeFromNib() {
        backgroundClear = UIImageView(frame: CGRect(x: 38, y: 17.5, width: 300, height: 57))
        backgroundClear.image = #imageLiteral(resourceName: "ClearBacking")
        backgroundClear.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(backgroundClear)
        
        defaultPostLabel = UIImageView(frame: CGRect(x: 47, y: 50.5, width: 60, height: 17))
        defaultPostLabel.image = #imageLiteral(resourceName: "PostedBy")
        defaultPostLabel.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(defaultPostLabel)
        
        titleName = UILabel(frame: CGRect(x: 48, y: 21.5, width: 225, height: 29))
        titleName.textAlignment = NSTextAlignment.left
        contentView.addSubview(titleName)
        
        numInterest = UILabel(frame: CGRect(x: 281, y: 28.5, width: 50, height: 38))
        contentView.addSubview(numInterest)
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
