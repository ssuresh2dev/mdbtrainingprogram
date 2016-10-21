//
//  FeedViewController.swift
//  MDBSocials
//
//  Created by Jessica Chen on 10/2/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {
    var newSocial: UIButton!
    var signOutButton: UIButton!
    var feedTableView: UITableView!
    var feedEvents = [Event]()
    var eventSelected: Event!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeedTableView()
        
        
        let ref = FIRDatabase.database().reference()
        ref.child("events").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let date = snapshotValue?["date"] as? String
            let name = snapshotValue?["name"] as? String
            let time = snapshotValue?["time"] as? String
            let description = snapshotValue?["description"] as? String
            let eventid = snapshot.key
            let poster = snapshotValue?["poster"] as? String
            
            self.feedEvents.insert(Event(name: name!, date: date!, time: time!, description: description!, id: eventid, poster: poster!), at: 0)
            self.feedTableView.reloadData()
            
            
        })
        feedTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUI()
        feedTableView.reloadData()
    }
    
    func setUI() {
        
        view.backgroundColor = themeColor
        
        let newSocialButton = UIButton(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.03 + 10, width: view.frame.width * 0.2, height: view.frame.height * 0.04))
        newSocialButton.setTitle("Add event", for: .normal)
        newSocialButton.titleLabel!.adjustsFontSizeToFitWidth = true
        newSocialButton.setTitleColor(UIColor.white, for: .normal)
        newSocialButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        newSocialButton.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
        view.addSubview(newSocialButton)
        
        let signOutButton = UIButton(frame: CGRect(x: view.frame.width * 0.75, y: view.frame.height * 0.03 + 10, width: view.frame.width * 0.2, height: view.frame.height * 0.04))
        signOutButton.setTitle("Sign out", for: .normal)
        signOutButton.setTitleColor(UIColor.white, for: .normal)
        signOutButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        signOutButton.layer.cornerRadius = 5
        signOutButton.clipsToBounds = true
        view.addSubview(signOutButton)
        
        let titleLabel = UILabel(frame: CGRect(x: view.frame.width * 0.3, y: view.frame.height * 0.03 + 10, width: view.frame.width * 0.4, height: view.frame.height * 0.04))
        titleLabel.text = "MDB Socials"
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: "Avenir-Black", size: 24.0)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        view.addSubview(titleLabel)
        
    }
    
    
    func signOut() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            AppState.sharedInstance.signedIn = false
            dismiss(animated: true, completion: nil)
            let newLogin = LoginViewController()
            self.present(newLogin, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    func addEvent(){
        performSegue(withIdentifier: "toNewSocial", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Initializes table containing the feeds and adds it to FeedViewController's current view.
    func setupFeedTableView() {
        
        feedTableView = UITableView(frame: CGRect(x: 0, y: view.frame.height * 0.1 + 10, width: view.frame.width, height: view.frame.height * 0.9))
        feedTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "feedCell")
        feedTableView.rowHeight = 80
        feedTableView.backgroundColor = UIColor.white
        feedTableView.delegate = self
        feedTableView.dataSource = self
        view.addSubview(feedTableView)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Specifies the number of sections in the tableView.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Specifies the number of rows in the given SECTION.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedEvents.count
    }
    
    // Deques the cell and sets it up.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
    
        return cell
    }
    
    // Populates the data of a given cell.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let feedCell = cell as! FeedTableViewCell
        feedCell.eventPictureImageView.image = UIImage(named: "event")
        feedCell.date.text = "When: \(feedEvents[indexPath.row].date!)"
        feedCell.eventName.text = "Event: \(feedEvents[indexPath.row].name!)"
        //feedCell.numRSVP.text = "Number of people interested: \(feedEvents[indexPath.row].usersInterested.count)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventSelected = feedEvents[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/4
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            let next = segue.destination as! DetailViewController
            next.event = eventSelected
        }
    }
    
}
