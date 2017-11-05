//
//  LoginViewController.swift
//  SpeactralChatProto
//
//  Created by Nikita Voloshenko on 10/27/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import UIKit

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import JSQMessagesViewController

class LoginViewController:UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_send: AnyObject) {
        //check if it is empty
        if userNameTextField.text == "" && passwordTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter valid account credentials", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            //if not empty, then check the credentials
        } else {
        //FIRAuth has been renamed to Auth
//            Auth.auth().createUser(withEmail: userNameTextField.text!, password: passwordTextField.text!) {
//                (user,error) in
//                if error == nil {
//                    print("Login successful")
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Message")
//                    self.present(vc!, animated: true, completion: nil)
//
//                } else {
//                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
//                    let action = UIAlertAction(title: "Success", style: .cancel, handler: nil)
//                    alert.addAction(action)
//                    self.present(alert,animated: true, completion: nil)
//                }
//            }
            Auth.auth().signIn(withEmail: userNameTextField.text!, password: passwordTextField.text!) {
                (user,error) in
                if error == nil {
                    print("Login Successful")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Message")
                    self.present(vc!,animated:true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Success", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true, completion: nil)
                }
        
            }
            
        }
    }
    
    func isLoggedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true;
        }
        return false;
    }
    
    @IBAction func signUp(_ sender: Any) {
        if userNameTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: userNameTextField.text!, password: passwordTextField.text!) {
                (user,error) in
                if error == nil {
                    print("Successful")
                } else {
                    print("error")
                }
            }
        }
    }
    
    
//    func login(withEmail: String, password: String, loginHandler: nil) {
//        Auth.auth().signIn(withEmail: withEmail, password: password, completion: { (user,error) in
//            if error != nil {
//                self.handleErrors(err: error as! NSError, loginHandler: nil);
//            } else {
//                //loginHandler?(nil);
//
//            }
//        });
//    }
}

