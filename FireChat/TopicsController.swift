//
//  TopicsController.swift
//  FireChat
//
//  Created by Tomer Buzaglo on 04/09/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Photos

class TopicsController: UITableViewController {
    
    var user:User!
    var userName:String!{
        didSet{
            print(userName)
        }
    }
    
    //the data:
    var topics = [Topic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = userName
        
        let topicsRef = Database.database().reference(withPath: "Topics")
 
        topicsRef.observe(.childAdded, with: { (snapShot) in
            let json = snapShot.value as! [String: Any]
            
            let topic = Topic(json: json)
            self.topics.append(topic)
            //notify the tableview about the new Row!
            let path  = IndexPath(row: self.topics.count - 1, section: 1)
            self.tableView.insertRows(at: [path], with: .automatic)
        })
    }
  
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return section == 0 ? 1 : topics.count
    }
    
    
    //Data Binding
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newTopicCell",
                                                     for: indexPath) as! NewTopicCell
            
            // Configure the cell...
            cell.userName = self.userName
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell",
                                                 for: indexPath) as! TopicCell
        
        // Configure the cell...
        let topic = topics[indexPath.row]
        cell.topicTextField.text = topic.name
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
