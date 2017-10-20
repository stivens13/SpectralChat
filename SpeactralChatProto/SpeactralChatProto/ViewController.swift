//
//  ViewController.swift
//  SpeactralChatProto
//
//  Created by Nikita Voloshenko on 10/20/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func handleSend(sender: AnyObject) {
        let ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("message").setValue(textField.text)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let ref: DatabaseReference!
//        let ref = Database.database().reference()
//        ref.observeEventType
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

