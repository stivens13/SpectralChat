
//  Userservice.swift
//  SpeactralChatProto
//
//  Created by John Mai on 1/30/18.
//  Copyright © 2018 Nikita Voloshenko. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseDatabase.FIRDataSnapshot
struct UserService {
    
    static func observeChats(for user: User = User.current, withCompletion completion: @escaping (DatabaseReference, [Chat]) -> Void) -> DatabaseHandle {
        let ref = Database.database().reference().child("chats").child(user.uid!)
        
        return ref.observe(.value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion(ref, [])
            }
            
            let chats = snapshot.flatMap(Chat.init)
            completion(ref, chats)
        })
    }
}
