//
//  ViewController.swift
//  Virindly
//
//  Created by Candice Ye on 10/7/16.
//  Copyright © 2016 Candice Ye. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct postStruct {
    let event: String!
    let details: String!
    let date: String!
}

class FeedViewController: UIViewController {
    
    var posts = [postStruct]()
    var user: FIRUser!
    var tableView: UITableView!
    var images = [UIImage(named: "mountain1"), UIImage(named: "mountain2"), UIImage(named: "mountain3"),  UIImage(named: "mountain4"), UIImage(named: "mountain5"), UIImage(named: "mountain6"), UIImage(named: "mountain7"), UIImage(named: "mountain8"), UIImage(named: "mountain9"), UIImage(named: "mountain10")]
    var eventNames = ["Event 1", "Event 2", "Event 3", "Event 4", "Event 5", "Event 6", "Event 7", "Event 8", "Event 9", "Event 10"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let ref = FIRDatabase.database().reference()
        ref.child("posts").queryOrderedByKey().observe(<#T##eventType: FIRDataEventType##FIRDataEventType#>, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as? NSDictionary
            
            let event = snapshotValue!["event"]
            let details = snapshotValue!["details"]
            let date = snapshotValue!["date"]
            
            self.posts.insert(postStruct(event: event as! String!, details: details as! String, date: date as! String), at: 0)
            tableView.reloadData()
        })
        
        setupTableView()

        // Navigation Bar 
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        let navTitle = UINavigationItem(title: "What's going on?")
        
        let addEvent = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(pressedAddButton))
        navTitle.rightBarButtonItem = addEvent
        
        let logoutButton = UIBarButtonItem(barButtonSystemItem: .undo, target: nil, action: #selector(pressedLogout))
        navTitle.leftBarButtonItem = logoutButton
        
        navBar.setItems([navTitle], animated: false)
        self.view.addSubview(navBar)
 
    }
    
    // Initializing a TableView and additing it to VC's current screen
    func setupTableView() {
        // Set Layout
        tableView = UITableView(frame: CGRect(x: view.frame.width/24, y: view.frame.height/8, width: view.frame.width - view.frame.width/12, height: view.frame.height - view.frame.height/8))
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
        imageCell.eventImageView.image = images[indexPath.row]
        imageCell.eventLabel.text = "\(eventNames[indexPath.row])"
    }

    
    
    
}


