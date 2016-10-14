import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    //event variables
    var eventImage: UIImageView!
    var blackGradient: UILabel!
    var dateLabel: UILabel!
    var eventNameLabel: UILabel!
    var hostLabel: UILabel!
    var attendanceLabel: UILabel!


    //Adds it to the FeedViewController
    override func awakeFromNib() {
    
        //Creates event image
        eventImage = UIImageView(frame: CGRect(x: contentView.frame.width*0.1, y: contentView.frame.height*0.1, width: contentView.frame.width*0.8, height: contentView.frame.height*0.4))
        eventImage.image = #imageLiteral(resourceName: "background") //Must change to input image
        eventImage.contentMode = .scaleAspectFill
        eventImage.clipsToBounds = true
        eventImage.layer.cornerRadius = 10
        contentView.addSubview(eventImage)
        
        //Creates black gradient over the image
        blackGradient = UILabel(frame: CGRect(x: contentView.frame.width*0.1, y: contentView.frame.height*0.1, width: contentView.frame.width*0.8, height: contentView.frame.height*0.4))
        blackGradient.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        blackGradient.clipsToBounds = true
        blackGradient.layer.cornerRadius = 10
        contentView.addSubview(blackGradient)
        
        //Creates date over the image
        dateLabel = UILabel(frame: CGRect(x: contentView.frame.width*0.15, y: contentView.frame.height*0.05, width: contentView.frame.width*0.7, height: contentView.frame.height*0.5))
        dateLabel.text = "Date:"
        dateLabel.textColor = UIColor.white
        dateLabel.font = UIFont(name: dateLabel.font.fontName, size: 40)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 40)
        dateLabel.textAlignment = .center
        contentView.addSubview(dateLabel)
        
        //Creates name of the event
        eventNameLabel = UILabel(frame: CGRect(x: contentView.frame.width*0.1, y: contentView.frame.height*0.5, width: contentView.frame.width*0.8, height: contentView.frame.height*0.2))
        eventNameLabel.text = "Name of Event" //Should change to actual event name
        eventNameLabel.textColor = UIColor.black
        eventNameLabel.font = UIFont(name: eventNameLabel.font.fontName, size: 20)
        eventNameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        eventNameLabel.textAlignment = .center
        contentView.addSubview(eventNameLabel)
        
        //Creates name of host
        hostLabel = UILabel(frame: CGRect(x: contentView.frame.width*0.1, y: contentView.frame.height*0.7, width: contentView.frame.width*0.8, height: contentView.frame.height*0.1))
        hostLabel.text = "Host: Mohit Katyal" //Should change to actual host
        hostLabel.textColor = UIColor.black
        hostLabel.font = UIFont(name: hostLabel.font.fontName, size: 20)
        contentView.addSubview(hostLabel)
            
        //Creates Number of people attending
        attendanceLabel = UILabel(frame: CGRect(x: contentView.frame.width*0.1, y: contentView.frame.height*0.8, width: contentView.frame.width*0.8, height: contentView.frame.height*0.1))
        attendanceLabel.text = "Number of Attendents: 0 😢" //Should change to actual number of attendants
        attendanceLabel.textColor = UIColor.black
        attendanceLabel.font = UIFont(name: attendanceLabel.font.fontName, size: 20)
        contentView.addSubview(attendanceLabel)
            
            
        // Do any additional setup after loading the contentView.
    }
    
    // Dispose of any resources that can be recreated.
}
