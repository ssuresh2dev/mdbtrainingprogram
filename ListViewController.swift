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
    //var pokemonImageView: UIImageView
    var tableView: UITableView! = UITableView()
    var collectionView: UICollectionView!
    let pokemonArray:[Pokemon] = PokemonGenerator.getPokemonArray()
    var randomPokemon: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomPokemon()
        setupSC()
        setupTableView()
        setupCollectionView()
        collectionView?.isHidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func changeSegment(_ sender: AnyObject) {
        if sc.selectedSegmentIndex == 0{
            tableView.isHidden = false
            collectionView?.isHidden = true
            setupTableView()
        }else{
            tableView.isHidden = true
            collectionView?.isHidden = false
            setupCollectionView()
        }
    }
    //randomly pick 20 pokemon from the array
    func getRandomPokemon(){
        for i in 1...20{
            let random = Int(arc4random_uniform(UInt32(pokemonArray.count)))
            randomPokemon.append(pokemonArray[random])

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
        view.addSubview(tableView!)
    }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing =  0
        layout.minimumInteritemSpacing = 0
        let frame = CGRect(x: 0, y: self.navigationController!.navigationBar.frame.height + 60, width: view.frame.width, height: view.frame.height)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "pokemonCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
    }
    //Create a method with a completion handler to get the image data from your url
    
//
//    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
//        URLSession.shared.dataTask(with: url) {
//            (data, response, error) in
//            completion(data, response, error)
//            }.resume()
//    }
    //Create a method to download the image (start the task)
    
//    func downloadImage(url: URL) {
//        print("Download Started")
//        getDataFromUrl(url: url) { (data, response, error)  in
//            DispatchQueue.main.sync() { () -> Void in
//                guard let data = data, error == nil else { return }
//                print(response?.suggestedFilename ?? url.lastPathComponent)
//                print("Download Finished")
//                self.pokemonImageView.image = UIImage(data: data)
//            }
//        }
//    }

    
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
        self.tableView?.rowHeight = 80
        
        //for labels
        let pokemonDisplayed = randomPokemon[indexPath.row]
        cell.pokemonNameLabel.text = pokemonDisplayed.name
        cell.pokemonNumberLabel.text = String(pokemonDisplayed.number)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let pokemonCell = cell as! PokemonTableViewCell
        
        //for image
        let pokemonDisplayed = randomPokemon[indexPath.row]
        let imgURL = Foundation.URL(string: pokemonDisplayed.imageUrl)
        
        //This is to check and see if downloading the image from the url returns an image or nil
        let placeholderImageView: UIImageView? = UIImageView()
        placeholderImageView?.downloadedFrom(url: imgURL!)
        
        if placeholderImageView != nil{
            pokemonCell.pokemonImageView?.downloadedFrom(url: imgURL!)
            
        }else{
            pokemonCell.pokemonImageView? = UIImageView(image: #imageLiteral(resourceName: "no image found"))

        }

        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as! PokemonCollectionViewCell
        cell.awakeFromNib()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let pokemonCell = cell as! PokemonCollectionViewCell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(view.frame.width)/2, height: 200)
    }

}
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
