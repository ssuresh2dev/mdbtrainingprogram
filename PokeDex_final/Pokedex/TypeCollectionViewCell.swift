 //
//  TypeCollectionViewCell.swift
//  Pokedex
//
//  Created by Jessica Chen on 9/27/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

 protocol TypeCollectionViewCellDelegate {
    func changeColorOfButton(forCell: TypeCollectionViewCell)
 }
 
class TypeCollectionViewCell: UICollectionViewCell {
    var TypeImageView: UIImageView!
    var button: UIButton!
    var delegate: TypeCollectionViewCellDelegate? = nil
    
    override func awakeFromNib(){
        TypeImageView = UIImageView(frame: contentView.frame)
        TypeImageView.contentMode = .scaleAspectFill
        TypeImageView.clipsToBounds = true
        TypeImageView.layer.borderColor = UIColor.white.cgColor
        TypeImageView.layer.borderWidth = 0.5
        contentView.addSubview(TypeImageView)
    }
    
    func changeColor() {
        delegate?.changeColorOfButton(forCell: self)
    }
}
