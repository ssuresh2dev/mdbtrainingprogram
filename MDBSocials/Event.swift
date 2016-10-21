import UIKit
import Pods_MDBSocials
import Firebase

struct Event {
    var user: String!
    var name: String!
    var date: String!
    var time: String!
    var description: String!
    var usersInterested: [FIRUser]!
    
    init(name: String, date: String, time: String, description: String) {
        self.name = name
        self.date = date
        self.time = time
        self.description = description
    }
}
