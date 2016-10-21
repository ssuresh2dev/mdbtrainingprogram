//
//  ModalViewController.swift
//  MDBSocials
//
//  Created by Rochelle on 10/20/16.
//  Copyright © 2016 Eliot Han. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ModalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableV: UITableView!
    //var allEvents: [NSString]!
    //var usersRsvp: [NSString]!
    
    //var names: [String] = []
    
    var users: [User]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.users.count)
        setupUI()
        setupTableView()
        
        // Do any additional setup after loading the view.
    }
  
    func goBack(){
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView(){
        tableV = UITableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + 44, width: view.frame.width, height: view.frame.height-44))
        tableV.register(DisplayNameTableViewCell.self, forCellReuseIdentifier: "eachName")
        tableV.rowHeight = 80
        tableV.dataSource = self
        tableV.delegate = self
        view.addSubview(tableV!)
        
    }
    
    func setupUI(){
        let bttn = UIButton(frame: CGRect(x: 150, y: 543, width: 68, height: 33))
        bttn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        bttn.addTarget(self, action: #selector(quitModal), for: .touchUpInside)
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: 320, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "");
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: "quitModal");
        navItem.leftBarButtonItem = doneItem;
        navBar.setItems([navItem], animated: false);
    }
    
    func quitModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: "eachName", for: indexPath) as! DisplayNameTableViewCell
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let eachCell = cell as! DisplayNameTableViewCell
        if users.count != 0 {
            eachCell.displayName.text = users[indexPath.row].name
        }
    }
    
    
    
    
    
}
