//
//  AnonymousLoginVC.swift
//  FireChat
//
//  Created by Tomer Buzaglo on 04/09/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import UIKit
import FirebaseAuth

class AnonymousLoginVC: UIViewController {
    
    //Fields:
    @IBOutlet weak var aliasTextField: UITextField!
    
    //Actions:
    @IBAction func loginTapped(_ sender: UIButton) {
        
        //Test if there is text in the text Field:
        guard let alias = aliasTextField.text, alias.characters.count >= 6 else{
            print("Must be at least 6 characters...")
            return
        }
        
        //get an object of type Auth
        //no new... (no public inits)
        let auth = Auth.auth()
        
        //Sign In Anonynymously
        //lower case:
        auth.signInAnonymously { (user:User?, error:Error?) in
            if let error = error{
                print(error)
                return
            }
            
            if let user = user{
                //self.aliasTextField.isEnabled = false
                self.performSegue(withIdentifier: "loggedInSegue", sender: user)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nav = segue.destination as? UINavigationController,
            let user = sender as? User {
            
            let dest = nav.childViewControllers.first as! TopicsController
            dest.user = user
            dest.userName = aliasTextField.text!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}






















