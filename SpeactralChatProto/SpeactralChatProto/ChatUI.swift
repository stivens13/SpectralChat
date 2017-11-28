//
//  ChatUI.swift
//  SpeactralChatProto
//
//  Created by John Mai on 11/28/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class ChatUI: JSQMessagesViewController {
    var messages = [JSQMessage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = "1"
        self.senderDisplayName = "John"
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        print("didPressSend")
        print("\(text)")
        
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        print("didPressAccessory")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
