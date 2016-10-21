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
    var allEvents: [NSString]!
    var usersRsvp: [NSString]!
    var displayNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getUsersName()
        setupTableView()
        setupUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView(){
        tableV = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
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
    }
    
    func quitModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersRsvp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: "eachName", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let eachCell = cell as! DisplayNameTableViewCell
        print("TEST WILLDISPLAY")
        print(displayNames)
        print(indexPath.row)
        if displayNames.count != 0 {
            eachCell.displayName.text = displayNames[indexPath.row]
        } 
    }
    
    func getUsersName() {
        let ref = FIRDatabase.database().reference().child("users")
        ref.observe(.value, with: { (snapshot) in
            let dict = snapshot.value as? [String : AnyObject]
            for stringIds in self.usersRsvp {
                print("GETUSERTEST")
                var userInfo = dict?[stringIds as String]
                print(userInfo)
                var nameString = "\(userInfo?["firstName"]) \(userInfo?["lastName"])"
                print(nameString)
                self.displayNames.append(nameString)
            }
            
            })

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
