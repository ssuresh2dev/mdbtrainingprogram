//
//  ListViewController.swift
//  Pokedex
//
//  Created by Eliot Han on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    //let options = ["Table","List"]
    //var segmentedControl = UISegmentedControl()
    
    @IBOutlet weak var sc: UISegmentedControl!
    
    var tableView = UITableView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSC()
        setupTableView()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func changeSegment(_ sender: AnyObject) {
        if sc.selectedSegmentIndex == 0{
            tableView.isHidden = false
        }else{
            tableView.isHidden = true
        }
    }
    
    func setupSC(){
        sc.selectedSegmentIndex = 0
        sc.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.frame.height + 20, width: view.frame.width, height: 40)
        sc.layer.cornerRadius = 5.0 //Don't let background bleed
        
        
    }
    
//First, I tried to fully setup the segmented control progamatically but for some reason, my addTarget Selector wouldn't fucking register no matter what so i gave up and just did it through storyboard. I still do some setup progamatically though
    
//    //setup Segemented Control
//    func setupSC(){
//        segmentedControl = UISegmentedControl(items : options)
//        segmentedControl.selectedSegmentIndex = 0
//        segmentedControl.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
//        segmentedControl.layer.cornerRadius = 5.0 //Don't let background bleed
//        segmentedControl.addTarget(self, action: "changeSegment:", for: .valueChanged)
//        self.view.addSubview(segmentedControl)
//        
//    }
    
    func setupTableView(){
        tableView.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.frame.height + 60, width: view.frame.width, height: view.frame.height)
        tableView = UITableView(frame: tableView.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        view.addSubview(tableView)
    }

    //handles changes in Segmented Control Value
//    func changeSegment(sender: UISegmentedControl){
//        print("Changing Segment!!")
//        if sender.selectedSegmentIndex == 1{
//            print("tableview selected")
//            tableView.isHidden = true
//        }else{
//            print("collection selected")
//            tableView.isHidden = false
//        }
//        
//    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    //Specify number of cells in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        cell.awakeFromNib()
        self.tableView.rowHeight = 80
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let pokemonCell = cell as! PokemonTableViewCell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
