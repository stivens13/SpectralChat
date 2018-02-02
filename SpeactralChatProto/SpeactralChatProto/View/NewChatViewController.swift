//
//  NewChatViewController.swift
//  SpeactralChatProto
//
//  Created by John Mai on 1/30/18.
//  Copyright © 2018 Nikita Voloshenko. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let cellId = "cellId"
    
    
    var following = [User]()
    var selectedUser: User?
    var existingChat: Chat?

    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        // remove separators for empty cells
        tableView.tableFooterView = UIView()
        
        retrieveUser()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func retrieveUser() {
        let rootRef = Database.database().reference(fromURL: "https://ios-spectral.firebaseio.com/")
        let query = rootRef.child("users").queryOrdered(byChild: "name")
        query.observe(.value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                if let value = child.value as? NSDictionary {
                    let user = User(uid: child.key, username: value["email"] as! String)
                    let name = value["name"] as? String ?? "Name not found"
                    let email = value["email"] as? String ?? "Email not found"
                    user.name = name
                    user.email = email
                    //testing whether following is appended

                    self.following.append(user)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                    
                }
            }

        }
    }
    @IBAction func backButton(_ sender: Any) {
//        performSegue(withIdentifier: "toMessage", sender: self)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        // 1
        guard let selectedUser = selectedUser else { return }

        // 2
        sender.isEnabled = false
        // 3
        ChatService.checkForExistingChat(with: selectedUser) { (chat) in
            // 4
            sender.isEnabled = true
            self.existingChat = chat

            self.performSegue(withIdentifier: "toChat", sender: self)
        }
    }

    // MARK: - IBActions


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        // 2
        selectedUser = following[indexPath.row]
        cell.accessoryType = .checkmark
        
        // 3
        nextButton.isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // 4
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        // 5
        cell.accessoryType = .none
    }
    //number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.following.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewChatUserCell") as! NewChatUserCell
        configureCell(cell, at: indexPath)
        return cell
    }
    
    func configureCell(_ cell: NewChatUserCell, at indexPath: IndexPath) {
        let follower = following[indexPath.row]
        cell.textLabel?.text = follower.username
        
        if let selectedUser = selectedUser, selectedUser.uid == follower.uid {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
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



extension NewChatViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "toChat", let destination = segue.destination as? ChatViewController, let selectedUser = selectedUser {
            let members = [selectedUser, User.current]
            destination.chat = existingChat ?? Chat(members: members)
        }
    }
}

