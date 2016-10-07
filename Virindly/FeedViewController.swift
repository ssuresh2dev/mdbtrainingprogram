//
//  FeedViewController.swift
//  Virindly
//
//  Created by Candice Ye on 10/4/16.
//  Copyright © 2016 Ben Goldberg. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var posterArray: [String]!
    var nameArray: [String]!
    var imageArray: [UIImage]!
    var interestedArray: [Int]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

class FeedTableViewCell: UITableViewCell {
    
    var posterLabel: String!
    var nameLabel: String!
    var eventImage: UIImage!
    var interestedLabel: Int!
    
    override func awakeFromNib() {
        let imageView = UIImageView()
        
        posterLabel = UILabel(frame: <#T##CGRect#>)
        interestedLabel = UILabel(frame: <#T##CGRect#>)
        nameLabel = UILabel(frame: <#T##CGRect#>)
        imageView.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        
        addSubview(posterLabel)
        addSubview(interestedLabel)
        addSubview(nameLabel)
        addSubview(imageView)
        
        eventImage = UIImage(named: <#T##String#>)
    }
    
}
