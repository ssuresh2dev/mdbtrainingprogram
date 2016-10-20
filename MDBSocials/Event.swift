import UIKit
import Pods_MDBSocials

struct Event {
    var user: String!
    var name: String!
    var date: String!
    var time: String!
    var description: String!
    var usersInterested: [String]!
    
    init (name: String, date: String, time: String, usersInterested: [String]) {
        self.name = name
        self.date = date
        self.usersInterested = usersInterested
        self.description = ""
        self.time = time
    }
}
