import UIKit
import Pods_MDBSocials

struct Event {
    var user: String!
    var name: String!
    var date: String!
    var time: String!
    var description: String!
    var numRSVPs: String!
    
    init (name: String, date: String, time: String, numRSVPs: String) {
        self.name = name
        self.date = date
        self.numRSVPs = numRSVPs
        self.description = ""
        self.time = time
    }
}
