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
    let rootRef = Constants.Colors.rootRef
    var events: [NSString] = []
    var tableView: UITableView!
    var eventsArray: [Event] = []
    var selectedEvent: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatabase()
        setupTableView()
        setupUI()
        setupSignOutButton()
    }

    func configureDatabase(){
        let eventsRef = rootRef.child("events")

        //let usersRef = rootRef.child("users")
        
        eventsRef.observe(.value, with: { snapshot in
            var newEvents: [NSString] = []
            for event in snapshot.children.allObjects as! [FIRDataSnapshot] {
        
                newEvents.append(event.key as! NSString)
            }
           
            
            self.events = newEvents
            
            self.tableView.reloadData()
        })
    
        
    }
    
    func setupTableView(){
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "eventCell")
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView!)
    
    }
    
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

extension FeedViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell

    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let eventCell = cell as! EventTableViewCell

//        ref.child("users").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//            // Get user value
//            let username = snapshot.value!["username"] as! String
//            let user = User.init(username: username)
        //        })
        let ref = rootRef.child("events").child("\(events[indexPath.row])")
        ref.observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let event = Event()
                event.eventTitle = dictionary["eventTitle"] as! String?
                event.eventDate = dictionary["eventDate"] as! String?
                event.eventDescription = dictionary["eventDescription"] as! String?
                event.rsvp = dictionary["rsvp"] as! String?
                event.downloadURL = dictionary["downloadURL"] as! String?
                event.poster = dictionary["poster"] as! String?
                
                self.eventsArray.append(event)
                eventCell.titleName.text = event.eventTitle
                
                print(event.eventTitle, event.eventDate)
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = eventsArray[indexPath.row]
        performSegue(withIdentifier: "moreInfo", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreInfo" {
            let dest = segue.destination as? DetailViewController
            dest?.titleOfEvent.text = selectedEvent?.eventTitle
            dest.
        }
    }
  
    
//    eventsRef.observe(.value, with: { snapshot in
//    var newEvents: [NSString] = []
//    for event in snapshot.children.allObjects as! [FIRDataSnapshot] {
//    
//    newEvents.append(event.key as! NSString)
//    }
//
//    
//    self.events = newEvents
//    print(self.events)
//    
//    self.tableView.reloadData()
//    })
//    
//    
//}


}
