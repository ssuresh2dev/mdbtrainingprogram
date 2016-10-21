//
//  RSVPViewController.swift
//  MDBSocials
//
//  Created by Shubham Goenka on 19/10/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit
import Firebase

class RSVPViewController: UIViewController {
    
    var event: Event!
    var membersInterested: [String] = []
    var listUrls: [String] = []
    var listUIDs: [String] = []
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupTableView()
        membersInterested = []
    
        let eventRef = FIRDatabase.database().reference().child("events").child((event.eventID)!)
        eventRef.child("usersInterested").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue?["name"] as? String
            let photoUrl = snapshotValue?["photoUrl"] as? String
            let uid = snapshotValue?["uid"] as? String
            
            self.membersInterested.insert(name!, at: 0)
            self.listUrls.insert(photoUrl!, at: 0)
            self.listUIDs.insert(uid!, at: 0)
            
            
            
            
            
        })
        tableView?.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        
        tableView = UITableView(frame: CGRect(x: 0, y: view.frame.height * 0.1 + 10, width: view.frame.width, height: view.frame.height * 0.9))
        tableView?.register(FeedTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView?.rowHeight = 80
        tableView?.backgroundColor = UIColor.white
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
    }
    
    func setUI() {
        
        view.backgroundColor = UIColor.white
        
        let backButton = UIButton(frame: CGRect(x: view.frame.width * 0, y: 0, width: view.frame.width * 0.2, height: view.frame.height * 0.1 ))
        backButton.setTitle("Back", for: .normal)
        backButton.backgroundColor = themeColor
        backButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        backButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        backButton.clipsToBounds = true
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        let titleLabel = UILabel(frame: CGRect(x: view.frame.width * 0.2, y: 0, width: view.frame.width * 0.6, height: view.frame.height * 0.1))
        titleLabel.text = "People Interested"
        titleLabel.textColor = UIColor.white
        titleLabel.backgroundColor = themeColor
        titleLabel.font = UIFont(name: "Avenir-Black", size: 24.0)
        titleLabel.clipsToBounds = true
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(titleLabel)
        
        let fillerLabel = UILabel(frame: CGRect(x: view.frame.width * 0.8 - 1, y: 0, width: view.frame.width * 0.2 + 1, height: view.frame.height * 0.1))
        fillerLabel.backgroundColor = themeColor
        fillerLabel.clipsToBounds = true
        view.addSubview(fillerLabel)
    }
    
    func backPressed() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension RSVPViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Specifies the number of sections in the tableView.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Specifies the number of rows in the given SECTION.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return membersInterested.count
    }
    
    // Deques the cell and sets it up.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MemberCell
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        
        return cell
    }
    
    // Populates the data of a given cell.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let dbRef = FIRDatabase.database().reference().child("members")
        let cell = cell as! MemberCell
        cell.memberName.text = membersInterested[indexPath.row]
//        let photoUrl = NSURL(string: listUIDs[indexPath.row])
//        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
//            if error != nil {
//                print(error)
//                return
//            }
//            
//            cell.profPic.image = UIImage(data: data!)
//            
//        })
//        
//        }
       
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/4
    }

    
}
