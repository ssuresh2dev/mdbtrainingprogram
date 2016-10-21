
//  FeedViewController.swift
//  MDBSocials
//
//  Created by Mohit Katyal on 10/2/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FeedViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var navBarLabel : UILabel!
    var signOutButton : UIButton!
    var createEventButton : UIButton!
    var ref : FIRDatabaseReference!
    var events = [Event]()
    var eventSelected : Event!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = FIRDatabase.database().reference()
        ref.child("events").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            let eventKey = snapshot.key
            let eventDict = snapshot.value as? [String: AnyObject]
            let event = Event(key: eventKey, eventDict: eventDict!)
            self.events.insert(event, at: 0)
        })

        
        navBarLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 64))
        navBarLabel.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        view.addSubview(navBarLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: "feedCell")
        view.addSubview(collectionView)
        
        createEventButton = UIButton(frame: CGRect(x: view.frame.width * 0.725, y: 18, width: view.frame.width * 0.25, height: 32))
        createEventButton.setTitle("New Event", for: .normal)
        createEventButton.setTitleColor(UIColor.blue, for: .normal)
        createEventButton.addTarget(self, action: #selector(createEvent), for: .touchUpInside)
        view.addSubview(createEventButton)
        
        signOutButton = UIButton(frame: CGRect(x: 0, y: 18, width: 0.25 * view.frame.width, height: 32))
        signOutButton.setTitle("Sign Out",for: .normal)
        signOutButton.setTitleColor(UIColor.blue,  for: .normal)
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        view.addSubview(signOutButton)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
//    func configureDatabase() {
//        let ref = FIRDatabase.database().reference()
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        let eventRef = ref.child("event")
//        eventRef.observe(.value) { (FIRDataSnapshot) in
//            <#code#>
//        }
//    }
//    
    func signOut() {
        do {
            try FIRAuth.auth()?.signOut()
            AppState.sharedInstance.signedIn = false
            dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "feedToLogin", sender: self)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func createEvent() {
        performSegue(withIdentifier: "toNewSocial", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let next = segue.destination as! DetailViewController
            next.event = eventSelected
        }
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

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath)
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let feedCell = cell as! FeedCollectionViewCell
        feedCell.dateLabel.text = events[indexPath.row].date
        feedCell.eventNameLabel.text = events[indexPath.row].eventName
        feedCell.hostLabel.text = events[indexPath.row].user
        feedCell.attendanceLabel.text = "Interested: "+(String)(events[indexPath.row].numPeople)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height-64)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        eventSelected = events[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: self)
    }

}
