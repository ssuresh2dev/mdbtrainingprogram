//
//  memberCell.swift
//  MDBSocials
//
//  Created by Jessica Chen on 10/21/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import Foundation
import UIKit

class MemberCell: UITableViewCell {
    
    var profPic: UIImageView!
    var memberName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        memberName = UILabel(frame: CGRect(x: contentView.frame.width/3 + 20, y: 30, width: contentView.frame.width * 2/3 - 40, height: 20))
        memberName.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        memberName.adjustsFontSizeToFitWidth = true
        memberName.numberOfLines = 1
        contentView.addSubview(memberName)
        
        profPic = UIImageView(frame: CGRect(x: 10, y: 10, width: contentView.frame.width/3 - 20, height: contentView.frame.height - 20))
        profPic.contentMode = .scaleAspectFit
        profPic.clipsToBounds = true
        contentView.addSubview(profPic)
        
    }
    
}
