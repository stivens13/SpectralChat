//
//  LoginViewController.swift
//  SpeactralChatProto
//
//  Created by Nikita Voloshenko on 10/27/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import UIKit
import Foundation
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

            Auth.auth().signIn(withEmail: userNameTextField.text!, password: passwordTextField.text!) {
                (user,error) in
                if error == nil {
                    print("Login Successful")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Conversations")
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
    
//    @IBAction func pressed(_send: UIButton) {
//        //check if it is empty
//        if userNameTextField.text == "" && passwordTextField.text == "" {
//            let alert = UIAlertController(title: "Error", message: "Please enter valid account credentials", preferredStyle: .alert)
//            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
//            alert.addAction(action)
//            present(alert, animated: true, completion: nil)
//            //if not empty, then check the credentials
//        } else {
//            //FIRAuth has been renamed to Auth
//
//            Auth.auth().createUser(withEmail: userNameTextField.text!, password: passwordTextField.text!) {
//                (user,error) in
//                if error == nil {
//                    let email = self.userNameTextField.text!
//                    print("SignUp Successful")
//
//                    guard let uid = user?.uid else {
//                        return
//                    }
//                    let ref = Database.database().reference(fromURL: "https://ios-spectral.firebaseio.com/")
//                    let values = ["email": email]
//                    //store the user information under a unique id that is assigned by firebase.
//                    let usersReference = ref.child("users").child(uid)
//                    usersReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
//                        if err != nil {
//                            print(err)
//                            return
//                        }
//
//                        print("success")
//                    })
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
//                    self.present(vc!,animated:true, completion: nil)
//                } else {
//                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
//                    let action = UIAlertAction(title: "Success", style: .cancel, handler: nil)
//                    alert.addAction(action)
//                    self.present(alert,animated: true, completion: nil)
//                }
//
//            }
//
//        }
//    }
    
    //check whether the user is logged in
//    func isLoggedIn() -> Bool {
//        if Auth.auth().currentUser != nil {
//            return true;
//        }
//        return false;
//    }
    
    
}

