//
//  ChatViewController.swift
//  SpeactralChatProto
//
//  Created by John Mai on 1/28/18.
//  Copyright © 2018 Nikita Voloshenko. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase
import FirebaseDatabase

class ChatViewController: JSQMessagesViewController {
    
    var messagesHandle: DatabaseHandle = 0
    var messagesRef: DatabaseReference?
    var messages = [Message]()
    var sentTo: Any?
    var chat: Chat!

    var chats = [Chat]()

    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
         navigationController?.popToRootViewController(animated: true)
    }
    
    var outgoingBubbleImageView: JSQMessagesBubbleImage = {
        guard let bubbleImageFactory = JSQMessagesBubbleImageFactory() else {
            fatalError("Error creating bubble image factory.")
        }
        
        let color = UIColor.jsq_messageBubbleBlue()
        return bubbleImageFactory.outgoingMessagesBubbleImage(with: color)
    }()
    
    var incomingBubbleImageView: JSQMessagesBubbleImage = {
        guard let bubbleImageFactory = JSQMessagesBubbleImageFactory() else {
            fatalError("Error creating bubble image factory.")
        }
        
        let color = UIColor.jsq_messageBubbleLightGray()
        return bubbleImageFactory.incomingMessagesBubbleImage(with: color)
    }()
    func addNavBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:54)) // Offset by 20 pixels vertically to take the status bar into account
        
        navigationBar.barTintColor = UIColor.lightGray
        navigationBar.tintColor = UIColor.black
        
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black]
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        //get id and now compute
        
        let id = chat.memberUIDs[0]
        let databaseRef = Database.database().reference().child("users").child(id)
        databaseRef.observe(.value, with: { (snapshot) in
            
            if !snapshot.exists() { return }
            
            //print(snapshot) // Its print all values including Snap (User)
            
            //print(snapshot.value!)
            
            navigationItem.title = String(describing: snapshot.childSnapshot(forPath: "name").value!)
            
            //print(username!)
            
            
        })
        //navigationItem.title = String(describing: sentTo)
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: "Back", style:   .plain, target: self, action: #selector(btn_clicked(_:)))
        
        //        let rightButton = UIBarButtonItem(title: "Right", style: .plain, target: self, action: nil)
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        //        navigationItem.rightBarButtonItem = rightButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
    }
//    func findUserWithId(_ id: String)  {
//        let databaseRef = Database.database().reference().child("users").child(id)
//        databaseRef.observe(.value, with: { (snapshot) in
//
//            if !snapshot.exists() { return }
//
//            //print(snapshot) // Its print all values including Snap (User)
//
//            //print(snapshot.value!)
//
//            self.sentTo = snapshot.childSnapshot(forPath: "name").value!
//
//            //print(username!)
//
//
//        })
//
//    }
    @objc func btn_clicked(_ sender: UIBarButtonItem) {
        // Do something
        //        performSegue(withIdentifier: "segueBackToHomeVC", sender: self)
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.senderId = User.current.uid
        self.senderDisplayName = User.current.name
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.senderId = User.current.uid
        self.senderDisplayName = User.current.name
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = User.current.uid
        self.senderDisplayName = User.current.name
        addNavBar()
        setupJSQMessagesViewController()
        tryObservingMessages()
    }
    
    
    
    deinit {
        messagesRef?.removeObserver(withHandle: messagesHandle)
    }
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        // 1
        //set the message to a variable
        let message = Message(content: text)
        // 2 send it
        sendMessage(message)
        // 3
        finishSendingMessage()
        
        // 4
        JSQSystemSoundPlayer.jsq_playMessageSentAlert()
    }
    
    func setupJSQMessagesViewController() {
        // 1. identify current user
        senderId = User.current.uid
        senderDisplayName = User.current.email
        title = chat.title
        
        // 2. remove attachment button
        inputToolbar.contentView.leftBarButtonItem = nil
        
        // 3. remove avatars
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
    }
    
    func tryObservingMessages() {
        chat.key = chat.memberHash
        guard let chatKey = chat?.key else { return }
        messagesHandle = ChatService.observeMessages(forChatKey: chatKey, completion: { [weak self] (ref, message) in
            self?.messagesRef = ref
            
            if let message = message {
                self?.messages.append(message)
                self?.finishReceivingMessage()
            } 
        })
    }
    
}

extension ChatViewController {
    // 1
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    // 2
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    // 3
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item].jsqMessageValue
    }
    
    // 4
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        let sender = message.sender
        
        if sender.uid == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    // 5
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = messages[indexPath.item]
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        cell.textView?.textColor = (message.sender.uid == senderId) ? .white : .black
        
        return cell
    }
    
}
extension ChatViewController {
    func sendMessage(_ message: Message) {
        // 1
        if chat?.key == nil {
            // 2
            ChatService.create(from: message, with: chat, completion: { [weak self] chat in
                guard let chat = chat else { return }
                
                self?.chat = chat
                
                // 3
                self?.tryObservingMessages()
            })
        } else {
            // 4
            ChatService.sendMessage(message, for: chat)
        }
    }
}
