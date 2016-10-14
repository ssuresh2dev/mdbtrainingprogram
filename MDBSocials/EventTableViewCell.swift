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
    var rsvpLabel: UILabel!
    var posterLabel: UILabel!
    
    override func awakeFromNib() {
        backgroundClear = UIImageView(frame: CGRect(x: 38, y: 12.5, width: 300, height: 57))
        backgroundClear.image = #imageLiteral(resourceName: "ClearBacking")
        backgroundClear.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(backgroundClear)
        

        defaultPostLabel = UIImageView(frame: CGRect(x: 25, y: 50, width: 50, height: 17))
        defaultPostLabel.image = #imageLiteral(resourceName: "PostedBy")
        defaultPostLabel.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(defaultPostLabel)
        

        titleName = UILabel(frame: CGRect(x: 25, y: 20, width: 225, height: 29))
        //titleName = UILabel(frame: CGRect(x: 25, y: 20, width: 225, height: 29))

        
        titleName.textAlignment = NSTextAlignment.left
        titleName.font = UIFont(name: "Bebas", size: 22)
        //titleName.font = UIFont(name: "AvenirNext-Regular", size: 22)
        contentView.addSubview(titleName)
        
        rsvpLabel = UILabel(frame: CGRect(x: contentView.frame.width - 30, y: 28.5, width: 50, height: 38))
        contentView.addSubview(rsvpLabel)
        
<<<<<<< HEAD
        posterLabel = UILabel(frame:CGRect(x: 113, y: 129, width: 167, height: 16))
=======
        posterLabel = UILabel(frame:CGRect(x: 140, y: 45, width: 167, height: 16))
>>>>>>> e949831e258e800ac8a3f1d7b9761620ede411ba
        posterLabel.textAlignment = NSTextAlignment.left
        posterLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        contentView.addSubview(posterLabel)
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
