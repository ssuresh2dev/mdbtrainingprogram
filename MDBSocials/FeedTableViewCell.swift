//
//  FeedTableViewCell.swift
//  MDBSocials
//
//  Created by Shubham Goenka on 05/10/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    var eventPictureImageView: UIImageView!
    var eventName: UILabel!
    var numRSVP: UILabel!
    var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        eventName = UILabel(frame: CGRect(x: contentView.frame.width/2, y: contentView.frame.height/3, width: contentView.frame.width/3, height: contentView.frame.height/5))
        eventName.text = "eventName"
        contentView.addSubview(eventName)
        
        numRSVP = UILabel(frame: CGRect(x: contentView.frame.width/2, y: contentView.frame.height/3 + contentView.frame.height/4, width: contentView.frame.width, height: contentView.frame.height/5))
        numRSVP.text = "number of RSVPs"
        contentView.addSubview(numRSVP)
        
        date = UILabel(frame: CGRect(x: contentView.frame.width/2, y: contentView.frame.height/3 + contentView.frame.height/2, width: contentView.frame.width, height: contentView.frame.height/5))
        date.text = "Date"
        contentView.addSubview(date)
        
        eventPictureImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width/3, height: contentView.frame.height))
        eventPictureImageView.contentMode = .scaleAspectFit
        eventPictureImageView.clipsToBounds = true
        
        contentView.addSubview(eventPictureImageView)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
