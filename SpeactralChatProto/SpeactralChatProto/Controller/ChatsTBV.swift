//
//  ChatsTBV.swift
//  SpeactralChatProto
//
//  Created by John Mai on 12/22/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

//import UIKit
//import Firebase
//import FirebaseDatabase
//import JSQMessagesViewController
//
//class ChatsTBV: UITableViewController {
//
//    let cellId = "cellId"
//    var following = [User]()
//    var selectedUser: User?
//    var existingChat: Chat?
//    var users = [User]()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
//        
//        retrieveUser()
//    }
//
//    @objc func handleCancel() {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return users.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
//        let user = users[indexPath.row]
//        cell.textLabel?.text = user.name
//        cell.detailTextLabel?.text = user.email
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 72
//    }
//    
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "toChat", sender: self)
//    }
//    func retrieveUser() {
//        let rootRef = Database.database().reference()
//        let query = rootRef.child("users").queryOrdered(byChild: "name")
//        query.observe(.value) { (snapshot) in
//            for child in snapshot.children.allObjects as! [DataSnapshot] {
//                if let value = child.value as? NSDictionary {
//                    let user = User()
//                    let name = value["name"] as? String ?? "Name not found"
//                    let email = value["email"] as? String ?? "Email not found"
//                    user.name = name
//                    user.email = email
//                    self.users.append(user)
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//        }
//    }
//    
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//    
//}
//extension ChatsTBV {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        
//        if segue.identifier == "toChat", let _ = segue.destination as? ChatUI {
//        
//        }
//
//    }
//}

