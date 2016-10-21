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
    var interestedButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        interestedButton = UIButton(frame: CGRect(x: contentView.frame.width/3 + 20, y: 115, width: contentView.frame.width * 2/3 - 40, height: 20))
        interestedButton.backgroundColor = themeColor
        interestedButton.setTitle("Interested", for: .normal)
//        interestedButton.addTarget(self, action: #selector(modifyPeople), for: .touchUpInside)
        contentView.addSubview(interestedButton)
        
        eventName = UILabel(frame: CGRect(x: contentView.frame.width/3 + 20, y: 30, width: contentView.frame.width * 2/3 - 40, height: 20))
        eventName.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        eventName.adjustsFontSizeToFitWidth = true
        eventName.numberOfLines = 1
        contentView.addSubview(eventName)
        
        numRSVP = UILabel(frame: CGRect(x: contentView.frame.width/3 + 20, y: 60, width: contentView.frame.width * 2/3 - 40, height: 20))
        numRSVP.font = UIFont(name: "HelveticaNeue", size: 16.0)
        numRSVP.adjustsFontSizeToFitWidth = true
        numRSVP.numberOfLines = 1
        contentView.addSubview(numRSVP)
        
        date = UILabel(frame: CGRect(x: contentView.frame.width/3 + 20, y: 90, width: contentView.frame.width * 2/3 - 40, height: 20))
        date.font = UIFont(name: "HelveticaNeue", size: 16.0)
        date.adjustsFontSizeToFitWidth = true
        date.numberOfLines = 1
        contentView.addSubview(date)
        
        let expandLabel = UILabel(frame: CGRect(x: contentView.frame.width/3 + 20, y: 130, width: contentView.frame.width * 2/3 - 40, height: 20))
        expandLabel.text = "(Click to see more)"
        expandLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        expandLabel.adjustsFontSizeToFitWidth = true
        expandLabel.textAlignment = NSTextAlignment.right
        expandLabel.numberOfLines = 1
        contentView.addSubview(expandLabel)
        
        eventPictureImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: contentView.frame.width/3 - 20, height: contentView.frame.height - 20))
        eventPictureImageView.contentMode = .scaleAspectFit
        eventPictureImageView.clipsToBounds = true
        contentView.addSubview(eventPictureImageView)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
