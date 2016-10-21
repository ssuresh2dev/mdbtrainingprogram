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
    var titleLabel: UILabel!
    var rsvpLabel: UILabel!
    var posterLabel: UILabel!
    var backgroundImage: UIImage!
    
    
    var rsvpButton: UIButton!
    var delegate: EventTableViewCellDelegate? = nil
    
    
    var event: Event?
    
    override func awakeFromNib() {        
        backgroundClear = UIImageView(frame: CGRect(x: 38, y: 12.5, width: 300, height: 57))
        backgroundClear.image = #imageLiteral(resourceName: "ClearBacking")
        backgroundClear.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(backgroundClear)
        
        
        defaultPostLabel = UIImageView(frame: CGRect(x: 47, y: 48.5, width: 60, height: 17))
        defaultPostLabel.image = #imageLiteral(resourceName: "PostedBy")
        defaultPostLabel.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(defaultPostLabel)
        
        titleLabel = MDBSocialsUtils.makeLabel(frame: CGRect(x: 48, y: 17.5, width: 225, height: 29))
        titleLabel.font = UIFont(name: "Bebas", size: 22)
        contentView.addSubview(titleLabel)
        
        rsvpLabel = UILabel(frame: CGRect(x: 281, y: 17.5, width: 100, height: 38))
        rsvpLabel.textAlignment = NSTextAlignment.right
        rsvpLabel.font = UIFont(name: "Avenir-Book", size: 28)
        contentView.addSubview(rsvpLabel)
        
        
        rsvpButton = UIButton(frame: CGRect(x: 281, y: 17.5, width: 100, height: 38))
        rsvpButton.addTarget(self, action:#selector(rsvp), for: .touchUpInside)
        contentView.addSubview(rsvpButton)

        posterLabel = UILabel(frame:CGRect(x: 112, y: 48, width: 167, height: 16))
        posterLabel.textAlignment = NSTextAlignment.left
        posterLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        contentView.addSubview(posterLabel)
        
        
        super.awakeFromNib()
        // Initialization code
    }
    func rsvp(){
        print("buttonclicked")
        delegate?.rsvp(cell : self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
