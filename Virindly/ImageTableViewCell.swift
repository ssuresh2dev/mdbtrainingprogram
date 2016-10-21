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
    var eventPoster: UILabel!
    var eventDate: UILabel!
    var rsvpButton: UIButton!
    var numAttendees: UILabel!
    
    override func awakeFromNib() {

        // Event Image
        eventImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.height, height: contentView.frame.height))
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        
        // Event Label (Name)
        eventLabel = UILabel(frame: CGRect(x: contentView.frame.height + contentView.frame.height/15, y: 0, width: contentView.frame.width - contentView.frame.height - contentView.frame.height/20, height: contentView.frame.height/2))
        eventLabel.clipsToBounds = true
        eventLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventLabel.numberOfLines = 0
        eventLabel.minimumScaleFactor = 0.5
        eventLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
        eventLabel.adjustsFontSizeToFitWidth = true
        
        
        // Event Poster
        eventPoster = UILabel(frame: CGRect(x: contentView.frame.height + contentView.frame.height/15, y: contentView.frame.height/2 - 17, width: contentView.frame.width - contentView.frame.height - contentView.frame.height/20, height: 17))
        eventPoster.clipsToBounds = true
        eventPoster.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventPoster.numberOfLines = 0
        eventPoster.minimumScaleFactor = 0.5
        eventPoster.font = UIFont(name: "AvenirNext", size: 11)
        // eventPoster.textColor = UIColor.darkGray
        eventPoster.adjustsFontSizeToFitWidth = true
        
        
        // Event Date
        eventDate = UILabel(frame: CGRect(x: contentView.frame.height + contentView.frame.height/15, y: contentView.frame.height/2 + 5, width: contentView.frame.width - contentView.frame.height - contentView.frame.height/20, height: 17))
        eventDate.clipsToBounds = true
        eventDate.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventDate.numberOfLines = 0
        eventDate.minimumScaleFactor = 0.5
        eventDate.font = UIFont(name: "AvenirNext", size: 11)
        eventDate.textColor = UIColor.darkGray
        eventDate.adjustsFontSizeToFitWidth = true
        
        
        
        // RSVP Button
        rsvpButton = UIButton(frame: CGRect(x: contentView.frame.height + contentView.frame.height/15, y: contentView.frame.height - contentView.frame.height * 0.3 + 3, width: contentView.frame.width/6, height: contentView.frame.height/6))
        rsvpButton.backgroundColor = UIColor.white.withAlphaComponent(0.40)
        rsvpButton.setTitle("RSVP", for: .normal)
        rsvpButton.setTitle("RSVP'ed!", for: .selected)
        rsvpButton.titleLabel!.font = UIFont(name: "AvenirNext", size: 12)
        rsvpButton.layer.cornerRadius = 5
        // rsvpButton.addTarget(self, action: #selector(changeToInterested), for: .touchUpInside)
        
        
        // # People RSVP'd
        numAttendees = UILabel(frame: CGRect(x: contentView.frame.height + contentView.frame.height/15 + contentView.frame.width/6 + 3, y: contentView.frame.height - contentView.frame.height * 0.3 + 3, width: contentView.frame.width - contentView.frame.height, height: 17))
        numAttendees.clipsToBounds = true
        numAttendees.lineBreakMode = NSLineBreakMode.byWordWrapping
        numAttendees.numberOfLines = 0
        numAttendees.minimumScaleFactor = 0.5
        numAttendees.textColor = UIColor.white
        numAttendees.font = UIFont(name: "AvenirNext", size: 8)
        numAttendees.adjustsFontSizeToFitWidth = true
        numAttendees.text = "\(10) people interested" // Temporary data
        
        // Add Subviews
        contentView.addSubview(eventImageView)
        contentView.addSubview(eventLabel)
        contentView.addSubview(eventPoster)
        contentView.addSubview(eventDate)
        contentView.addSubview(rsvpButton)
        contentView.addSubview(numAttendees)
        // Initialization code
    }

}

