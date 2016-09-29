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
        contentView.addSubview(TypeImageView)
        
        //initiates button for each collection view cell. --> changes color when pressed.
//        button = UIButton(frame: CGRect(x:0 , y: 0, width:125, height: 125))
//        button.setTitle("", for: .normal)
////        button.backgroundColor = UIColor.blue
//        button.layer.cornerRadius = 3
//        button.clipsToBounds = true
//        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)

//        contentView.addSubview(button)
    }
    
    func changeColor() {
        print("changing color")
        delegate?.changeColorOfButton(forCell: self)
    }
}
