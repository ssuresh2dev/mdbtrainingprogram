//
//  ImageTableViewCell.swift
//  Virindly
//
//  Created by Candice Ye on 10/12/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import UIKit

// Protocol communicates between FeedViewController and ImageTableViewCell
protocol ImageTableViewCellDelegate {
    func changeToInterested(forCell: ImageTableViewCell)
}


class ImageTableViewCell: UITableViewCell {

    var eventImageView: UIImageView!
    var eventLabel: UILabel!
    var eventDescription: UILabel!
    
    
    override func awakeFromNib() {

        // Event Image
        eventImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.height, height: contentView.frame.height))
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        
        // Event Label
        eventLabel = UILabel(frame: CGRect(x: contentView.frame.height + contentView.frame.height/15, y: 0, width: contentView.frame.width - contentView.frame.height - contentView.frame.height/20, height: contentView.frame.height/2))
        eventLabel.font = UIFont.boldSystemFont(ofSize: 23)
        
        // Event description
        eventDescription = UILabel(frame: CGRect(x: contentView.frame.height + contentView.frame.height/15, y: contentView.frame.height * 0.12 , width: contentView.frame.width - contentView.frame.height - contentView.frame.height/20, height: contentView.frame.height * 0.75))
        eventDescription.clipsToBounds = true
        
        // Add Subviews
        contentView.addSubview(eventImageView)
        contentView.addSubview(eventLabel)
        contentView.addSubview(eventDescription)
        
        // Initialization code
    }



}

