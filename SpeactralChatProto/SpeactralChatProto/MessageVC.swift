//
//  MessageVC.swift
//  SpeactralChatProto
//
//  Created by John Mai on 11/17/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MessageVC: UIViewController {
    
    var recipient: String!
    var messageId: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference(fromURL: "https://ios-spectral.firebaseio.com/")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
