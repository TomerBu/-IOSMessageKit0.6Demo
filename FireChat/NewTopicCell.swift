//
//  NewTopicCell.swift
//  FireChat
//
//  Created by Tomer Buzaglo on 04/09/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import UIKit
import FirebaseDatabase  //1
import FirebaseAuth // 2

class NewTopicCell: UITableViewCell {
    
    var userName:String!
    
    @IBOutlet weak var topicTextField: UITextField!
    
    
    @IBAction func addTopicTapped(_ sender: UIButton) {

        //1) Ref to the current user:
        guard let user = Auth.auth().currentUser else{return}
        
        //2) Ref to a new Row in the Topics Table
        let newTopicRowRef = Database.database().reference(withPath:
            "Topics").childByAutoId()
        
        //3) init the topic Object Model that we want to save in the database.
        let t = Topic(name: topicTextField.text ?? "", ownerID: user.uid, ownerName: userName)
        
        //4) newTopicRowRef.setValue(t.toJson()) // t.toDicationary())
        //newTopicRowRef.setValue(t.json)
        
        
        newTopicRowRef.setValue(t.json) { (err, ref) in
            if let err = err{
                print(err)
            }
            else{
                
                self.topicTextField.text = nil
            }
        }
    }
}














