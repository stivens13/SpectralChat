//
//  DatabaseProvider.swift
//  SpeactralChatProto
//
//  Created by John Mai on 11/3/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class DatabaseProvider {
    
    private static let _instance = DatabaseProvider();
    
    private init() {
    }
    
    static var Instance: DatabaseProvider {
        return _instance;
    }
    
    var reference: DatabaseReference {
        return Database.database().reference();
    }
    
    var contactRef: DatabaseReference {
        return reference.child(Constants.CONTACTS);
    }
    
    var messageRef: DatabaseReference {
        return reference.child(Constants.MESSAGES);
    }
    var mediaMessageRef: DatabaseReference {
        return reference.child(Constants.MEDIA_MESSAGES);
    }

    var storageRef: StorageReference {
        return Storage.storage().reference(forURL: "https://ios-spectral.firebaseio.com/");
    }
    var imageRef: StorageReference {
        return storageRef.child(Constants.IMAGE_STORAGE);
    }
    
    var videoStorage: StorageReference {
        return storageRef.child(Constants.IMAGE_STORAGE);
    }
    
    func saveInfo(withID: String, email: String, password: String) {
        let data: Dictionary<String,Any> = [Constants.EMAIL: email, Constants.PASSWORD: password];
        contactRef.child(withID).setValue(data);
    }
    
    

    
}
