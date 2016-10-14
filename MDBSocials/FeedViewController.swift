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
    var feedEventPictures = [UIImage(named: "IMG_2469")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeedTableView()
                newSocial = UIButton(frame: CGRect(x: 0, y:0, width: view.frame.width/4, height: view.frame.height/10))
        
        newSocial.setTitle("Add event", for: .normal)
        newSocial.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(newSocial)
        
        signOutButton = UIButton(frame: CGRect(x:view.frame.width - view.frame.width/4, y: 0, width: view.frame.width/4, height: view.frame.height/10))
        signOutButton.setTitle("Sign out", for: .normal)
        signOutButton.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(signOutButton)
        
        newSocial.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    func signOut() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            AppState.sharedInstance.signedIn = false
            dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "backToHome", sender: self)
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
        
        feedTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
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
        return feedEventPictures.count
    }
    
    // Deques the cell and sets it up.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        cell.awakeFromNib()
    
        return cell
    }
    
    // Populates the data of a given cell.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let feedCell = cell as! FeedTableViewCell
        feedCell.eventPictureImageView.image = feedEventPictures[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       performSegue(withIdentifier: "toDetail", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/4
    }
    
}
