//
//  ImageTableViewCell.swift
//  Virindly
//
//  Created by Candice Ye on 10/12/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    var eventImageView: UIImageView!
    var eventLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Cell Background
        let cellBackground = UIImageView(image: #imageLiteral(resourceName: "bluegradient"))
        cellBackground.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        self.contentView.addSubview(cellBackground)
        
        // Event Image
        eventImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.height, height: contentView.frame.height))
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        
        // Event Label
        eventLabel = UILabel(frame: CGRect(x: contentView.frame.height + contentView.frame.height/20, y: contentView.frame.height + contentView.frame.height/20, width: contentView.frame.width - contentView.frame.height - contentView.frame.height/20, height: contentView.frame.height/2))
        eventLabel.clipsToBounds = true
        
        // Add Subviews
        contentView.addSubview(eventImageView)
        contentView.addSubview(eventLabel)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

