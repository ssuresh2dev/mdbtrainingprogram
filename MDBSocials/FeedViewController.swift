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

class FeedViewController: UIViewController {

   // var ref: FIRDatabaseReference!
    //var events: [FIRDataSnapshot]! = []
    //var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureDatabase()
//        setupTableView()
        setupUI()
    }

    func configureDatabase(){
        //ref = FIRDatabase().reference()
        
        
    }
//    func setupTableView(){
//        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "eventCell")
//        tableView.dataSource = self
//        tableView.delegate = self
//    
//    }
    func setupUI(){
        let addEventButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(FeedViewController.showCreateEventVC))
        self.navigationItem.rightBarButtonItem = addEventButton
    }
    func showCreateEventVC(){
        performSegue(withIdentifier: "segueToCreateEventVC", sender: self)
    }
   
    @IBAction func unwindToFeedVC(segue: UIStoryboardSegue) {}

}

//extension FeedViewController: UITableViewDelegate, UITableViewDataSource{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//  
//    
//}
