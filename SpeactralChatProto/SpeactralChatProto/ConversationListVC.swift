//
//  ConversationListVC.swift
//  SpeactralChatProto
//
//  Created by John Mai on 11/14/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

class ConversationListVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    var messageDetail = [MessageDetail]()
    
    var detail: MessageDetail!
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    var recipient:String!
    
    var messageId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Database.database().reference().child("users").child(currentUser!).child("messages").observe(.value, with: {(snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                self.messageDetail.removeAll()
                
                for data in snapshot {
                    if let messageDict = data.value as? Dictionary<String,AnyObject> {
                        let key = data.key
                        
                        let info = MessageDetail(messageKey: key, messageData: messageDict)
                        
                        self.messageDetail.append(info)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageDet = messageDetail[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageDetailCell {
            cell.configureCell(messageDetail: messageDet)
            return cell
        } else {
            return messageDetailCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? MessageVC {
            //destinationViewController.recipient
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
