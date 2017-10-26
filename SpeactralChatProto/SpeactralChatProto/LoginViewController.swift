//
//  LoginViewController.swift
//  SpeactralChatProto
//
//  Created by John Mai on 10/24/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class LoginViewController:UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginAction(_send: AnyObject) {
        //check if it is empty
        if userNameTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter valid account credentials", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        //if not empty, then check the credentials
        } else {
            //FIRAuth has been renamed to Auth
            Auth.auth().createUser(withEmail: userNameTextField.text!, password: passwordTextField.text!) {
                (user,error) in
                if error == nil {
                    print("Login successful")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Success", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true, completion: nil)
                }
            }
        }
    }
}
