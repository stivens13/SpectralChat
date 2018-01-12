//
//  ConversationsTVC.swift
//  SpeactralChatProto
//
//  Created by John Mai on 12/22/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper
class ConversationsTVC: UITableViewController {
    var messageDetail = [MessageDetail]()
    
    var detail: MessageDetail!
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    var recipient:String!
    
    var messageId:String!
    
    var ref = Database.database().reference()
    
    @IBOutlet weak var bar: UINavigationBar!
    
    @IBAction func newMessagePress(_ sender: Any) {
            //redirect the user to the page to add who they want to talk to
            handleNewMessage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        let image = UIImage(named: "new_message")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        // Do any additional setup after loading the view.
        checkUserLoggedIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleNewMessage() {
        let chatsTBV = ChatsTBV()
        let navController = UINavigationController(rootViewController: chatsTBV)
        present(navController, animated: true, completion: nil)
        
    }
    func checkUserLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(logout(_:)), with: nil, afterDelay: 0)
            
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    print(dictionary["name"]!)
                    //                    self.navigationItem.title = dictionary["username"] as? String
                    self.title = dictionary["name"] as? String
                    
                }
            }, withCancel: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? MessageVC {
            
            destinationViewController.recipient = recipient
            
            destinationViewController.messageId = messageId
            
        }
    }
    @IBAction func addNewUser(_ sender: Any) {
        showInputDialog()
    }
    
    func showInputDialog() -> String {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Enter details?", message: "Enter your name and email", preferredStyle: .alert)
        
        var newUserName = "default"
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            newUserName = (alertController.textFields?[0].text)!
            //            let email = alertController.textFields?[1].text
            
            //            self.labelMessage.text = "Name: " + name! + "Email: " + email!
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        //        alertController.addTextField { (textField) in
        //            textField.placeholder = "Enter Name"
        //        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Email"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
        
        return newUserName
    }
    @IBAction func logout(_ sender: AnyObject) {
        //sign the user out
        try! Auth.auth().signOut()
        
        KeychainWrapper.standard.removeObject(forKey: "uid")
        
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
