import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tableView: UITableView!
    var favorites: [Pokemon] = [] //favorites array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listViewSetup()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func listViewSetup(){
        for subview in view.subviews{
            subview.removeFromSuperview()
        }
        //set up tableView
        tableView = UITableView(frame: CGRect(x:0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.register(ListCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    //tableView methods.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count //Still need to set array  countfor this value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
            as! ListCell
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellId = cell as! ListCell
        let url = URL(string: favorites[indexPath.row].imageUrl)
        if(url != nil){
            try! cellId.TableImageView.image = UIImage(data: Data(contentsOf: url!))
        }
        
        cellId.pokemonName.text = favorites[indexPath.row].name
        cellId.pokemonNumber.text = String(favorites[indexPath.row].number)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/5
    }
 }
