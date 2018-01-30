//
//  User.swift
//  SpeactralChatProto
//
//  Created by John Mai on 1/8/18.
//  Copyright © 2018 Nikita Voloshenko. All rights reserved.
//

import UIKit
import FirebaseDatabase
class User: NSObject {
    var username: String?
    var name: String?
    var email: String?
    var uid: String?
    
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    private static var _current: User?
    
    // 2
    static var current: User {
        // 3
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        // 4
        return currentUser
    }
    
    // MARK: - Class Methods
    
    // 5
    static func setCurrent(_ user: User) {
        _current = user
    }
    
}
