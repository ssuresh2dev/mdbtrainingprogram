//
//  FeedViewController.swift
//  Virindly
//
//  Created by Candice Ye on 10/7/16.
//  Copyright © 2016 Candice Ye. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Social

struct postStruct {
    let fullname: String!
    let event: String!
    let details: String!
    let date: String!
}

class FeedViewController: UIViewController {
    
    var posts = [postStruct]()
    var user: FIRUser!
    
    var tableView: UITableView!
    var images = [UIImage(named: "event1"), UIImage(named: "event2"), UIImage(named: "event3"),  UIImage(named: "event4"), UIImage(named: "event5"), UIImage(named: "event6"), UIImage(named: "event7")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let ref = FIRDatabase.database().reference()
        ref.child("posts").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as? NSDictionary
            
            let fullname = snapshotValue!["fullname"]
            let event = snapshotValue!["event"]
            let details = snapshotValue!["details"]
            let date = snapshotValue!["date"]
            
            self.posts.insert(postStruct(fullname: fullname as! String, event: event as! String!, details: details as! String, date: date as! String), at: 0)
            self.tableView.reloadData()
        })
        
        setupTableView()
        
        // Navigation Bar 
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        let navTitle = UINavigationItem(title: "What's going on?")
        
        let addEvent = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(pressedAddButton))
        navTitle.rightBarButtonItem = addEvent
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(pressedLogout))
        navTitle.leftBarButtonItem = logoutButton
        
        navBar.setItems([navTitle], animated: false)
        self.view.addSubview(navBar)
    }
    
    // Initializing a TableView and additing it to VC's current screen
    func setupTableView() {
        // Set Layout
        tableView = UITableView(frame: CGRect(x: 0, y: 80, width: view.frame.width, height: view.frame.height))
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "Screen Shot 2016-10-13 at 11.42.31 PM"))
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "imageCell")
        tableView.rowHeight = 120
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    // ACTIONS
    func pressedAddButton(sender: UIButton!) {
        performSegue(withIdentifier: "segueToNewSocial", sender: self)
    }
    
    func pressedLogout(sender: UIButton!) {
        let auth = FIRAuth.auth()
        do {
            try auth?.signOut()
            AppState.sharedInstance.signedIn = false
            performSegue(withIdentifier: "segueFeedToLogin", sender: self)
        } catch let error as NSError {
            print(error)
        }
    }
}


extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    // Objective C part was suggested by Xcode in Issue Navigator
    @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let imageCell = cell as! ImageTableViewCell
        imageCell.eventLabel.text = posts[indexPath.row].event
        imageCell.eventPoster.text = posts[indexPath.row].fullname
        imageCell.eventDate.text = posts[indexPath.row].date
        imageCell.eventImageView.image = images[indexPath.row]
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
}

extension FeedViewController: ImageTableViewCellDelegate {
    func changeToInterested(forCell: ImageTableViewCell) {
//        forCell.rsvpButtonbackgroundColor = UIColor.green
//        forCell.rsvpButton.title = "Interested!"
    }
}



