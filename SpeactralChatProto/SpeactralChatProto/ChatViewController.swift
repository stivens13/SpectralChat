//
//  ChatViewController.swift
//  SpeactralChatProto
//
//  Created by John Mai on 11/2/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//
import UIKit
import JSQMessagesViewController
import FirebaseAuth
import Firebase

class ChatViewController: JSQMessagesViewController {
    
    //will contain the thread of messages between the two users
    private var messages = [JSQMessage]();
    
    override func viewDidLoad() {
        //for testing and building purposes
        //super.viewDidLoad()
        
        senderId = "1234"
        senderDisplayName = "John";
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.item];
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count;
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell;
    }
    
}
