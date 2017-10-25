//
//  ViewController.swift
//  SpeactralChatProto
//
//  Created by Nikita Voloshenko on 10/20/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    
    @IBAction func updateSend(_ sender: Any) {
        let ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child("user").setValue(textField.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

