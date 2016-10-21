import UIKit
import Pods_MDBSocials
import Firebase

enum GoingStatus {
    case interested
    case notResponded
}

class Event {
    var poster: String!
    var name: String!
    var date: String!
    var time: String!
    var description: String!
    var eventID: String!
    var usersInterested: [String: String]!
    var status: GoingStatus = GoingStatus.notResponded
    
    init(name: String, date: String, time: String, description: String, id: String, poster: String) {
        self.poster = poster
        self.eventID = id
        self.name = name
        self.date = date
        self.time = time
        self.description = description
        self.usersInterested = [:]
    }
    
    func getUsersInterested() -> [String: String]{
        return usersInterested
    }
    
    func updateInterestedUser(user: FIRUser!){
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("events").child(eventID).child("usersInterested").setValue(usersInterested)
    }
}
