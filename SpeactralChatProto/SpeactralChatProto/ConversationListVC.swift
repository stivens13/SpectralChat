//
//  ConversationListVC.swift
//  SpeactralChatProto
//
//  Created by John Mai on 11/14/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

class ConversationListVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return MessageDetailCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
