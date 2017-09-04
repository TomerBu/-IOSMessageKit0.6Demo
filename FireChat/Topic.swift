//
//  Topic.swift
//  FireChat
//
//  Created by Tomer Buzaglo on 04/09/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Topic :CustomStringConvertible {
    let name: String
    let ownerID: String
    let ownerName: String
    
    init(name:String, ownerID:String, ownerName:String) {
        self.name  = name
        self.ownerID = ownerID
        self.ownerName = ownerName
    }
    
    init(json: [String: Any]){
        self.name = json["name"] as! String
        self.ownerID = json["ownerID"] as! String
        self.ownerName = json["ownerName"] as! String
    }
    
    init(snapshot: DataSnapshot){
        //let key = snapshot.key
        let json = snapshot.value as! [String: Any]
        self.name = json["name"] as! String
        self.ownerID = json["ownerID"] as! String
        self.ownerName = json["ownerName"] as! String
    }
    
    var description: String{
        return "Topic: \(name)\nStarted By: \(ownerName)\n"
    }
    
    //Computed Property:
    var json:[String: Any]{
            return [
                "name": name,
                "ownerID": ownerID,
                "ownerName" : ownerName
            ]
    }
}
