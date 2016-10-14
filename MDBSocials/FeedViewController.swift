//
//  FeedViewController.swift
//  MDBSocials
//
//  Created by Eliot Han on 10/4/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage


class FeedViewController: UIViewController {

   
    //var events: [FIRDataSnapshot]! = []
    //var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureDatabase()
        //setupTableView()
        setupUI()
        setupSignOutButton()
    }

//    func configureDatabase(){
//        let rootRef = FIRDatabase.database().reference()
//        let eventsRef = rootRef.child("events")
//        //let usersRef = rootRef.child("users")
//        
//        eventsRef.observe(.value, with: { snapshot in
//            var newEvents: [FIRDataSnapshot] = []
//            for event in snapshot.children {
//        
//                newEvents.append(event as! FIRDataSnapshot)
//            }
//            
//            self.events = newEvents
//            self.tableView.reloadData()
//        })
//    
//        
//    }
    
//    func setupTableView(){
//        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "eventCell")
//        tableView.dataSource = self
//        tableView.delegate = self
//        view.addSubview(tableView)
//    
//    }
    
    func setupUI(){
        let bttn = UIButton()
        bttn.setImage(#imageLiteral(resourceName: "CalendarIcon"), for: .normal)
        bttn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        bttn.addTarget(self, action: #selector(FeedViewController.showCreateEventVC), for: .touchUpInside)
        let addEventButton = UIBarButtonItem()
        addEventButton.customView = bttn
        self.navigationItem.rightBarButtonItem = addEventButton
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Bar"), for: .default)
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "OpenSocials"))
    }
    
    func showCreateEventVC(){
        performSegue(withIdentifier: "segueToCreateEventVC", sender: self)
    }
   
    @IBAction func unwindToFeedVC(_ segue: UIStoryboardSegue) {
        print("unwinded!")
    }

    
    func setupSignOutButton(){
        let signOutButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(FeedViewController.signOut))
        self.navigationItem.leftBarButtonItem = signOutButton
        
    }
    
    func signOut(){
        do {
            try FIRAuth.auth()?.signOut()
            performSegue(withIdentifier: "afterSignOut", sender: self)
            viewWillDisappear(true)
        } catch let error as NSError {
            print(error)
        }

    }
    
    
  
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

//extension FeedViewController: UITableViewDelegate, UITableViewDataSource{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return events.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as! EventTableViewCell
//        for subview in cell.contentView.subviews{
//            subview.removeFromSuperview()
//        }
//        cell.awakeFromNib()
//        self.tableView?.rowHeight = 80
//        return cell
//
//    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        //cell shtit
//    }
//  
//    
//}
